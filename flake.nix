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
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
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
  in
  inputs.nixpkgs.lib.attrsets.recursiveUpdate
  {
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
  }
  (
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell
        {
          packages = [
            pkgs.sops
            pkgs.ssh-to-age
          ];

          shellHook = ''
            export SOPS_AGE_KEY_FILE=$HOME/.config/sops/age/keys.txt
          '';
        };
      }
    )
  );
}
