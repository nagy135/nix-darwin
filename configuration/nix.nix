{ ... }:
{
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

  # nix.package = pkgs.nix;
}
