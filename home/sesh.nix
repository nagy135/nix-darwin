{pkgs, ...}: {
  programs.fzf.tmux.enableShellIntegration = true;
  programs.sesh = {
    enable = true;
    tmuxKey = "f";
    settings = {
      session = [
        {
          name = "stuff";
          path = "~";
          startup_command = "fastfetch && ls";
          windows = ["neovim"];
        }
        {
          name = "warehouse";
          path = "~/Code/warehouse";
          startup_command = "ls";
          windows = ["neovim" "lazygit"];
        }
        {
          name = "shift-disributor";
          path = "~/Code/shift-distributor";
          startup_command = "ls";
          windows = ["neovim" "lazygit"];
        }
        {
          name = "addy-art";
          path = "~/Code/addy-art-payload";
          startup_command = "ls";
          windows = ["neovim" "lazygit"];
        }
        {
          name = "nix-darwin";
          path = "~/Code/nix-darwin";
          startup_command = "ls";
        }
      ];
      window = [
        {
          name = "neovim";
          startup_script = "nvim .";
        }
        {
          name = "lazygit";
          startup_script = "lazygit";
        }
      ];
    };
  };
}
