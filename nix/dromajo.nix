{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "dromajo";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "chipsalliance";
    repo = "dromajo";
    rev = "v${version}";
    hash = "sha256-gZRj4L9q4Lq0zVSaFQuXnNqfArCM/0y/Zh4Pmzl5/6U=";
  };

  enableParallelBuilding = true;

  postPatch = ''
    substituteInPlace src/Makefile --replace /usr/local/bin $out/bin
  '';

  preBuild = ''
    cd src
  '';

  preInstall = ''
    mkdir -p $out/{bin,lib,include}
  '';

  postInstall = ''
    cp *.h $out/include
    mv $out/bin/*.a $out/lib
  '';

  meta = with lib; {
    description = "RISC-V RV64GC emulator designed for RTL co-simulation";
    homepage = "https://github.com/chipsalliance/dromajo";
    license = with licenses; [ mit ];
  };
}
