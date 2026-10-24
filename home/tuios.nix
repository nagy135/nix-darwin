{
  config,
  lib,
  pkgs,
  ...
}: let
  toml = pkgs.formats.toml {};
  configDir =
    if pkgs.stdenv.hostPlatform.isDarwin
    then "Library/Application Support/tuios"
    else ".config/tuios";

  tuiosSesh = pkgs.writeShellApplication {
    name = "tuios-sesh";
    runtimeInputs = with pkgs; [tuios jq fzf zoxide eza coreutils gawk];
    runtimeEnv.TUIOS_SESH_CONFIG = pkgs.writeText "sesh.json" (builtins.toJSON config.programs.sesh.settings);
    text = builtins.readFile ./config/tuios-sesh.sh;
  };
in {
  home.packages = [pkgs.tuios tuiosSesh];

  home.activation.reloadTuios = lib.hm.dag.entryAfter ["linkGeneration"] ''
    # Keybindings live in the attached clients, not the daemon's config apply.
    # Detached sessions load the config when attached; never start a stopped server.
    if tuiosSessions="$(${pkgs.tuios}/bin/tuios ls --json 2>/dev/null)"; then
      while IFS= read -r tuiosSession; do
        if ! run ${pkgs.tuios}/bin/tuios run-command --session "$tuiosSession" Action reload_config; then
          warnEcho "Could not reload tuios session '$tuiosSession'; use Reload config in tuios."
        fi
      done < <(printf '%s\n' "$tuiosSessions" | ${pkgs.jq}/bin/jq -r '.[] | select(.attached) | .name')
      unset tuiosSession
    fi
    unset tuiosSessions
  '';

  # Keep config.toml writable so the settings UI can save local overrides.
  home.file."${configDir}/config.d/nix.toml".source = toml.generate "tuios-nix.toml" {
    appearance = {
      theme = "gruvbox-material";
      glyphs = "unicode";
      background = "theme";
      border_style = "normal";
      border_focused_color = "#a89984";
      border_unfocused_color = "#3c3836";
      shared_borders = true;
      hide_window_buttons = true;
      window_title_style = "plain";
      window_title_align = "left";
      dockbar_position = "top";
      dock_compact = true;
      dock_pill_caps = false;
      show_clock = false;
      show_cpu = false;
      show_ram = false;
      motion = "none";
      new_window_inherit_cwd = true;
      # Keep the prefix armed so prefix + HJKL can be repeated, like tmux bind -r.
      prefix_repeat_time = 500;
    };
    dock = {
      # The default regions, plus the session name so it shows with the rail folded.
      # tuios draws only text cells and minimized windows in the center, not mode or workspaces.
      left = ["mode" "workspaces" "trail" "tape"];
      center = ["session" "windows"];
      right = ["transfers" "notifications" "copy-help" "cpu" "ram" "clock" "session-controls"];
      session = {
        format = "{session}";
        fg = "#a9b665";
        bold = true;
      };
    };
    keybindings = {
      leader_key = "`";
      prefix_mode = {
        # tmux windows correspond to tuios's workspace tabs in the dock.
        new_workspace = ["c"];
        next_workspace = ["n"];
        prev_workspace = ["N" "p"];
        close_workspace = ["x"];
        kill_session_next = ["X"];
        prefix_split_vertical = ["v" "|" "\\"];
        prefix_split_horizontal = ["s" "-"];
        terminal_focus_left = ["h" "left"];
        terminal_focus_down = ["j" "down"];
        terminal_focus_up = ["k" "up"];
        terminal_focus_right = ["l" "right"];
        resize_pane_left_5 = ["H"];
        resize_pane_down_5 = ["J"];
        resize_pane_up_5 = ["K"];
        resize_pane_right_5 = ["L"];
        # L moved to resizing, so the layout menu lives on y.
        prefix_layout = ["y"];
        last_session = ["Q"];
        last_workspace = ["q"];
        # f opens tuios-sesh below; S keeps the built-in switcher.
        prefix_session_switcher = ["S"];
        switch_workspace_1 = ["1"];
        switch_workspace_2 = ["2"];
        switch_workspace_3 = ["3" "g"];
        switch_workspace_4 = ["4"];
        switch_workspace_5 = ["5"];
        switch_workspace_6 = ["6"];
        switch_workspace_7 = ["7"];
        switch_workspace_8 = ["8"];
        switch_workspace_9 = ["9"];

        # Free the keys these actions owned in the default tuios keymap.
        prefix_next_window = ["tab"];
        prefix_prev_window = ["shift+tab"];
        prefix_close_window = [];
        prefix_close_session = [];
        prefix_new_window = [];
        prefix_review = [];
        prefix_scrollback = [];
        prefix_jump_notif = [];
        prefix_keybinds = [];
        prefix_last_message = [];
        display_panes = [];
        prefix_quit = [];
        prefix_file_search = [];
        toggle_scratch = [];
        prefix_toggle_other_rail = [];
        prefix_select_1 = [];
        prefix_select_2 = [];
        prefix_select_3 = [];
        prefix_select_4 = [];
        prefix_select_5 = [];
        prefix_select_6 = [];
        prefix_select_7 = [];
        prefix_select_8 = [];
        prefix_select_9 = [];
      };
      command = [
        {
          key = "prefix+f";
          type = "popup";
          # The profile path stays valid across rebuilds, so attached clients need no reload.
          command = "${config.home.profileDirectory}/bin/tuios-sesh";
          description = "Sessions: tuios, sesh and zoxide";
          width = "60%";
          height = "60%";
        }
      ];
    };
    # This path remembers the source pane before switching workspaces.
    workspaces.new_window_when_empty = true;
    startup = {
      tiled = true;
      daemon = true;
    };
  };

  # Palette matches kitty: gruvbox-material dark, hard background.
  home.file."${configDir}/themes/gruvbox-material.json".text = builtins.toJSON {
    id = "gruvbox-material";
    display_name = "Gruvbox Material";
    dark = true;
    fg = "#d4be98";
    bg = "#1d2021";
    cursor = "#a89984";
    black = "#665c54";
    red = "#ea6962";
    green = "#a9b665";
    yellow = "#e78a4e";
    blue = "#7daea3";
    purple = "#d3869b";
    cyan = "#89b482";
    white = "#d4be98";
    bright_black = "#928374";
    bright_red = "#ea6962";
    bright_green = "#a9b665";
    bright_yellow = "#d8a657";
    bright_blue = "#7daea3";
    bright_purple = "#d3869b";
    bright_cyan = "#89b482";
    bright_white = "#d4be98";
    chrome = {
      accent = "#a9b665";
      accent_bright = "#d8a657";
      success = "#a9b665";
      warning = "#d8a657";
      error = "#ea6962";
      info = "#7daea3";
      canvas = "#1d2021";
      panel = "#282828";
      surface = "#32302f";
      card = "#3c3836";
      border.unfocused = "#3c3836";
      rule = "#504945";
    };
  };
}
