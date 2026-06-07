{
  description = "viktor's nix-darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

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
    home = "/Users/Viktor";
    platform = "aarch64-darwin";
    username = "Viktor";
    hostname = "Viktor-Mac";
    pkgs = nixpkgs.legacyPackages.${platform};
  in {
    formatter.${platform} = pkgs.writeShellApplication {
      name = "nix-fmt";
      runtimeInputs = [pkgs.alejandra];
      text = ''
        exec alejandra .
      '';
    };

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Viktors-MacBook-Pro
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit home self username;
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
            };
            users.${username} = import ./home;
          };
          users.users.${username}.home = home;
        }
      ];
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs;
      };
      modules = [./home];
    };

    homeConfigurations."${username}@${hostname}" = self.homeConfigurations.${username};

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
