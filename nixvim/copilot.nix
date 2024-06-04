{
  plugins.copilot-vim.enable = true;
  keymaps = [
    {
      key = "<leader>cc";
      mode = ["n" "v" "x" "s" "o"];
      options = {
        desc = "CopilotChat open";
      };
      action = "<cmd>CopilotChat<cr>";
    }
    {
      key = "<leader>cf";
      mode = ["n" "v" "x" "s" "o"];
      options = {
        desc = "CopilotChat fix";
      };
      action = "<cmd>CopilotChatFix<cr>";
    }
    {
      key = "<leader>co";
      mode = ["n" "v" "x" "s" "o"];
      options = {
        desc = "CopilotChat optimize";
      };
      action = "<cmd>CopilotChatOptimize<cr>";
    }
    {
      key = "<leader>ct";
      mode = ["n" "v" "x" "s" "o"];
      options = {
        desc = "CopilotChat test";
      };
      action = "<cmd>CopilotChatTests<cr>";
    }
    {
      key = "<leader>cr";
      mode = ["n" "v" "x" "s" "o"];
      options = {
        desc = "CopilotChat reset";
      };
      action = "<cmd>CopilotChatReset<cr>";
    }
    {
      key = "<leader>cp";
      mode = ["n" "v" "x" "s" "o"];
      options = {
        desc = "CopilotChat prompt";
      };
      action.__raw = ''function() vim.ui.input({ prompt = 'Enter prompt: ' }, function(input) vim.api.nvim_command("CopilotChat " .. input) end) end'';
    }
  ];
}
