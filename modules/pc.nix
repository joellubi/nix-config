{ config, inputs, ... }:
let
  pc = modules: imports: {
    imports = [
      modules.nixpkgs
      modules.system-base
      modules.secrets
      modules.keybinds
    ]
    ++ imports;
  };

  inherit (config.flake.modules) nixos darwin;
in
{
  flake.modules.nixos.pc = pc nixos [
    inputs.home-manager.nixosModules.home-manager
    inputs.hjem.nixosModules.default
  ];
  flake.modules.darwin.pc = pc darwin [
    inputs.home-manager.darwinModules.home-manager
    inputs.hjem.darwinModules.default
  ];
}
