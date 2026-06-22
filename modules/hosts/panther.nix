{ config, inputs, ... }:
let
  inherit (config.flake.modules) darwin homeManager;
  system = "aarch64-darwin";
in
{
  flake.darwinConfigurations.panther = inputs.darwin.lib.darwinSystem {
    inherit system;
    modules = [
      darwin.pc
      darwin.joel
      {
        networking.hostName = "panther";

        security.pam.services.sudo_local.touchIdAuth = true;

        system.stateVersion = 5;
        nixpkgs.hostPlatform = system;

        # Home Manager.
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.joel = {
          imports = [ homeManager.joel ];
        };
      }
    ];
  };
}
