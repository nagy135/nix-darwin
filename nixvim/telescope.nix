{
  plugins.telescope = {
      enable = true;
      keymaps = {
	"<leader>ff" = {
	  action = "git_files";
	  desc = "Telescope Git Files";
	};
	"<leader>fb" = {
	  action = "buffers";
	  desc = "Telescope Buffers";
	};
	"<leader>/" = "live_grep";
	"<leader>gs" = "git_status";
      };
    };
}
