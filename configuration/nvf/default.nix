{ pkgs, nvf }:
let
  configModule = import ./config.nix { inherit pkgs; lib = pkgs.lib; };
in
nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = [ configModule ];
}
