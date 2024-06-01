{
  plugins = {
    treesitter = {
      enable = true;
      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "gnn";
          nodeIncremental = "gnn";
          nodeDecremental = "gnp";
          scopeIncremental = "gnc";
        };
      };
    };
    treesitter-context.enable = true;
  };
}
