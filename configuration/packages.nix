{
  pkgs,
  nvf,
  hostname,
  ...
}: let
  nvfOverride = true;
  neovimPackage =
    if nvfOverride
    then (import ./nvf {inherit pkgs nvf;}).neovim
    else import ./neovim.nix {inherit pkgs;};

  sharedPackages = with pkgs; [
    home-manager
    git-crypt
    # transmission_4
    iina
    pi-coding-agent
    nh
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
    keycastr
    ffmpeg
    yt-dlp
    # python
  ];

  sensoryPackages = with pkgs; [
    azure-cli
    kubectl
    kubelogin
  ];

  personalPackages = with pkgs; [];

  hostSpecificPackages =
    if hostname == "sensory"
    then sensoryPackages
    else if hostname == "personal"
    then personalPackages
    else [];
in {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = sharedPackages ++ hostSpecificPackages;
}
