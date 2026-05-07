{
  description = "A collection of flake templates written in idiomatic nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    {
      templates = {
        devshell.path = ./devshell;
      };
    };
}
