{ stdenv, lib, fetchurl, ocamlPackages, mpfr, ppl }:

stdenv.mkDerivation rec {
  pname = "jasmin-compiler";
  version = "2022.09.3";

  src = fetchurl {
    url = "https://github.com/jasmin-lang/jasmin/releases/download/v${version}/jasmin-compiler-v${version}.tar.bz2";
    hash = "sha256-CCLUF3GDeQrWIur1ve19WveNiOR/6kRVWuU7wvmXGGg=";
  };

  sourceRoot = "jasmin-compiler-v${version}/compiler";

  nativeBuildInputs = with ocamlPackages; [ ocaml findlib ocamlbuild menhir camlidl ];

  buildInputs = [
    mpfr
    ppl
  ] ++ (with ocamlPackages; [
    apron
    batteries
    menhirLib
    yojson
    zarith
  ]);

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp jasminc.native $out/bin/jasminc
    runHook postInstall
  '';

  meta = {
    description = "A workbench for high-assurance and high-speed cryptography";
    homepage = "https://github.com/jasmin-lang/jasmin/";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.vbgl ];
    mainProgram = "jasminc";
    platforms = lib.platforms.all;
  };
}
