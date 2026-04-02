{pkgs, ...}: let
  tmux-launcher = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-launcher";
    version = "0.0.1";
    rtpFilePath = "tmux-launcher.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "nagy135";
      repo = "tmux-launcher";
      rev = "924dec73f56e0ecd105473799d3ee9e9251fe805";
      hash = "sha256-KWE+3He71piHd81a55a3wbn1l2DsMaUhEiuKlqDJRAI=";
    };
  };
in {
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
            key=a window=6 command=opencode name=OpenCode
            key=g window=3 command=lazygit --ucf ~/.config/lazygit/config.yml name=LazyGit
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
