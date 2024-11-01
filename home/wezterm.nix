{pkgs, ...}: {
    programs.wezterm = {
      enable = true;
      colorschemes = {
	"gruvbox_material_dark_hard" = {
		foreground = "#D4BE98";
		background = "#1D2021";
		cursor_bg = "#D4BE98";
		cursor_border = "#D4BE98";
		cursor_fg = "#1D2021";
		selection_bg = "#D4BE98";
		selection_fg = "#3C3836";

		ansi = [  "#1d2021" "#ea6962" "#a9b665" "#d8a657" "#7daea3" "#d3869b" "#89b482" "#d4be98"  ];
		brights = [  "#eddeb5" "#ea6962" "#a9b665" "#d8a657" "#7daea3" "#d3869b" "#89b482" "#d4be98"  ];
	};
	"gruvbox_material_dark_medium" = {
		foreground = "#D4BE98";
		background = "#282828";
		cursor_bg = "#D4BE98";
		cursor_border = "#D4BE98";
		cursor_fg = "#282828";
		selection_bg = "#D4BE98";
		selection_fg = "#45403d";

		ansi = [  "#282828" "#ea6962" "#a9b665" "#d8a657" "#7daea3" "#d3869b" "#89b482" "#d4be98"  ];
		brights = [  "#eddeb5" "#ea6962" "#a9b665" "#d8a657" "#7daea3" "#d3869b" "#89b482" "#d4be98"  ];
	};
        };
  };
}
