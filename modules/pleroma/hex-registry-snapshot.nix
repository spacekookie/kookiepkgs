{ fetchFromGitHub, writeText, stdenv }:

stdenv.mkDerivation rec {
  name = "hex-registry-pleroma-0.9.0";
  rev = "a86d645451da34c8879181fa573b967387655b60";

  src = fetchFromGitHub {
    inherit rev;
    owner = "spacekookie";
    repo = "hex-pm-registry-snapshots";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  installPhase = ''
    mkdir -p "$out/var/hex"
    zcat "registry.ets.gz" > "$out/var/hex/registry.ets"
  '';

  setupHook = writeText "setupHook.sh" ''
    export HEX_REGISTRY_SNAPSHOT="$1/var/hex/registry.ets"
  '';

}

