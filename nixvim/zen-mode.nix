{
  plugins.zen-mode.enable = true;
  keymaps = [
    {
      key = "<leader>zz";
      action = "<cmd>ZenMode<cr>";
      options = {
        desc = "Zen Mode toggle";
      };
    }
  ];
}
