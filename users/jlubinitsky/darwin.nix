{ inputs, ... }:

{ pkgs, ... }:

{
  homebrew = {
    enable = true;
    taps = [
      { name = "nikitabobko/tap"; }
    ];
    casks = [
      "ghostty"
      "logi-options+"
      "nikitabobko/tap/aerospace"
      "spotify"
    ];
    onActivation.cleanup = "uninstall";
  };

  users.users.jlubinitsky = {
    home = "/Users/jlubinitsky";
  };

  system = {
    primaryUser = "jlubinitsky";
    defaults = {
      dock.autohide = true;
      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        ApplePressAndHoldEnabled = false;
      };
    };
  };
}
