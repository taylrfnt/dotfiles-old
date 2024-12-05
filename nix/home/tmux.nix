{ pkgs, ...}:
{
  enable = true;
  mouse = true;
  terminal = "tmux-256color";
  baseIndex = 1;
  clock24 = true;
  keyMode = "vi";
  secureSocket = true;
  prefix = "C-Space";
  shell = "${pkgs.zsh}/bin/zsh";
  plugins = with pkgs.tmuxPlugins; [
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
        run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
      '';
    }
  ];
  extraConfig = ''
    set-option -sa terminal-overrides ",xterm*:Tc"
    # Run plugins
    run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
    run-shell ${pkgs.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux
    run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux

    # Use Alt-arrow keys without prefix key to switch panes
    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D

    # Shift arrow to switch windows
    bind -n S-Left  previous-window
    bind -n S-Right next-window

    # Shift Alt vim keys to switch windows
    bind -n M-H previous-window
    bind -n M-L next-window
  '';
}

