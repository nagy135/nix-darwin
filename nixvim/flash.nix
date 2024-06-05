{
  plugins.flash = {
    enable = true;
  };
  keymaps = [
    {
      key = "s";
      action.__raw = "function() require('flash').jump() end";
      options = {
        desc = "Flash jump";
      };
    }
    {
      key = "S";
      action.__raw = "function() require('flash').treesitter() end";
      options = {
        desc = "Flash treesitter";
      };
    }
  ];
}
