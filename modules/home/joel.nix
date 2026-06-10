{ config, ... }:
{
  flake.modules.homeManager.joel =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        base
        gnome
      ];

      modules.gnome.enable = pkgs.stdenv.isLinux;
    };
}
