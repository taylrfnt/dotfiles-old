{ config, pkgs, ...}:

{
  enable = true;
  settings = {
    general = {
      live_config_reload = true;
    };

    bell = {
      animation = "EaseOutExpo";
      duration = 0;
    };

    colors = {
      draw_bold_text_with_bright_colors = true;
    };

    cursor = {
      blink_interval = 500;
      blink_timeout = 5;
      unfocused_hollow = true;
      style = {
        blinking = "On";
      };
    };

    env = {
      TERM = "xterm-256color";
    };

    font = {
      size = 16;
      bold = {
        family = "CommitMono Nerd Font";
        style = "Bold";
      };
      italic = {
        family = "CommitMono Nerd Font";
        style = "Italic";
      };
      normal = {
        family = "CommitMono Nerd Font";
        style = "Regular";
      };
      glyph_offset = {
        x = 0;
        y = 0;
      };
      offset = {
        x = 0;
        y = 0;
      };
    };

    mouse = {
      hide_when_typing = true;
      bindings = {
        action = "PasteSelection";
        mouse = "Middle";
      };
    };


    selection = {
      semantic_escape_chars = '',│`|:\"' ()[]{}<>'';
    };

    terminal = {
      shell = "${pkgs.zsh}";
    };

    window = {
      decorations = "full";
      dynamic_title = true;
      option_as_alt = "Both";
      dimensions = {
        columns = 160;
        lines = 80;
      };
      padding = {
        x = 4;
        y = 4;
      };
    };
  };
}
