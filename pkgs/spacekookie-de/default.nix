{ stdenv, fetchFromGitHub, nix-prefetch-github, pkgs, ... }:

let
  json = with builtins; fromJSON (readFile ./meta.json);
  master = json.rev;
  masterSha256 = json.sha256;
in
  stdenv.mkDerivation rec {
    name = "spacekookie.de";

    src = fetchFromGitHub {
      owner = "spacekookie";
      repo = "website";
      rev = master;
      sha256 = masterSha256;
    }; 

    buildInputs = with pkgs.pythonPackages; [ pelican webassets markdown ];

    installPhase = ''
      pelican content
      cp -rv output $out
    '';

    meta = with stdenv.lib; {
      description = "The `about` and `blog` part of spacekookie.de";
      homepage = "https://spacekookie.de";
      license = licenses.mit;
    };
  }

