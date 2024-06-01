{
  plugins.neogit = {
    enable = true;
  };
  keymaps = [
    {
      key = "<leader>gg";
      action = "<cmd>lua require('neogit').open()<cr>";
    }
  ];
}
