{ inputs, ... }:

{ pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks  = [
      "autodesk-fusion"
      "bambu-studio"
      "google-chrome"
      "logi-options+"
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

  system.primaryUser = "joel";
}
