let
  js_ts_ftplugin = {
    keymaps = [
      {
        key = "<leader>;p";
        action = ''yiwoconsole.log("", );<ESC>hPF"P<ESC>'';
      }
      {
        key = "<leader>;P";
        action = ''yiwOconsole.log("", );<ESC>hPF"P<ESC>'';
      }
      {
        key = "<leader>;;p";
        action = ''yiwoconsole.log("================\n", "", , "\n================");<ESC>F,PF"Pa: <ESC>'';
      }
      {
        key = "<leader>;;P";
        action = ''yiwOconsole.log("================\n", "", , "\n================");<ESC>F,PF"Pa: <ESC>'';
      }
    ];
  };
  python_ftplugin = {
    keymaps = [
      {
        key = "<leader>;p";
        action = ''oprint()<ESC>'';
      }
      {
        key = "<leader>;P";
        action = ''Oprint()<ESC>'';
      }
      {
        key = "<leader>;;p";
        action = "yiwoprint('', )<ESC>PF'P^";
      }
      {
        key = "<leader>;;P";
        action = "yiwOprint('', )<ESC>PF'P^";
      }
    ];
  };
in
  {
    files."ftplugin/typescript.lua" = js_ts_ftplugin;
    files."ftplugin/javascript.lua" = js_ts_ftplugin;
    files."ftplugin/typescriptreact.lua" = js_ts_ftplugin;
    files."ftplugin/python.lua" = python_ftplugin;
  }
