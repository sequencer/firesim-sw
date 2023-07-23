{ lib
, stdenv
, xdma  # share the same src
, kernel
}:

stdenv.mkDerivation {
  pname = "xvsec-${kernel.version}";
  version = "unstable-2023-07-18";

  inherit (xdma) src;

  sourceRoot = "source/XVSEC/linux-kernel";
  hardeningDisable = [ "pic" "format" ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  enableParallelBuilding = true;

  makeFlags = [
    "kernel_install_path=$(out)/lib/modules/${kernel.modDirVersion}/extra"
    "dev_install_path=$(out)/include"
    "user_install_path=$(out)/bin"
  ];

  preConfigure = ''
    substituteInPlace drv/Makefile \
      --replace '/lib/modules/$(XVSEC_KVER)/build' '${kernel.dev}/lib/modules/${kernel.modDirVersion}/build' \
      --replace '-I$(PWD)' "-I$PWD/drv"
    substituteInPlace Makefile --replace 'app :' 'app: libxvsec'
  '';

  meta = with lib; {
    description = "Xilinx QDMA IP Drivers";
    homepage = "https://github.com/cyyself/dma_ip_drivers";
    license = with licenses; [ bsd3 ];
    platforms = platforms.linux;
  };
}
