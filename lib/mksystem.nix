{ inputs, overlays, self }:

{
  system,
  machine,
  user,
  darwin ? false,
}:

let
  # The config files for this system.
  secretsConfig = import ./mksecrets.nix user;
  machineConfig = import ./mkmachine.nix machine;
  userOSConfig = import ../users/${user}/${if darwin then "darwin" else "nixos" }.nix { inherit inputs; };
  userHMConfig = import ../users/${user}/home-manager.nix { inherit inputs machine; };

  # NixOS vs nix-darwin functions
  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else inputs.nixpkgs.lib.nixosSystem;
  home-manager = if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
  sops-nix = if darwin then inputs.sops-nix.darwinModules.sops else inputs.sops-nix.nixosModules.sops;
in systemFunc rec {
  inherit system;

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    { nixpkgs.overlays = overlays; }

    {
      # Set Git commit hash of the top-level flake that built the configuration
      system.configurationRevision = self.rev or self.dirtyRev or null;
    }

    machineConfig
    userOSConfig
    sops-nix
    secretsConfig
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = userHMConfig;
      home-manager.extraSpecialArgs = { inherit machine; };
    }
  ];

  specialArgs = { inherit inputs machine; };
}
