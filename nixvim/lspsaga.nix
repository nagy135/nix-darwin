{
  plugins.lspsaga = {
    enable = true;
    lightbulb.enable = false;
    symbolInWinbar.enable = false;

    callhierarchy.keys = {
      edit =["o" "<cr>"];
      split = "s";
      vsplit = "v";
      tabe = "t";

    };
  };
  keymaps = [
    {
      action = ''<cmd>Lspsaga finder<CR>'';
      key = "<leader>lf";
    }
    {
      action = ''<cmd>Lspsaga outline<CR>'';
      key = "<leader>ll";
    }
    {
      action = ''<cmd>Lspsaga outgoing_calls<CR>'';
      key = "<leader>lo";
    }
    {
      action = ''<cmd>Lspsaga incoming_calls<CR>'';
      key = "<leader>li";
    }
  ];
}
