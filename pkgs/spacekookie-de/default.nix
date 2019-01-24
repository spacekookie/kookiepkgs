{ stdenv, fetchFromGitHub, pkgs, ... }:

stdenv.mkDerivation rec {
  version = "2019-01-24";
  name = "spacekookie.de";

  src = fetchFromGitHub {
    owner = "spacekookie";
    repo = "website";
    rev = version;
    sha256 = "1x7qjwdn7hipx7y1xbb60227fxn99a37knhqqjwcgq22pb4fmbnm";
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

