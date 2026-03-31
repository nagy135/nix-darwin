{ pkgs, ... }:
let
  # neolazygit = pkgs.tmuxPlugins.mkTmuxPlugin {
  #   pluginName = "neolazygit";
  #   version = "unstable-2026-03-30";
  #   rtpFilePath = "neolazygit.tmux";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "AngryMorrocoy";
  #     repo = "tmux-neolazygit";
  #     rev = "9798bf731b8f5d0af980074b23a532c2542adc12";
  #     hash = "sha256-yXSlfH0/rshRMGwzQuOsYX/Xi/3ZHaKlAmObN2w9/Mk=";
  #   };
  # };
  #
  # opencode = pkgs.tmuxPlugins.mkTmuxPlugin {
  #   pluginName = "opencode";
  #   version = "0.0.1";
  #   rtpFilePath = "tmux-opencode.tmux";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "nagy135";
  #     repo = "tmux-opencode";
  #     rev = "d162005070f7145ffe8f84ca85b07dd8e64b4671";
  #     hash = "sha256-+UpN9KREQpoiqc1Q4GoDnfWFvy+wJPX6NuveS+sdcaY=";
  #   };
  # };
  tmux-launcher = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-launcher";
    version = "0.0.1";
    rtpFilePath = "tmux-launcher.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "nagy135";
      repo = "tmux-launcher";
      rev = "1d3bb9a3306870ef7d93070de3319c981f5d4e9c";
      hash = "sha256-sd2HZyF8S4eDNrDTWSYtIO6hwQ4iK21GNcHG5Dj7Ibc=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;

    prefix = "`";
    shell = "/bin/zsh";
    baseIndex = 1;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    resizeAmount = 5;
    historyLimit = 10000;
    escapeTime = 0;
    terminal = "xterm-256color";
    disableConfirmationPrompt = true;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = ''
          unbind C-r
          bind-key C-r run-shell ${resurrect.rtp}/scripts/restore.sh \; display-message "Resurrected..."
          unbind C-s
          bind-key C-s run-shell ${resurrect.rtp}/scripts/save.sh \; display-message "Saved for resurrection..."
        '';
      }
      {
        plugin = jump;
        extraConfig = ''
          # easymotion configuration {{{
          # set -g @easy-motion-prefix "Space"
          set -g @jump-key 'S'
          # }}}
        '';
      }
      fzf-tmux-url
      {
        plugin = tokyo-night-tmux;
        extraConfig = ''
          # tokyo night theme {{{
          set -g @tokyo-night-tmux_window_id_style none
          # }}}
        '';
      }
      {
        plugin = tmux-launcher;
        extraConfig = ''
          set -g @tmux-launchers "
          key=a window=6 command=opencode
          key=g window=3 command=lazygit
          key=t window=- command=npm run test
        "
        '';
      }
      # {
      #   plugin = neolazygit;
      #   extraConfig = ''
      #     set -g @open-lazygit 'g'
      #   '';
      # }
      # {
      #   plugin = opencode;
      #   extraConfig = ''
      #     set -g @tmux-opencode-window-position '6'
      #   '';
      # }
    ];

    extraConfig = builtins.readFile ./config/.tmux.conf;
  };
}
