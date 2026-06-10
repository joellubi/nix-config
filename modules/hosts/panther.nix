{ config, inputs, ... }:
let
  inherit (config.flake.modules) darwin homeManager;
in
{
  flake.darwinConfigurations.panther = inputs.darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [
      darwin.nixpkgs
      darwin.system-base
      darwin.secrets
      darwin.joel
      inputs.home-manager.darwinModules.home-manager
      inputs.hjem.darwinModules.default
      {
        networking.hostName = "panther";

        security.pam.services.sudo_local.touchIdAuth = true;

        system.stateVersion = 5;
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Home Manager.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.joel = {
          imports = [ homeManager.joel ];
          modules.just = {
            machine = "panther";
            darwin = true;
          };
        };
      }
    ];
  };
}
