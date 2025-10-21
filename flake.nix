{
  description = "NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs: let
    # Overlays is the list of overlays we want to apply from flake inputs.
    overlays = [
      (final: prev: rec {
        #go = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.go_1_25;
      })
    ];

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

    darwinConfigurations.yeti = mkSystem {
      machine = "yeti";
      user   = "jlubinitsky";
      system = "aarch64-darwin";
      darwin = true;
    };
  };
}
