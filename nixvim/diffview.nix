{
  plugins.diffview.enable = true;
  keymaps = [
    {
      key = "<leader>gdh";
      action = "<cmd>DiffViewFileHistory %<cr>";
      options = {
        desc = "file history (diffview)";
      };
    }
  ];
}
