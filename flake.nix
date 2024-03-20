{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.transmission
            pkgs.neovim
            pkgs.lazydocker
            pkgs.ripgrep
            pkgs.neofetch
            pkgs.stow
            pkgs.gimp
            pkgs.jq
            pkgs.htop
            pkgs.fzf
            pkgs.git
          ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;

        # nix.package = pkgs.nix;

        security.pam.enableSudoTouchIdAuth = true;

        # Necessary for using flakes on this system.
        nix = {
          linux-builder = {
            enable = true;
            ephemeral = true;
            maxJobs = 4;
            config = {
              virtualisation = {
                darwin-builder = {
                  diskSize = 40 * 1024;
                  memorySize = 8 * 1024;
                };
                cores = 6;
              };
            };
          };
          settings = {
            trusted-users = [ "@admin" ];
            experimental-features = "nix-command flakes";
          };
        };

        services.yabai.enable = true;
        services.yabai.package = pkgs.yabai;
        services.skhd.enable = true;
        # services.yabai.extraConfig = builtins.readFile "${inputs.dotfiles}/yabai/yabairc";
        #
        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Viktors-MacBook-Pro
      darwinConfigurations."Viktors-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."macos".pkgs;
    };
}
