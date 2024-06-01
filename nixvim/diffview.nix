let binds = [
  {
    key = "q";
    mode = "n";
    action = "<cmd>DiffviewClose<cr>";
    description = "close diffview";
  }
];
in
  {
    plugins.diffview = {
      enable = true;
      keymaps = {
        view = binds;
        fileHistoryPanel = binds;
      };
    };
    plugins.which-key.registrations = {
      "<leader>gd" = "diff";
    };

    # global
    keymaps = [
      {
        key = "<leader>gdh";
        action = "<cmd>DiffviewFileHistory %<cr>";
        options = {
          desc = "file history (diffview)";
        };
      }
    ];
  }
