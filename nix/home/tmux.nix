{ pkgs, ...}:
{
  enable = true;
  mouse = true;
  baseIndex = 1;
  keyMode = "vi";
  secureSocket = true;
  prefix = "C-Space";
  plugins = with pkgs.tmuxPlugins; [
    sensible
    yank
    vim-tmux-navigator
    cpu
    {
      plugin = catppuccin;
      extraConfig = ''
        set -g @catppuccin_flavor 'mocha'
        set -g @catppuccin_window_status_style 'rounded'
        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
      '';
    }
  ];
  extraConfig = ''
    # Run plugins
    run-shell ${pkgs.tmuxPlugins.tmuxPlugins.sensible}/share/tmux-plugins/sensible/sensible.tmux
    run-shell ${pkgs.tmuxPlugins.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
    run-shell ${pkgs.tmuxPlugins.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux
    run-shell ${pkgs.tmuxPlugins.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
    run-shell ${pkgs.tmuxPlugins.tmusPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux

    # Use Alt-arrow keys without prefix key to switch panes
    #bind -n M-Left select-pane -L
    #bind -n M-Right select-pane -R
    #bind -n M-Up select-pane -U
    #bind -n M-Down select-pane -D

    ## Shift arrow to switch windows
    #bind -n S-Left  previous-window
    #bind -n S-Right next-window

    ## Shift Alt vim keys to switch windows
    #bind -n M-H previous-window
    #bind -n M-L next-window
  '';
}

