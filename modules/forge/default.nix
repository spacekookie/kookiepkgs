{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.forge;
in
  {
    options = {
      services.forge = {
        enable = mkEnableOption "forge";

        package = mkOption {
          type = types.path;
          default = pkgs.forge;
          description = "Path to the forge sources";
        };

        bind = mkOption {
          type = types.str;
          default = "0.0.0.0";
          description = "Address to bind forge server to";
        };

        port = mkOption {
          type = types.integer;
          default = 12220;
          description = "The port to bind the (internal) forge server to";
        };

        route = mkOption {
          type = types.str;
          default = "/rebuild";
          description = "The HTTP route to listen to";
        };

        tokenHash = mkOption {
          type = types.str;
          default = null;
          description = ''
            Your CI will use a token to send to the forge server as a secret.
            This secret is used as a key to secure other secrets.

            In order to verify the validity of an incoming request, forge
            uses a salted SHA256 hash of the secret. You can use `forge-cli`
            to generate this hash.
          '';
        };
      };
    };

    config = mkIf cfg.enable {

    };
  }

