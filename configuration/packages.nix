{ pkgs, nvf, ... }:
let
  nvfOverride = true;
  neovimPackage = if nvfOverride then (import ./nvf { inherit pkgs nvf; }).neovim else import ./neovim.nix { inherit pkgs; };
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    with pkgs;
    [
      home-manager
      git-crypt
      # transmission_4
      iina
      qemu
      lazydocker
      lazygit
      postman
      gh
      tmux
      fx
      bat
      deno
      dust
      figlet
      nodejs_latest
      bun
      pnpm
      pqiv
      portal
      yq
      alacritty
      audacity
      go
      zig
      ripgrep
      tldr
      fastfetch
      stow
      # gimp
      jq
      htop
      fzf
      git
      spacebar
      arduino-cli
      silicon
      mpv
      ncdu
      neovimPackage
      nmap
      mods
      delta
      rustup
      typst
      wget
      yarn
      sketchybar
      yazi
      spotify-player
      zx
      # python
    ];
}
