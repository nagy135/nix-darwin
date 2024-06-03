{
  plugins = {
    treesitter = {
      enable = true;
      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "gn";
          nodeIncremental = "gn";
          nodeDecremental = "gp";
          scopeIncremental = "gs";
        };
      };
    };
    treesitter-context.enable = true;
  };
}
