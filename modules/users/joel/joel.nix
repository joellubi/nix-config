{ config, ... }:
let
  userName = "joel";
  fullName = "Joel Lubinitsky";
  email = "joellubi@gmail.com";

  home = {
    hjem.users.${userName}.files = {
      ".pi/agent/AGENTS.md".source = ./dotfiles/pi-agent-AGENTS.md;
    };
  };
in
{
  users.${userName} = {
    name = fullName;
    email = email;
  };

  flake.modules.nixos.${userName} = {
    imports = with config.flake.modules.nixos; [
      base
      home
    ];
  };

  flake.modules.darwin.${userName} = {
    imports = with config.flake.modules.darwin; [
      base
      home
    ];
    homebrew = {
      enable = true;
      taps = [
        { name = "nikitabobko/tap"; }
      ];
      casks = [
        "autodesk-fusion"
        "bambu-studio"
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
  };
}
