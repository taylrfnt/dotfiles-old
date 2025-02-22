{ config, pkgs, ... }:
{
  enable = true;
  history.size = 10000;
  history.path = "${config.xdg.dataHome}/zsh/history";
  shellAliases = {
    vim = "nvim";
    ls = "ls -altr";
    k = "kubectl";
    yt-dlp = "yt-dlp --config-location ~/.config/yt-dlp/config";
    # k9s fix (https://github.com/derailed/k9s/issues/3049)
    k9s = "TERM=xterm-256color k9s";
  };
  initExtra = ''
    # fixing delete key
    # https://superuser.com/questions/997593/why-does-zsh-insert-a-when-i-press-the-delete-key/1078653#1078653
    bindkey "^[[3~" delete-char

    ## ghostty fix
    export PATH="''${PATH}:''${GHOSTTY_BIN_DIR}"

    ############################################################################
    #                             VISUAL & PROMPT                              #
    ############################################################################
    ## oh-my-posh
    eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

    # OMP zsh-vi-mode integration
    bindkey -v
    _omp_redraw-prompt() {
      local precmd
      for precmd in "''${precmd_functions[@]}"; do
        "$precmd"
      done
      zle .reset-prompt
    }

    export POSH_VI_MODE="insert"

    function zvm_after_select_vi_mode() {
      case $ZVM_MODE in
      $ZVM_MODE_NORMAL)
        POSH_VI_MODE="normal"
        ;;
      $ZVM_MODE_INSERT)
        POSH_VI_MODE="insert"
        ;;
      $ZVM_MODE_VISUAL)
        POSH_VI_MODE="visual"
        ;;
      $ZVM_MODE_VISUAL_LINE)
        POSH_VI_MODE="visual-line"
        ;;
      $ZVM_MODE_REPLACE)
        POSH_VI_MODE="replace"
        ;;
      esac
      _omp_redraw-prompt
    }
    # vi-mode config

    function zvm_config() {
      ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
    }
    source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  '';
  sessionVariables = {
    CLICOLOR=1;
  };
}

