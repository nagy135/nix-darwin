{ config, pkgs, ... }:

{
  imports = [
    ./lf.nix
    ./zsh.nix
    ./z-lua.nix
  ];
  home.username = "viktornagy";
  home.homeDirectory = "/Users/viktornagy";

  home.packages = [ ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

}
