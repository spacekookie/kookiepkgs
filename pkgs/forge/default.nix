{ stdenv, lib, fetchFromGitLab, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "forge-${version}";
  version = "0.1.0";

  src = fetchFromGitLab {
    owner = "spacekookie";
    repo = "forge";
    rev = version;
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  cargoSha256 = "0000000000000000000000000000000000000000000000000000";

  meta = with lib; {
    description = "Build automation tool for NixOS";
    license = licenses.agpl;
    maintainers = [ maintainers.spacekookie ];
    platforms = platforms.all;
  };
}

