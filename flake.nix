{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nixvim, ... }:
    let
      home = "/Users/viktornagy";
      platform = "aarch64-darwin";
      nixvimPkg = import ./nixvim { 
        inherit nixvim;
        lib = nixpkgs.lib;
        pkgs = nixpkgs.legacyPackages.${platform};
      };
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          with pkgs;
          [
            home-manager
            transmission
            nixvimPkg
            iina
            qemu
            lazydocker
            lazygit
            postman
            gh
            tmux
            lsd
            fx
            deno
            nodejs_latest
            bun
            pqiv
            yq
            alacritty
            audacity
            go
            skhd
            ripgrep
            tldr
            neofetch
            stow
            gimp
            jq
            htop
            fzf
            git
            # python
          ];

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
        };

        homebrew = {
          taps = [
            "homebrew/cask-fonts"
          ];
          enable = true;
          onActivation.autoUpdate = true;
          casks = [
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
            "font-monaspace-nerd-font"
            "font-noto-sans-symbols-2"
          ];
        };

        system.keyboard.enableKeyMapping = true;
        system.keyboard.nonUS.remapTilde = true;
        system.defaults.NSGlobalDomain.KeyRepeat = 2;

        system.keyboard.remapCapsLockToEscape = true;
        system.startup.chime = false;


        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;

        services.postgresql = {
          package = pkgs.postgresql_15;
          enable = true;
          authentication = ''
            local   all             all                                     trust
            host    all             all             0.0.0.0/0               trust
            host    all             all             ::1/128                 trust
          '';

          enableTCPIP = true;
        };

        # Direct log output to $XDG_DATA_HOME/postgresql for debugging.
        launchd.user.agents.postgresql.serviceConfig = {
          StandardErrorPath = "${home}/.local/share/postgresql/postgres.error.log";
          StandardOutPath = "${home}/.local/share/postgresql/postgres.out.log";
        };

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
        programs.zsh = {
          enable = true; # default shell on catalina
        };
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
        nixpkgs.config.allowBroken = true;
        nixpkgs.config.allowUnsupportedSystem = true;
        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.permittedInsecurePackages = true;
      };
    in
    {

      formatter.${platform} = nixpkgs.legacyPackages.${platform}.nixpkgs-fmt;

      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Viktors-MacBook-Pro
      darwinConfigurations."Viktors-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users.viktornagy = import ./home;
            };
            users.users.viktornagy.home = "/Users/viktornagy";
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."macos".pkgs;
    };
}
