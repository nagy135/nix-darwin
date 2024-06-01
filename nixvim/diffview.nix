{
  plugins.diffview.enable = true;
  keymaps = [
    {
      key = "<leader>gh";
      actions = "<cmd>DiffViewFileHistory %<cr>";
      options = {
        desc = "file history (diffview)";
      };
    }
  ];
}
