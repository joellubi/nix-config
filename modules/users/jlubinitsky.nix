{ ... }:
let
  userName = "jlubinitsky";

  # Self-contained per-user sops (duplicated rather than shared, so this file
  # can move to a private repo cleanly in a later migration).
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
        "ghostty"
        "logi-options+"
        "nikitabobko/tap/aerospace"
        "spotify"
      ];
      onActivation.cleanup = "uninstall";
    };
  };
}
