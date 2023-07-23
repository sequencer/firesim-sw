final: prev:

{
  dromajo = final.callPackage ./dromajo.nix {};
  testchipip-h = final.callPackage ./testchipip-h.nix {};

  xdma = final.linuxPackages.callPackage ./dma_ip_drivers/xdma.nix { };
  xvsec = final.linuxPackages.callPackage ./dma_ip_drivers/xvsec.nix { };
}
