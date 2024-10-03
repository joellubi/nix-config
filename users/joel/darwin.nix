{ inputs, ... }:

{ pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks  = [
      "google-chrome"
      "logi-options+"
      "slack"
      "spotify"
      "zoom"
    ];
    onActivation.cleanup = "uninstall";
  };

  users.users.joel = {
    home = "/Users/joel";
  };
}
