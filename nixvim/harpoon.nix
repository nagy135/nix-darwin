{
  plugins.harpoon = {
    enable = true;
    enableTelescope = true;
  };
  plugins.which-key.registrations = {
      "<leader>h"= "Harpoon";
  };
  keymaps = [
    {
      action.__raw = ''function() require('harpoon.mark').add_file() end'';
      key = "<leader>ha";
      options = {
        desc = "Add file";
      };
    }
    {
      action.__raw = ''function() require('harpoon.ui').toggle_quick_menu() end'';
      key = "<leader>hh";
      options = {
        desc = "Toggle quick menu";
      };
    }
    {
      action.__raw = ''function()
        local index = vim.fn.input("Harpoon: ")
        if index == nil or index == "" then
            return
        end
        require('harpoon.ui').nav_file(tonumber(index))
      end'';
      key = "<leader>hi";
      options = {
        desc = "Select with input";
      };
    }
  ];
}
