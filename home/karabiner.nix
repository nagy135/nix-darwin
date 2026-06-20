{...}: {
  home.file."karabiner" = {
    target = ".config/karabiner/karabiner.json";
    text = builtins.toJSON {
      global.show_in_menu_bar = false;
      profiles = [
        {
          name = "Default profile";
          selected = true;
          virtual_hid_keyboard.keyboard_type_v2 = "ansi";
          simple_modifications = [
            {
              from.key_code = "caps_lock";
              to = [{key_code = "escape";}];
            }
            {
              from.key_code = "non_us_backslash";
              to = [{key_code = "grave_accent_and_tilde";}];
            }
          ];
          complex_modifications.rules = [
            {
              description = "Change option+Tab to command+Tab";
              manipulators = [
                {
                  type = "basic";
                  from = {
                    key_code = "tab";
                    modifiers = {
                      mandatory = ["option"];
                      optional = ["any"];
                    };
                  };
                  to = [
                    {
                      key_code = "tab";
                      modifiers = ["command"];
                    }
                  ];
                }
                {
                  type = "basic";
                  from = {
                    key_code = "q";
                    modifiers = {
                      mandatory = ["option"];
                      optional = ["any"];
                    };
                  };
                  to = [
                    {
                      key_code = "tab";
                      modifiers = ["command"];
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
