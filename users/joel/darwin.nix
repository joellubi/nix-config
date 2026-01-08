{ inputs, ... }:

{ pkgs, ... }:

{
  homebrew = {
    enable = true;
    taps = [
      { name = "nikitabobko/tap"; }
    ];
    casks = [
      "autodesk-fusion"
      "bambu-studio"
      "ghostty"
      "google-chrome"
      "logi-options+"
      "nikitabobko/tap/aerospace"
      "openvpn-connect"
      "postgres-unofficial"
      "slack"
      "spotify"
      "superproductivity"
      "vmware-fusion"
      "zoom"
    ];
    onActivation.cleanup = "uninstall";
  };

  users.users.joel = {
    home = "/Users/joel";
  };

  system = {
    primaryUser = "joel";
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
