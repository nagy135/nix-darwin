{
  plugins.harpoon = {
    enable = true;
    enableTelescope = true;
  };
  keymaps = [
    {
      action = ''<cmd>lua require('harpoon.mark').add_file()<CR>'';
      key = "<leader>ha";
    }
    {
      action = ''<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>'';
      key = "<leader>hh";
    }
    {
      action = ''<cmd>local index = vim.fn.input("Harpoon: ")
    if index == nil or index == "" then
        return
    end
    require('harpoon.ui').nav_file(tonumber(index))<CR>
      '';
      key = "<leader>hi";
    }
  ];
}
