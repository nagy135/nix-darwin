{
  plugins.neogit = {
    enable = true;
    settings.integrations.diffview = true;
  };
  plugins.which-key.registrations = {
    "<leader>g" = "git";
  };
  keymaps = [
    {
      key = "<leader>gg";
      action = "<cmd>lua require('neogit').open()<cr>";
      options = {
        desc = "open Neogit";
      };
    }
  ];
}
