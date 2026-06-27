{ config, lib, ... }:
with lib;
{
  options.users = mkOption {
    type = types.attrsOf (
      types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            default = "";
            description = "Full name of the user. Git config is disabled if unset.";
          };
          email = mkOption {
            type = types.str;
            default = "";
            description = "Email of the user. Git config is disabled if unset.";
          };
        };
      }
    );
    default = { };
  };

  config =
    let
      mkHome =
        name: cfg:
        { pkgs, lib, ... }:
        let
          shouldCreateGitConfig = cfg.name != "" && cfg.email != "";
        in
        {
          hjem.users.${name}.files =
            { }
            // lib.optionalAttrs shouldCreateGitConfig {
              ".config/git/config" = {
                generator = lib.generators.toGitINI;
                value = {
                  user = {
                    name = cfg.name;
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
        userName:
        { pkgs, lib, ... }:
        let
          isLinux = pkgs.stdenv.isLinux;
          isDarwin = pkgs.stdenv.isDarwin;
        in
        {
          users.users.${userName}.packages =
            with pkgs;
            [
              curl
              delve
              docker-compose
              ghostty
              duckdb
              git
              go
              gotools
              jq
              mitmproxy
              neovim
              nh
              nixd
              nixfmt-rfc-style
              oauth2c
              tree
              wget
            ]
            ++ (lib.optionals isLinux [
              xclip
              spotify
            ])
            ++ (lib.optionals isDarwin [
              iproute2mac
            ]);
        };
    in
    {

      flake.modules.nixos = mapAttrs (
        userName: userConfig:
        { pkgs, ... }:
        let
          homeDirectory = "/home/${userName}";
          homeFiles = mkHome userName userConfig;
          packages = mkPackages userName;
        in
        {
          imports = [
            homeFiles
            packages
          ];

          users.users.${userName} = {
            isNormalUser = true;
            description = userConfig.name;
            home = homeDirectory;
            extraGroups = [
              "networkmanager"
              "wheel"
            ];
            shell = pkgs.zsh;
          };
          hjem.users.${userName}.directory = homeDirectory;
        }
      ) config.users;

      flake.modules.darwin = mapAttrs (
        userName: userConfig:
        { pkgs, ... }:
        let
          homeDirectory = "/Users/${userName}";
          homeFiles = mkHome userName userConfig;
          packages = mkPackages userName;
        in
        {
          imports = [
            homeFiles
            packages
          ];

          users.users.${userName} = {
            name = userName;
            home = homeDirectory;
          };

          system.primaryUser = userName;
          system.defaults = {
            dock.autohide = true;
            NSGlobalDomain = {
              KeyRepeat = 2;
              InitialKeyRepeat = 15;
              ApplePressAndHoldEnabled = false;
            };
          };

          hjem.users.${userName}.directory = homeDirectory;
        }
      ) config.users;
    };
}
