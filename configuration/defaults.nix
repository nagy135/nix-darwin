{...}: {
  system.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      show-process-indicators = false;
      show-recents = false;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
      FXPreferredViewStyle = "Nlsv";
    };
    CustomUserPreferences."com.apple.finder".NSUserKeyEquivalents = {
      "Go to Folder…" = "@l";
    };
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  };
  ids.gids.nixbld = 350;
}
