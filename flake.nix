{
  description = "viktor's nix-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    ...
  }: let
    platform = "aarch64-darwin";
    hosts = {
      sensory = {
        username = "Viktor";
        home = "/Users/Viktor";
      };
      personal = {
        username = "viktornagy";
        home = "/Users/viktornagy";
      };
    };
    pkgs = nixpkgs.legacyPackages.${platform};
    mkDarwinConfiguration = hostname: host:
      nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit self;
          inherit hostname;
          inherit (host) username;
          userHome = host.home;
          nvf = inputs.nvf;
        };
        modules = [
          ./configuration
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              backupFileExtension = "save";
              extraSpecialArgs = {
                inherit inputs;
                inherit (host) username;
                userHome = host.home;
              };
              users.${host.username} = import ./home;
            };
            users.users.${host.username}.home = host.home;
          }
        ];
      };
    mkHomeConfiguration = hostname: host: {
      name = "${host.username}@${hostname}";
      value = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          inherit (host) username;
          userHome = host.home;
        };
        modules = [./home];
      };
    };
  in {
    formatter.${platform} = pkgs.writeShellApplication {
      name = "nix-fmt";
      runtimeInputs = [pkgs.alejandra];
      text = ''
        exec alejandra .
      '';
    };

    # Build darwin flakes using:
    # $ darwin-rebuild build --flake .#sensory
    # $ darwin-rebuild build --flake .#personal
    darwinConfigurations = nixpkgs.lib.mapAttrs mkDarwinConfiguration hosts;

    homeConfigurations = nixpkgs.lib.listToAttrs (nixpkgs.lib.mapAttrsToList mkHomeConfiguration hosts);

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.sensory.pkgs;
  };
}
