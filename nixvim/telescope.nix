{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>gf" = {
        action = "git_files";
        desc = "Telescope Git Files";
      };
      "<leader>ff" = {
        action = "find_files";
        desc = "Telescope Find Files";
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
