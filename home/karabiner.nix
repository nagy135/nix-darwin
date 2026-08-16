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
          # Hardware-level key mappings are managed by system.keyboard.
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
