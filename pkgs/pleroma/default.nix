{ stdenv, lib, pkgs, fetchFromGitLab, ... }:

stdenv.mkDerivation rec {
  name = "pleroma-${version}";
  version = "0.9.0";

  src = fetchFromGitLab rec {
    domain = "git.pleroma.social";
    owner = "pleroma";
    repo = "pleroma";
    rev = "v${version}";
    sha256 = "1k33h3j67ywrmkrjr1hvb53j3zsvszb4rfraak1vsh7jn4j6a0wl";
  };

  installPhase = ''
    cp -r $src $out
  '';

  meta = with lib; {
    description = "A free, federated social networking server built on open protocols";
    license = licenses.agpl3;
    maintainers = [ maintainers.spacekookie ];
    platforms = platforms.all;
  };
}
