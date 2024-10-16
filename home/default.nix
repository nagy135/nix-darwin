{ config, pkgs, inputs, ... }:

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

  home.file."aerospace" = {
    source = ./config/aerospace;
    target = ".config/aerospace";
    recursive = true;
  };


  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

}
