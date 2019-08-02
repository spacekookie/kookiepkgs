{ stdenv, pandoc, gnumake, texlive }:

stdenv.mkDerivation {
  pname = "invoice";
  version = "0.1.0";
  src = ./.;

  buildInputs = [ pandoc gnumake texlive.combined.scheme-full ];
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    cp invoice.sh $out/bin/
    cp template.tex $out/share/
  '';

  meta = with stdenv.lib; {
    description = "Generate dynamic invoices based on yaml descriptors";
    homepage = "https://git.sr.ht/~spacekookie/kookiepkgs/";
    license = licenses.gpl3;
  };
}
