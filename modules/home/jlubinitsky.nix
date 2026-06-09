{ config, ... }:
{
  flake.modules.homeManager.jlubinitsky =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.homeManager; [
        base
      ];

      home.packages = [ pkgs.python311 ];
    };
}
