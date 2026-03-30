{ pkgs, ... }:
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
      deno
      nodejs_latest
      bun
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
      nmap
      mods
      delta
      rustup
      yarn
      sketchybar
      yazi
      spotify-player
      # python
    ];
}
