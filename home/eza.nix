{ pkgs, ... }: {
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = true;
  };
}
