{ pkgs }:
let
  useGitHubRelease = true;
  version = "0.12.0";
  customUnwrapped = pkgs.neovim-unwrapped.overrideAttrs (_: {
    inherit version;
    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "v${version}";
      hash = "sha256-uWhrGAwQ2nnAkyJ46qGkYxJ5K1jtyUIQOAVu3yTlquk=";
    };
  });
in
if useGitHubRelease then
  pkgs.wrapNeovim customUnwrapped { }
else
  pkgs.neovim
