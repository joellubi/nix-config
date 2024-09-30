{ inputs, pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks  = [
      "spotify"
      "logi-options+"
      "zoom"
    ];
    onActivation.cleanup = "uninstall";
  };

  users.users.joel = {
    home = "/Users/joel";
  };
}
