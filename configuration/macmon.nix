{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "macmon";
  version = "0.8.0";

  src = fetchurl {
    url = "https://github.com/vladkens/macmon/releases/download/v${finalAttrs.version}/macmon-v${finalAttrs.version}.tar.gz";
    hash = "sha256-438v2y+w/feye/ABWQBrrFG2x7f+9KO1Qzox2wYgAs8=";
  };
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -Dm755 macmon "$out/bin/macmon"
    runHook postInstall
  '';

  meta = {
    description = "Sudoless performance monitoring for Apple Silicon processors";
    homepage = "https://github.com/vladkens/macmon";
    license = lib.licenses.mit;
    platforms = ["aarch64-darwin"];
    mainProgram = "macmon";
    sourceProvenance = [lib.sourceTypes.binaryNativeCode];
  };
})
