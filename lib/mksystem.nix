{ inputs, overlays, self }:

{
  system,
  machine,
  user,
  darwin ? false,
}:

let
  # The config files for this system.
  machineConfig = import ./mkmachine.nix machine;
  userOSConfig = import ../users/${user}/${if darwin then "darwin" else "nixos" }.nix { inherit inputs; };
  userHMConfig = import ../users/${user}/home-manager.nix { inherit inputs; };

  # NixOS vs nix-darwin functions
  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else inputs.nixpkgs.lib.nixosSystem;
  home-manager = if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
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
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = userHMConfig;
    }
  ];
}
