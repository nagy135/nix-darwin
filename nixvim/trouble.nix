{
  plugins.trouble = {
    enable = true;
  };
  keymaps = [
    {
      action = "<cmd>TroubleToggle workspace_diagnostics<CR>";
      key = "<leader>X";
      options = {
        desc = "Trouble diagnostics";
      };
    }
  ];
}
