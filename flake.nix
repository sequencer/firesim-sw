{
  description = "firesim-sw";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }@inputs:
    let
      overlay = import ./nix/overlay.nix;
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
            config.permittedInsecurePackages = [
              "libdwarf-20210528"
            ];
          };
          deps = with pkgs; [
            wget

            gcc

            gmp
            libelf
            libdwarf_20210528
            dromajo
            spike
            testchipip-h
          ];
        in
        {
          legacyPackages = pkgs;
          devShell = pkgs.mkShell {
            buildInputs = deps;
            shellHook = ''
              export SPIKE_PATH=${pkgs.spike}
              export DROMAJO_PATH=${pkgs.dromajo}
              export TESTCHIPIP_PATH=${pkgs.testchipip-h}
            '';
          };
        }
      )
    // { inherit inputs; overlays.default = overlay; };
}
