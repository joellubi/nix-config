{ inputs, ... }:

{ pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks  = [
      "logi-options+"
      "spotify"
    ];
    onActivation.cleanup = "uninstall";
  };

  users.users.jlubinitsky = {
    home = "/Users/jlubinitsky";
  };

  system.primaryUser = "jlubinitsky";
}
