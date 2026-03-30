{ ... }:
{
  homebrew = {
    taps = [
      "homebrew/cask-fonts"
      "FelixKratz/formulae"
    ];
    enable = false;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "snappy"
      "homerow"
      "discord"
      "raycast"
      "bambu-studio"
      "blender"
      "vlc"
      "folx"
      "kitty"
      "karabiner-elements"
      "nosql-workbench"
      "soapui"
      "stats"
      "spaceid"
      "ultimaker-cura"
      "wezterm"
      "ghostty"
      "font-monaspace-nerd-font"
      "font-noto-sans-symbols-2"
      "hammerspoon"
      "nikitabobko/tap/aerospace"
      "obs"
      "neovim"
      "orbstack"
      "oso-cloud"
    ];
  };
}
