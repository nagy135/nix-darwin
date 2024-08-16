{
  plugins.neo-tree = {
    buffers.followCurrentFile.enabled = true;
    filesystem.followCurrentFile.enabled = true;
    enable = true;
    addBlankLineAtTop = true;
    window.mappings = {
      v = "open_vsplit";
      s = "open_split";
      "/" = "noop";
    };
  };
  keymaps = [
    {
      action = "<cmd>Neotree reveal toggle<CR>";
      key = "<leader>e";
      options = {
        desc = "Neotree filetree";
      };
    }
    {
      action = "<cmd>Neotree reveal buffers<CR>";
      key = "<leader>be";
      options = {
        desc = "Neotree buffers";
      };
    }
  ];
}
