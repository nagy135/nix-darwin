{
  config,
  pkgs,
  inputs,
  lib,
  username,
  userHome,
  ...
}: {
  imports = [
    ./lf.nix
    ./zsh.nix
    # ./z-lua.nix # sesh (tmux) requires zoxide
    ./zoxide.nix
    ./alacritty.nix
    ./kitty.nix
    ./eza.nix
    ./tmux.nix
    ./sesh.nix
    ./karabiner.nix
  ];
  home.username = username;
  home.homeDirectory = userHome;

  home.file."hammerspoon" = {
    source = ./config/hammerspoon;
    target = ".hammerspoon";
    recursive = true;
  };

  home.file."wezterm" = {
    source = ./config/wezterm/.wezterm.lua;
    target = ".wezterm.lua";
  };

  home.file."ghostty" = {
    source = ./config/ghostty/config;
    target = ".config/ghostty/config";
  };

  home.file."aerospace" = {
    source = ./config/aerospace;
    target = ".config/aerospace";
    recursive = true;
  };

  home.file."sketchybar" = {
    source = ./config/sketchybar;
    target = ".config/sketchybar";
    recursive = true;
    executable = true;
  };

  home.file.".npmrc".text = lib.generators.toINIWithGlobalSection {} {
    globalSection = {
      prefix = "~/.npm-packages";
      "@sensory:registry" = "https://git.sensory-minds.com/api/v4/projects/428/packages/npm/";
      "//git.sensory-minds.com/api/v4/projects/428/packages/npm/:_authToken" = "\${NPM_TOKEN_SENSORY}";
      "@hdpbe:registry" = "https://git.sensory-minds.com/api/v4/projects/426/packages/npm/";
      "//git.sensory-minds.com/api/v4/projects/426/packages/npm/:_authToken" = "\${NPM_TOKEN_HDPBE}";
    };
  };

  home.stateVersion = "23.11";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;
}
