{
  plugins.trouble = {
    enable = true;
  };
  keymaps = [
    {
      action = "<cmd>TroubleToggle workspace_diagnostics<CR>";
      key = "<leader>x";
      options = {
        desc = "Trouble diagnostics";
      };
    }
  ];
}
