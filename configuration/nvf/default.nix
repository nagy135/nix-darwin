{ pkgs, nvf }:
let
  configModule = import ./config.nix { inherit pkgs; lib = pkgs.lib; };
in
nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = [
    configModule
    ./keymaps/core.nix
    ./keymaps/navigation.nix
    ./keymaps/search.nix
    ./keymaps/git.nix
    ./keymaps/tools.nix
  ];
}
