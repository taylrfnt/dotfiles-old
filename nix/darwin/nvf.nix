{pkgs, ...}: {
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

        # lazy.plugins.crates-nvim = {
        #   package = "crates-nvim";
        #   setupOpts = {
        #     curl_args = ["--cacerts" "/etc/ssl/certs/ca-certificates.crt"];
        #   };
        # };

        # actual configs
        keymaps = [
          # NeoTree keymaps
          {
            key = "<leader>e";
            mode = "n";
            silent = true;
            action = ":Neotree toggle<CR>";
            desc = "Toggle Explorer";
          }
          # easy quit keymap
          {
            key = "<leader>q";
            mode = "n";
            silent = true;
            action = ":q<CR>";
            desc = "Quit Current Window";
          }
          # ToggleTerm keymaps
          {
            key = "<leader>tf";
            mode = "n";
            silent = true;
            action = ":ToggleTerm direction=float<CR>";
            desc = "ToggleTerm float";
          }
          {
            key = "<leader>th";
            mode = "n";
            silent = true;
            action = ":ToggleTerm direction=horizontal<CR>";
            desc = "ToggleTerm horizontal";
          }
          {
            key = "<leader>tv";
            mode = "n";
            silent = true;
            action = ":ToggleTerm direction=vertical<CR>";
            desc = "ToggleTerm vertical";
          }
          {
            key = "<leader>tl";
            mode = "n";
            silent = true;
            action = ":TermExec direction=float cmd=lazygit<CR>";
            desc = "ToggleTerm lazygit";
          }
          {
            key = "<leader>tk";
            mode = "n";
            silent = true;
            action = ":TermExec direction=float cmd=k9s<CR>";
            desc = "ToggleTerm k9s";
          }
        ];

        options = {
          tabstop = 2;
          shiftwidth = 2;
          autoindent = true;
          signcolumn = "no";
          wrap = false;
        };

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

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix = {
            enable = true;
            format.enable = true;
          };
          markdown = {
            enable = true;
            extensions.render-markdown-nvim.enable = true;
          };
          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          sql.enable = true;
          java.enable = true;
          kotlin.enable = true;
          ts.enable = true;
          go = {
            enable = true;
            format = {
              enable = true;
              package = pkgs.gofumpt;
              type = "gofumpt";
            };
          };
          helm.enable = true;
          lua.enable = true;
          zig.enable = true;
          python.enable = true;
          typst.enable = true;
          # this requires null-ls, which is not ideal.
          rust = {
            enable = true;
            crates.enable = true;
          };
          # Nim LSP is broken on Darwin
          nim.enable = false;
        };

        diagnostics = {
          enable = true;
          config = {
            # this is supposed to work for neo-tree as well.  It does not right now, for some reason.
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
            #virtual_text = true;
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
              fuxxy.implementation = "lua";
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
            enable = true;
            setupOpts = {
              enable_cursor_hijack = true;
              # custom options for enabling view of hidden files
              filesystem = {
                filtered_items = {
                  visible = true;
                  hide_dotfiles = false;
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

        treesitter.context = {
          enable = true;
          setupOpts = {
            max_lines = 2;
            mode = "cursor";
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
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = false;
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
      };
    };
  };
}
