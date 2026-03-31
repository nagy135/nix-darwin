{ pkgs, ... }: {
  programs.fzf.tmux.enableShellIntegration = true;
  programs.sesh = {
    enable = true;
    tmuxKey = "f";
    settings = {
      session = [
        {
          name = "stuff";
          path = "$HOME";
          startup_command = "fastfetch && ls";
        }
      ];
    };
  };
}
