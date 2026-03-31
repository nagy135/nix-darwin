{
  description = "Example Darwin system flake";

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

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
    let
      home = "/Users/viktornagy";
      platform = "aarch64-darwin";
      username = "viktornagy";
      hostname = "Viktors-MacBook-Pro";
    in
    {

      formatter.${platform} = nixpkgs.legacyPackages.${platform}.nixpkgs-fmt;

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

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
    };
}
