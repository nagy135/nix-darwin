{ pkgs, ... }:
let
  neolazygit = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "neolazygit";
    version = "unstable-2026-03-30";
    rtpFilePath = "neolazygit.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "AngryMorrocoy";
      repo = "tmux-neolazygit";
      rev = "5910deee166d6273658533a7302b5be5f0ccc06f";
      hash = "sha256-38Fb3faEjoeHO4k8dP5jxZQ9Oo2PmjN8r07v+UgCAAE=";
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
        plugin = neolazygit;
        extraConfig = ''
          set -g @open-lazygit 'g'
        '';
      }
    ];

    extraConfig = builtins.readFile ./config/.tmux.conf;
  };
}
