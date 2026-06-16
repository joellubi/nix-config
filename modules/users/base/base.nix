{ config, lib, ... }:
{
  options = {
    user.name = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Name of the user. Base user config is disabled if not provided.";
    };

    user.fullName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Full name of the user. Git config is disabled if unset.";
    };

    user.email = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Email of the user. Git config is disabled if unset.";
    };
  };

  config =
    let
      cfg = config.user;
      shouldCreateGitConfig = cfg.fullName != null && cfg.email != null;

      home =
        { pkgs, lib, ... }:
        {
          hjem.users.${cfg.name}.files = {
            ".config/ghostty/config".source = ./dotfiles/ghostty;
          }
          // lib.optionalAttrs shouldCreateGitConfig {
            ".config/git/config" = {
              generator = lib.generators.toGitINI;
              value = {
                user = {
                  name = cfg.fullName;
                  email = cfg.email;
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
      mkPackages =
        pkgs: with pkgs; [
          git
          ghostty
        ];
    in
    lib.mkIf (cfg.name != null) {

      flake.modules.nixos.${cfg.name} =
        { pkgs, ... }:
        let
          homeDirectory = "/home/${cfg.name}";
        in
        {
          imports = [ home ];

          users.users.${cfg.name} = {
            home = homeDirectory;
            packages = mkPackages pkgs;
          };
          hjem.users.${cfg.name}.directory = homeDirectory;
        };

      flake.modules.darwin.${cfg.name} =
        { pkgs, ... }:
        let
          homeDirectory = "/Users/${cfg.name}";
        in
        {
          imports = [ home ];

          users.users.${cfg.name} = {
            name = cfg.name;
            home = homeDirectory;
            packages = mkPackages pkgs;
          };

          system.primaryUser = cfg.name;
          system.defaults = {
            dock.autohide = true;
            NSGlobalDomain = {
              KeyRepeat = 2;
              InitialKeyRepeat = 15;
              ApplePressAndHoldEnabled = false;
            };
          };

          hjem.users.${cfg.name}.directory = homeDirectory;
        };

    };
}
