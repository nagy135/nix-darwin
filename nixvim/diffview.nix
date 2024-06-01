{
  plugins.diffview.enable = true;
  keymaps = [
    {
      key = "<leader>gh";
      action = "<cmd>DiffViewFileHistory %<cr>";
      options = {
        desc = "file history (diffview)";
      };
    }
  ];
}
