{ ... }:
let
  userName = "joel";

  home =
    { pkgs, lib, ... }:
    {
      hjem.users.${userName}.files = {
        ".config/ghostty/config".source = ./dotfiles/ghostty;
        ".pi/agent/AGENTS.md".source = ./dotfiles/pi-agent-AGENTS.md;
        ".config/git/config" = {
          generator = lib.generators.toGitINI;
          value = {
            user = {
              name = "Joel Lubinitsky";
              email = "joellubi@gmail.com";
            };
            init.defaultBranch = "main";
            gpg = {
              format = "openpgp";
            };
            "gpg \"opengpg\"".program = pkgs.lib.getExe pkgs.gnupg;
          };
        };
      };
    };
in
{
  flake.modules.nixos.${userName} =
    { pkgs, ... }:
    {
      imports = [
        home
      ];
      users.users.${userName} = {
        isNormalUser = true;
        home = "/home/${userName}";
        description = "Joel Lubinitsky";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.zsh;
      };
      hjem.users.${userName}.directory = "/home/${userName}";
    };

  flake.modules.darwin.${userName} = {
    imports = [
      home
    ];
    users.users.${userName}.home = "/Users/${userName}";
    system.primaryUser = userName;
    system.defaults = {
      dock.autohide = true;
      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        ApplePressAndHoldEnabled = false;
      };
    };
    hjem.users.${userName}.directory = "/Users/${userName}";
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
  };
}
