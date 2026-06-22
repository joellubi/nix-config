{ config, inputs, ... }:
let
  pc = modules: {
    imports = [
      modules.nixpkgs
      modules.system-base
      modules.secrets
      modules.keybinds
      inputs.home-manager.darwinModules.home-manager
      inputs.hjem.darwinModules.default
    ];
  };

  inherit (config.flake.modules) nixos darwin;
in
{
  flake.modules.nixos.pc = pc nixos;
  flake.modules.darwin.pc = pc darwin;
}
