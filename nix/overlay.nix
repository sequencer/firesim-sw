final: prev:

{
  dromajo = final.callPackage ./dromajo.nix {};
  testchipip-h = final.callPackage ./testchipip-h.nix {};
}
