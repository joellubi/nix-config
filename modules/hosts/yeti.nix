{ config, inputs, ... }:
let
  inherit (config.flake.modules) darwin homeManager;
in
{
  flake.darwinConfigurations.yeti = inputs.darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [
      darwin.nixpkgs
      darwin.system-base
      darwin.secrets
      darwin.jlubinitsky
      inputs.home-manager.darwinModules.home-manager
      {
        networking.hostName = "yeti";

        # We install Nix using a separate installer (Determinate) so we don't
        # want nix-darwin to manage it for us.
        nix.enable = false;

        security.pam.services.sudo_local.touchIdAuth = true;

        system.stateVersion = 5;
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Home Manager.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.jlubinitsky = {
          imports = [ homeManager.jlubinitsky ];
          modules.just = {
            machine = "yeti";
            darwin = true;
          };
        };
      }
    ];
  };
}
