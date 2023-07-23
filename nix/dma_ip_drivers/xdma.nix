{ lib
, stdenv
, fetchFromGitHub
, kernel
}:

stdenv.mkDerivation {
  pname = "xdma-${kernel.version}";
  version = "unstable-2023-07-18";

  src = fetchFromGitHub {
    owner = "cyyself";
    repo = "dma_ip_drivers";
    rev = "809834b6e660ddfaa8051b4d1db2b04115e77ec3";  # branch fix-mainline
    hash = "sha256-KR/LyJ36tf+V1CaCcn2fTe3SnsDPeDwiQEIU/CI0UWA=";
  };

  sourceRoot = "source/XDMA/linux-kernel/xdma";
  hardeningDisable = [ "pic" "format" ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  enableParallelBuilding = true;

  makeFlags = [
    "INSTALL_MOD_PATH=$(out)"
    "BUILDSYSTEM_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  meta = with lib; {
    description = "Xilinx QDMA IP Drivers";
    homepage = "https://github.com/cyyself/dma_ip_drivers";
    license = with licenses; [ bsd3 ];
    platforms = platforms.linux;
  };
}
