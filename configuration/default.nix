{ ... }:
{
  imports = [
    ./packages.nix
    ./defaults.nix
    ./homebrew.nix
    ./services.nix
    ./nix.nix
    ./programs.nix
    ./system.nix
  ];
}
