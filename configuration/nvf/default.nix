{
  pkgs,
  nvf,
}: let
  neovimVersion = "0.11.6";
  nvfPkgs = pkgs.extend (_: prev: {
    neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs (_: {
      version = neovimVersion;
      src = prev.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "v${neovimVersion}";
        hash = "sha256-GdfCaKNe/qPaUV2NJPXY+ATnQNWnyFTFnkOYDyLhTNg=";
      };
    });
  });
  configModule = import ./config.nix {
    pkgs = nvfPkgs;
    lib = nvfPkgs.lib;
  };
in
  nvf.lib.neovimConfiguration {
    pkgs = nvfPkgs;
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
