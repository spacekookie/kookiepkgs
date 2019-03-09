{ config, lib, pkgs, ... }:

with lib;
let
  kookiepkgs = import <kookiepkgs> {};
  inherit (callPackage (fetchGit {
    url = https://gitlab.com/transumption/mix-to-nix;
    rev = "69b74f9e18582595284dd8f13aaaaafa68eb97c0";
  }) {}) mixToNix;

  config = pkgs.writeText "prod.secret.exc" ''
    use Mix.Config

    config :pleroma, Pleroma.Repo,
      adapter: Ecto.Adapters.Postgres
  '';

  cfg = config.services.pleroma;

  pleromaPkg = (mixToNix {
    src = stdenv.mkDerivation {
      name = "pleroma";
      src = fetchGit {
        url = https://git.pleroma.social/pleroma/pleroma;
        rev = "3879500c87829a5cf1377ca7ccdb7bf92c75367f";
      };

      buildCommand = ''
        cp --no-preserve=mode -r $src $out
        # Fork with v1.4 as HEAD branch, see:
        # https://github.com/NixOS/nix/pull/2409
        substituteInPlace $out/mix.lock \
          --replace phoenixframework/phoenix yegortimoshenko/phoenix
        cp ${cfg.config} $out/config/prod.secret.exs
      '';
    };

    overlay = final: previous: {
      cowlib = previous.cowlib.overrideAttrs (super: {
        postPatch = ''
          substituteInPlace src/cow_multipart.erl \
            --replace crypto:rand_bytes crypto:strong_rand_bytes
        '';
      });
    };
  }).overrideAttrs (super: {
    doCheck = false;
  });
in
  {
    options = {
      services.pleroma = {
        enable = mkEnableOption "pleroma";

        package = mkOption {
          type = types.package;
          default = kookiepkgs.pleroma;
          description = "Path to the pleroma sources";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = [ pleromaPkg ];
    };
  }
