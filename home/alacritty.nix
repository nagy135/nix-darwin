{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "none";
        opacity = 0.98;
        padding = {
          x = 2;
          y = 2;
        };
      };
      font = {
          size = 14;
        normal = {
          family = "Mononoki Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "Mononoki Nerd Font";
          style = "Bold";
        };
      };
      colors = {
        primary = {
          background = "0x282828";
          foreground = "0xdfbf8e";
        };
        normal = {
          black = "0x665c54";
          blue = "0x7daea3";
          cyan = "0x89b482";
          green = "0xa9b665";
          magenta = "0xd3869b";
          red = "0xea6962";
          white = "0xdfbf8e";
          yellow = "0xe78a4e";
        };
        bright = {
          black = "0x928374";
          blue = "0x7daea3";
          cyan = "0x89b482";
          green = "0xa9b665";
          magenta = "0xd3869b";
          red = "0xea6962";
          white = "0xdfbf8e";
          yellow = "0xe3a84e";
        };
      };
    };
  };
}
