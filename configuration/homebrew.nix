{ ... }:
{
  homebrew = {
    taps = [
      "homebrew/cask-fonts"
    ];
    enable = false;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "aerospace"
      "homerow"
      "claude-code"
      "codex"
      "discord"
      "raycast"
      "bambu-studio"
      "blender"
      "vlc"
      "folx"
      "forklift"
      "helium-browser"
      "kitty"
      "karabiner-elements"
      "mongodb-compass"
      "ngrok"
      "nosql-workbench"
      "opera-gx"
      "rar"
      "soapui"
      "stats"
      "spaceid"
      "studio-3t"
      "ultimaker-cura"
      "visual-studio-code"
      "vivaldi"
      "warp"
      "whatsapp"
      "wezterm"
      "zed"
      "zen"
      "zen-browser"
      "ghostty"
      "font-monaspace-nerd-font"
      "font-monaspice-nerd-font"
      "font-noto-sans-symbols-2"
      "hammerspoon"
      "obs"
      "orbstack"
      "oso-cloud"
      "zulu@17"
    ];
  };
}
