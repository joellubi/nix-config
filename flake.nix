{
  description = "NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # xremap-flake.url = "github:xremap/nix-flake";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs: let
    # Overlays is the list of overlays we want to apply from flake inputs.
    overlays = [];

    mkSystem = import ./lib/mksystem.nix {
      inherit inputs overlays self;
    };
  in {
    nixosConfigurations.baboon = mkSystem {
      machine = "baboon";
      user    = "joel";
      system  = "x86_64-linux";
    };

    darwinConfigurations.panther = mkSystem {
      machine = "panther";
      user   = "joel";
      system = "aarch64-darwin";
      darwin = true;
    };
  };
}