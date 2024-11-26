{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ./lf.nix
    ./zsh.nix
    ./z-lua.nix
    ./alacritty.nix
    ./eza.nix
    # inputs.nixvim.homeManagerModules.nixvim
    # ../nixvim
  ];
  home.username = "viktornagy";
  home.homeDirectory = "/Users/viktornagy";

  home.file."hammerspoon" = {
    source = ./config/hammerspoon;
    target = ".hammerspoon";
    recursive = true;
  };

  home.file."wezterm" = {
    source = ./config/wezterm/.wezterm.lua;
    target = ".wezterm.lua";
  };

  home.file."aerospace" = {
    source = ./config/aerospace;
    target = ".config/aerospace";
    recursive = true;
  };

  home.file."sketchybarrc" = {
    source = ./config/sketchybar/sketchybarrc;
    target = ".config/sketchybar/sketchybarrc";
  };

  home.file."sketchybar-plugins" = {
    source = ./config/sketchybar/plugins;
    target = ".config/sketchybar/plugins";
    recursive = true;
    executable = true;
  };


  home.file.".npmrc".text = lib.generators.toINIWithGlobalSection {} {
    globalSection = {
      prefix = "~/.npm-packages";
    };
  };


  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

}
