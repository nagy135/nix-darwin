{ pkgs }: {
  extraPlugins = [
    pkgs.vimPlugins.treesj
  ];
  keymaps = [
    {
      key = "<leader>sj";
      action = "<cmd>lua require('treesj').toggle()<cr>";
      options = {
        silent = true;
        desc = "split/join";
      };
    }
  ];
}
