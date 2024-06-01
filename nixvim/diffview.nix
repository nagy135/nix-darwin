{
  plugins.diffview.enable = true;
  keymaps = [
    {
      key = "<leader>gdh";
      action = "<cmd>DiffviewFileHistory %<cr>";
      options = {
        desc = "file history (diffview)";
      };
    }
  ];
}
