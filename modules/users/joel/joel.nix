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
  packages =
    { pkgs, ... }:
    {
      users.users.${userName}.packages = with pkgs; [
        pi-coding-agent
        wireguard-tools
        zig
      ];
    };
in
{
  users.${userName} = {
    name = fullName;
    email = email;
  };

  flake.modules.nixos.${userName} = {
    imports = [
      home
      packages
    ];
  };

  flake.modules.darwin.${userName} = {
    imports = [
      home
      packages
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
