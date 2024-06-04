{
  plugins.copilot-vim.enable = true;
  keymaps = [
    {
      key = "<leader>cc";
      mode = ["n" "v" "i" "x" "s" "o"];
      options = {
        desc = "Copilot chat open";
      };
      action = "<cmd>CopilotChat<cr>";
    }
    # {
    #   key = "<leader>cp";
    #   mode = ["n" "v" "i" "x" "s" "o"];
    #   options = {
    #     desc = "Copilot chat prompt";
    #   };
    #   action = ''<cmd>lua vim.ui.input({ prompt = 'Enter prompt: ' }, function(input) vim.api.nvim_command("CopilotChat " .. input) end)<cr> '';
    # }
  ];
}
