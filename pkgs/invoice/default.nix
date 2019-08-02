{ stdenv, makeWrapper, coreutils, pandoc, gnumake, texlive }:

stdenv.mkDerivation {
  pname = "invoice";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/{bin,share}
    cp invoice.sh $out/bin/invoice
    cp template.tex $out/share/

    wrapProgram $out/bin/invoice \
      --set PATH $out/bin:${stdenv.lib.makeBinPath
        [ coreutils pandoc gnumake texlive.combined.scheme-full ]} \
      --set TEMPLATE_FILE $out/share/template.tex
  '';


  meta = with stdenv.lib; {
    description = "Generate dynamic invoices based on yaml descriptors";
    homepage = "https://git.sr.ht/~spacekookie/kookiepkgs/";
    license = licenses.gpl3;
  };
}
