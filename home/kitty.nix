{ ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.mode = null;

    font = {
      name = "Mononoki Nerd Font";
      size = 18;
    };

    settings = {
      cursor_blink_interval = 0;
      cursor_trail = 1;
      enable_audio_bell = false;
      window_padding_width = 5;
      hide_window_decorations = "titlebar-only";

      background = "#1d2021";
      foreground = "#d4be98";
      selection_background = "#d4be98";
      selection_foreground = "#1d2021";
      cursor = "#a89984";
      cursor_text_color = "background";

      active_tab_background = "#1d2021";
      active_tab_foreground = "#d4be98";
      active_tab_font_style = "bold";
      inactive_tab_background = "#1d2021";
      inactive_tab_foreground = "#a89984";
      inactive_tab_font_style = "normal";

      color0 = "#665c54";
      color1 = "#ea6962";
      color2 = "#a9b665";
      color3 = "#e78a4e";
      color4 = "#7daea3";
      color5 = "#d3869b";
      color6 = "#89b482";
      color7 = "#d4be98";
      color8 = "#928374";
      color9 = "#ea6962";
      color10 = "#a9b665";
      color11 = "#d8a657";
      color12 = "#7daea3";
      color13 = "#d3869b";
      color14 = "#89b482";
      color15 = "#d4be98";
    };

    keybindings = {
      "kitty_mod+s" = "goto_session";
    };

    extraConfig = ''
      map kitty_mod+g
    '';
  };
}
