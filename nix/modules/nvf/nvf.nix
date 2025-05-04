{
  pkgs,
  # lib,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        # providers
        withRuby = true;
        withNodeJs = true;
        withPython3 = true;

        # aliases
        viAlias = false;
        vimAlias = true;

        # keymaps
        keymaps = import ./keymaps/default.nix;

        # vim options (vim.opt)
        options = {
          tabstop = 2;
          shiftwidth = 2;
          autoindent = true;
          signcolumn = "no";
          wrap = false;
        };

        # custom lua to run at startup
        luaConfigPre = ''
          vim.opt.listchars = {
            multispace = "￮",
            space = "•",
            tab = "·┈",
            eol = "󰌑",
            extends = "▶",
            precedes = "◀",
            nbsp = "‿",
          }
          vim.opt.list = true
        '';

        # nvim lsp settings
        lsp = {
          enable = true;
          formatOnSave = true;
          lspconfig = {
            enable = true;
          };
          null-ls.enable = true;
          # NOTE: lspkind requires nvim.cmp or blink.cmp
          lspkind.enable = true;
          lightbulb.enable = false;
          trouble.enable = true;
          # lsp-signature is replaced by blink.cmp
          lspSignature.enable = false;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
        };

        # language support
        languages = import ./languages/default.nix {inherit pkgs;};

        diagnostics = {
          enable = true;
          config = {
            # this is supposed to work for neo-tree as well.  It does not right now, for some reason.
            # if this starts to work, we can move to neo-tree instead of nvim-tree
            signs = {
              text = {
                "vim.diagnostic.severity.ERROR" = " ";
                "vim.diagnostic.severity.WARN" = " ";
                "vim.diagnostic.severity.INFO " = " ";
                "vim.diagnostic.severity.HINT" = "󰌵 ";
              };
            };
            update_in_insert = true;
            virtual_lines = true;
          };
        };

        visuals = {
          cellular-automaton.enable = true;
          nvim-scrollbar.enable = false;
          nvim-web-devicons = {
            enable = true;
            setupOpts = {
              override = {
                ".zshrc" = {
                  icon = "";
                  name = "Zshrc";
                };
                "nix" = {
                  icon = "󱄅";
                  color = "#5277C3";
                  name = "Nix";
                };
              };
            };
          };
          nvim-cursorline = {
            enable = true;
            setupOpts = {
              cursorline = {
                enable = true;
                timeout = 50;
                number = true;
              };
            };
          };
          cinnamon-nvim = {
            enable = true;
            setupOpts = {
              keymaps = {
                basic = true;
                extra = true;
              };
            };
          };
          fidget-nvim.enable = true;

          highlight-undo.enable = false;
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
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;
        autocomplete = {
          # install currently fails due to vendored dependencies & SSL
          blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            setupOpts = {
              signature.enabled = true;
            };
          };
          nvim-cmp = {
            enable = false;
            setupOpts = {
              view = {
                entries = "native";
              };
            };
          };
        };
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = false;
            setupOpts = {
              enable_cursor_hijack = true;
              # custom options for enabling view of hidden files
              filesystem = {
                hijack_netrw_behavior = "open_current";
                filtered_items = {
                  visible = true;
                  hide_dotfiles = false;
                };
              };
            };
          };
          nvimTree = {
            enable = true;
            mappings = {
              toggle = "<leader>e";
            };
            setupOpts = {
              renderer = {
                icons = {
                  git_placement = "right_align";
                  diagnostics_placement = "right_align";
                };
              };
              diagnostics = {
                enable = true;
                icons = {
                  error = "";
                  warning = "";
                  info = "";
                  hint = "󰌵";
                };
              };
            };
          };
        };

        tabline = {
          nvimBufferline = {
            enable = true;
            setupOpts = {
              options = {
                numbers = "none";
                tab_size = 12;
                separator_style = "slant";
              };
            };
          };
        };

        treesitter = {
          enable = true;
          fold = true;
          context = {
            enable = true;
            setupOpts = {
              max_lines = 2;
            };
          };
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        mini.icons = {
          enable = true;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow = {
            enable = true;
            mappings = {
              toggle = "<leader>mt";
            };
          };
        };

        notes = {
          todo-comments.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        utility = {
          ccc.enable = true;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = true;
          icon-picker.enable = true;
          surround.enable = true;
          leetcode-nvim.enable = false;
          multicursors.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit = {
              enable = true;
              mappings.open = null;
            };
            mappings = {
              open = null; # unset toggleterm here in favor of custom commands
            };
          };
        };
        ui = {
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };

        # load some custom plugins not in the nvf flake
        extraPlugins = import ./plugins/default.nix {inherit pkgs;};
      };
    };
  };
}
