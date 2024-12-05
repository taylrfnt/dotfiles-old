{ config, pkgs, ... }:
{
  enable = true;
  history.size = 10000;
  history.path = "${config.xdg.dataHome}/zsh/history";
  shellAliases = {
    vim = "nvim";
    ls = "ls -altr";
    k = "kubectl";
    yt-dlp = "yt-dlp --config-location ~/.config/yt-dlp/yt-dlp.conf";
  };
  initExtra = ''
    ############################################################################
    #                                   PATH                                   #
    ############################################################################
    ## Enable brew evaluations
    export PATH=/opt/homebrew/bin/:$PATH

    ## Add homebrew installs to path
    export PATH="$(brew --prefix)/sbin:$PATH"
    export PATH="$(brew --prefix)/bin:$PATH"
    export PATH="$(brew --prefix)/opt/openssl/bin:$PATH"

    ############################################################################
    #                             VISUAL & PROMPT                              #
    ############################################################################
    ## oh-my-posh
    if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
      eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
    fi

    ## kitty
    if test -n "$KITTY_INSTALLATION_DIR"; then
        export KITTY_SHELL_INTEGRATION="enabled"
        autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
        kitty-integration
        unfunction kitty-integration
    fi
  '';
  sessionVariables = {
    CLICOLOR = 1;
  };
}

