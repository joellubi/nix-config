{ config, ... }:
{
  flake.modules.homeManager.joel =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        base
      ];
    };
}
