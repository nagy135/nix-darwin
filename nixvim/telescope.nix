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
    extensions.file-browser.enable = true;
    enable = true;
    settings = {
      defaults = {
        mappings = {
          i = {
            "<C-q>" = {
              __raw = "require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist";
            };
            "<C-a>" = {
              __raw = "require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist";
            };
          };
        };
      };
    };
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
      "<leader>x" = {
        action = "diagnostics";
        options = {
          desc = suffix "diagnostics";
        };
      };
      "<leader>gf" = {
        action = "git_files";
        options = {
          desc = suffix "git files";
        };
      };
      "<leader>fh" = {
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
      "<leader>fr" = {
        action = "resume";
        options = {
          desc = suffix "resume";
        };
      };
      "<leader>f/" = {
        action = "search_history";
        options = {
          desc = suffix "search history";
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
  keymaps = [
    {
      key = "<leader>fn";
      action.__raw = ''function() 
        require("telescope").extensions.file_browser.file_browser({ cwd = "%:h" })
      end'';
      options = {
        desc = suffix "find neighbors";
      };
    }
  ];
  plugins.which-key.registrations = {
      "<leader>f"= "Find";
  };
}
