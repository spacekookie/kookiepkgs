{ config, lib, pkgs, ... }:

with lib;
let
  kookiepkgs = import <kookiepkgs> {};
  cfg = config.services.pleroma;
  mixProject = import ./hex-packages.nix cfg.package;
  blop = pkgs.callPackage mixProject {};

  pleromaPkg = pkgs.stdenv.mkDerivation rec {
    name = "pleroma";
    nativeBuildInputs = with pkgs; [ blop elixir erlang ];
    src = cfg.package;
    installPhase = ''
      mix deps.get
    '';
  };
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
