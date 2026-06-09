{ ... }:
let
  userName = "joel";

  # Per-user sops: age keyFile, email secret, and a gitconfig include template.
  # Lives with the user (not modules/secrets.nix) because it depends on the
  # user's home directory and username.
  secrets =
    { config, ... }:
    {
      sops.age.keyFile = "${config.users.users.${userName}.home}/.config/sops/age/keys.txt";
      sops.secrets."${userName}/email" = { };
      sops.templates.gitconfig = {
        owner = config.users.users.${userName}.name;
        path = "${config.users.users.${userName}.home}/.config/secure/config.inc";
        content = ''
          [user]
                  email = "${config.sops.placeholder."${userName}/email"}"
        '';
      };
    };
in
{
  flake.modules.nixos.${userName} =
    { pkgs, ... }:
    {
      imports = [ secrets ];
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
    };

  flake.modules.darwin.${userName} = {
    imports = [ secrets ];
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
