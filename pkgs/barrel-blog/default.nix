{ stdenv, fetchFromGitHub, pkgs, ... }:

let
  json = with builtins; fromJSON (readFile ./meta.json);
  master = json.rev;
  masterSha256 = json.sha256;
in
  stdenv.mkDerivation rec {
    name = "barrel-blog";

    src = fetchFromGitHub {
      owner = "spacekookie";
      repo = "barrel";
      rev = master;
      sha256 = masterSha256;
    }; 

    buildInputs = with pkgs.pythonPackages; [ pelican webassets markdown ];

    installPhase = ''
      cd docs/
      pelican content
      cp -rv output $out
    '';

    meta = with stdenv.lib; {
      description = "A static website running on https://barrel.spacekookie.de";
      homepage = "https://barrel.spacekookie.de";
      license = licenses.mit;
    };
  }

