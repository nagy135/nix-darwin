{
  pkgs,
  nvf,
}: let
  configModule = import ./config.nix {
    inherit pkgs;
    lib = pkgs.lib;
  };
in
  nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [
      configModule
      ./modules/core.nix
      ./modules/navigation.nix
      ./modules/search.nix
      ./modules/git.nix
      ./modules/tools.nix
      ./modules/debugger.nix
      ./modules/typescript.nix
      ./modules/notes.nix
      ./modules/preview.nix
    ];
  }
