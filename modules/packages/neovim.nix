{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.neovim =
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            (
              { pkgs, ... }:
              {
                config.vim = {

                  keymaps = [
                    {
                      key = "-";
                      mode = "n";
                      action = "<CMD>Oil<CR>";
                      desc = "Open parent directory";
                    }
                  ];

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
                      format.type = [ "nixfmt" ];
                      lsp = {
                        servers = [ "nixd" ];
                        # options = {
                        #   #   nixpkgs.expr = "import <nixpkgs> { }";
                        #   nix-darwin.expr = "(builtins.getFlake (toString ./.)).darwinConfigurations.yeti.options";
                        #   home-manager.expr = "(builtins.getFlake (toString ./.)).darwinConfigurations.yeti.users.type.getSubOptions []";
                        # };
                      };
                    };
                    markdown = {
                      enable = true;
                      lsp.enable = false;
                    };
                    go.enable = true;
                    python.enable = true;
                    yaml.enable = true;
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
                  tabline.nvimBufferline.enable = true;
                  treesitter.context.enable = true;

                  binds = {
                    whichKey.enable = true;
                    cheatsheet.enable = true;
                  };

                  telescope = {
                    enable = true;
                    setupOpts.pickers.find_files.find_command = [
                      "${pkgs.fd}/bin/fd"
                      "--type=file"
                      "--hidden"
                    ];
                  };

                  git = {
                    enable = true;
                    gitsigns.enable = true;
                  };

                  minimap.codewindow.enable = true;

                  notify = {
                    nvim-notify.enable = true;
                  };

                  ui = {
                    borders.enable = true;
                    noice.enable = true;
                    illuminate.enable = true;
                    smartcolumn = {
                      enable = true;
                      setupOpts.colorcolumn = "180";
                    };
                    fastaction.enable = true;
                  };

                  comments.comment-nvim.enable = true;

                  utility = {
                    motion.flash-nvim.enable = true;
                    outline.aerial-nvim.enable = true;
                    oil-nvim = {
                      enable = true;
                      setupOpts.view_options.show_hidden = true;
                    };
                    surround = {
                      enable = true;
                      useVendoredKeybindings = true;
                    };
                  };

                };
              }
            )
          ];
        }).neovim;
    };
}
