{
  description = "Minimal rust flake with nightly toolchain and caching";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    naersk.url = "github:nix-community/naersk";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      fenix,
      naersk,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      toolchain = fenix.packages.${system}.default.toolchain;
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          toolchain
          fenix.packages.${system}.rust-analyzer
        ];
      };

      packages.${system}.default =
        (naersk.lib.${system}.override {
          cargo = toolchain;
          rustc = toolchain;
        }).buildPackage
          {
            src = ./.; # points to the same folder as cargo.toml & cargo.lock
          };
    };
}
