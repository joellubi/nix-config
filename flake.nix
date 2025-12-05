{
  description = "NixOS systems and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    { self, ... }@inputs:
    let
      # Overlays is the list of overlays we want to apply from flake inputs.
      overlays = [
        (final: prev: rec {
          neovim = self.packages.${prev.system}.neovim;
          #go = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.go_1_25;
        })
      ];

      mkSystem = import ./lib/mksystem.nix {
        inherit inputs overlays self;
      };
    in
    inputs.nixpkgs.lib.attrsets.recursiveUpdate
      {
        nixosConfigurations.baboon = mkSystem {
          machine = "baboon";
          user = "joel";
          system = "x86_64-linux";
        };

        darwinConfigurations.panther = mkSystem {
          machine = "panther";
          user = "joel";
          system = "aarch64-darwin";
          darwin = true;
        };

        darwinConfigurations.yeti = mkSystem {
          machine = "yeti";
          user = "jlubinitsky";
          system = "aarch64-darwin";
          darwin = true;
        };
      }
      (
        inputs.flake-utils.lib.eachDefaultSystem (
          system:
          let
            pkgs = inputs.nixpkgs.legacyPackages.${system};
          in
          {
            packages.neovim =
              (inputs.nvf.lib.neovimConfiguration {
                inherit pkgs;
                modules = [
                  (
                    { pkgs, ... }:
                    {
                      config.vim = {
                        lsp = {
                          enable = true;
                          formatOnSave = true;
                          lightbulb.enable = true;
                          trouble.enable = true;
                        };

                        debugger = {
                          nvim-dap = {
                            enable = true;
                            ui.enable = true;
                            mappings = {
                              stepBack = "<Left>";
                              stepInto = "<Down>";
                              stepOut = "<Up>";
                              stepOver = "<Right>";
                            };
                          };
                        };

                        languages = {
                          enableFormat = true;
                          enableTreesitter = true;
                          enableDAP = true;

                          nix = {
                            enable = true;
                            format.type = "nixfmt";
                            lsp = {
                              server = "nixd";
                              options = {
                                #   nixpkgs.expr = "import <nixpkgs> { }";
                                nix-darwin.expr = "(builtins.getFlake (toString ./.)).darwinConfigurations.yeti.options";
                                home-manager.expr = "(builtins.getFlake (toString ./.)).darwinConfigurations.yeti.users.type.getSubOptions []";
                              };
                            };
                          };
                          markdown.enable = true;
                          go.enable = true;
                          python.enable = true;
                        };

                        visuals = {
                          nvim-web-devicons.enable = true;
                          fidget-nvim.enable = true;
                          highlight-undo.enable = true;
                          indent-blankline.enable = true;
                        };

                        statusline = {
                          lualine = {
                            enable = true;
                            theme = "catppuccin";
                          };
                        };

                        theme = {
                          enable = true;
                          name = "catppuccin";
                          style = "mocha";
                        };

                        autopairs.nvim-autopairs.enable = true;
                        autocomplete.blink-cmp.enable = true;
                        filetree.neo-tree.enable = true;
                        tabline.nvimBufferline.enable = true;
                        treesitter.context.enable = true;

                        binds = {
                          whichKey.enable = true;
                          cheatsheet.enable = true;
                        };

                        telescope.enable = true;

                        git = {
                          enable = true;
                          gitsigns.enable = true;
                        };

                        notify = {
                          nvim-notify.enable = true;
                        };

                        ui = {
                          borders.enable = true;
                          noice.enable = true;
                          illuminate.enable = true;
                          smartcolumn.enable = true;
                          fastaction.enable = true;
                        };

                        utility = {
                          outline.aerial-nvim.enable = true;
                        };

                      };

                    }
                  )
                ];
              }).neovim;
            devShells.default = pkgs.mkShell {
              packages = [
                pkgs.sops
                pkgs.age
                pkgs.ssh-to-age
              ];

              shellHook = ''
                export SOPS_AGE_KEY_FILE=$HOME/.config/sops/age/keys.txt
              '';
            };
          }
        )
      );
}
