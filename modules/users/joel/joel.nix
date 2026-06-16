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
  user = {
    name = userName;
    fullName = fullName;
    email = email;
  };

  flake.modules.nixos.${userName} =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.nixos; [
        base
        home
      ];
      users.users.${userName} = {
        isNormalUser = true;
        description = "Joel Lubinitsky"; # Is this needed?
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.zsh;
      };
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
