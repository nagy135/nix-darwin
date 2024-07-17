{
  plugins.neo-tree = {
    buffers.followCurrentFile.enabled = true;
    filesystem.followCurrentFile.enabled = true;
    enable = true;
    addBlankLineAtTop = true;
    window.mappings = {
      v = "open_vsplit";
      s = "open_split";
    };
  };
  keymaps = [
    {
      action = "<cmd>Neotree reveal toggle<CR>";
      key = "<leader>e";
    }
  ];
}
