let 
  keymaps_bind = {
    action = "keymaps";
    options = {
      desc = "keymaps";
    };
  };
in {
  plugins.telescope = {
    enable = true;
    keymaps = {
      "gd" = {
        action = "lsp_definitions";
        options = {
          desc = "go to definitios (telescope)";
        };
      };
      "gr" = {
        action = "lsp_references";
        options = {
          desc = "go to references (telescope)";
        };
      };
      "<leader>gf" = {
        action = "git_files";
        options = {
          desc = "git files";
        };
      };
      "<leader>ff" = {
        action = "find_files";
        options = {
          desc = "files";
        };
      };
      "<leader>fb" = {
        action = "buffers";
        options = {
          desc = "buffers";
        };
      };
      "<leader>/" = {
        action = "live_grep";
        options = {
          desc = "live grep";
        };
      };
      "<leader>sw" = {
        action = "grep_string";
        options = {
          desc = "search word (under cursor)";
        };
      };
      "<leader>gs" = {
        action = "git_status";
        options = {
          desc = "git status";
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
          desc = "old files";
        };
      };
    };
  };
  plugins.which-key.registrations = {
      "<leader>f"= "Find";
  };
}
