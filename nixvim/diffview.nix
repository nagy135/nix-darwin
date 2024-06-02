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
        filePanel = binds;
        optionPanel = binds;
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
      {
        key = "<leader>gdf";
        action = "<cmd>DiffviewOpen<cr>";
        options = {
          desc = "diff file (diffview)";
        };
      }
    ];
  }
