{
  plugins.diffview.enable = true;
  plugins.neogit = {
    enable = true;
    settings.integrations.diffview = true;
  };
  keymaps = [
    {
      key = "<leader>gg";
      action = "<cmd>lua require('neogit').open()<cr>";
    }
  ];
}
