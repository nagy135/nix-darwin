{
  plugins.telescope = {
      enable = true;
      keymaps = {
	"<leader>ff" = {
	  action = "git_files";
	  desc = "Telescope Git Files";
	};
	"<leader>/" = "live_grep";
      };
    };
}
