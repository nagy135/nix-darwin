{ config, pkgs, inputs, ... }:

{
  imports = [
    ./lf.nix
    ./zsh.nix
    ./z-lua.nix
    ./alacritty.nix
    ./eza.nix
    inputs.nixvim.homeManagerModules.nixvim
    ../nixvim
  ];
  home.username = "viktornagy";
  home.homeDirectory = "/Users/viktornagy";


  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

}
