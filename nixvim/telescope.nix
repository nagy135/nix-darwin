let 
  keymaps_bind = {
    action = "keymaps";
    options = {
      desc = suffix "keymaps";
    };
  };
  suffix = var : var + " (telescope)";
in {
  plugins.telescope = {
    enable = true;
    keymaps = {
      "gd" = {
        action = "lsp_definitions";
        options = {
          desc = suffix "go to definitios";
        };
      };
      "gr" = {
        action = "lsp_references";
        options = {
          desc = suffix "go to references";
        };
      };
      "<leader>gf" = {
        action = "git_files";
        options = {
          desc = suffix "git files";
        };
      };
      "fh" = {
        action = "help_tags";
        options = {
          desc = suffix "go to help";
        };
      };
      "<leader>ff" = {
        action = "find_files";
        options = {
          desc = suffix "files";
        };
        };
      };
      "<leader>fb" = {
        action = "buffers";
        options = {
          desc = suffix "buffers";
        };
      };
      "<leader>/" = {
        action = "live_grep";
        options = {
          desc = suffix "live grep";
        };
      };
      "<leader>sw" = {
        action = "grep_string";
        options = {
          desc = suffix "search word (under cursor)";
        };
      };
      "<leader>gs" = {
        action = "git_status";
        options = {
          desc = suffix "git status";
        };
      };
      "<leader>fk" = keymaps_bind;
      "<leader>fm" = keymaps_bind;
      "<leader>fp" = {
        action = "pickers";
        options = {
          desc = "pickers (history)";
        };
      };
      "<leader>fo" = {
        action = "oldfiles";
        options = {
          desc = suffix "old files";
        };
      };
    };
  };
  plugins.which-key.registrations = {
      "<leader>f"= "Find";
  };
}
