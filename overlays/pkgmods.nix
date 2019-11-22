self: super:

let
  unstable = import (fetchTarball "channel:nixpkgs-unstable") {
        inherit (self) config;
      };

  snack = import (fetchTarball "https://github.com/nmattia/snack/tarball/master");

  nur = import (fetchTarball "https://github.com/nix-community/NUR/tarball/master") {
        inherit (self) pkgs;
      };

in

{

  polybar = unstable.polybar.override {
    githubSupport = true;
    i3Support = true;
    nlSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

  vimHugeX = super.vimHugeX.override {
    python = self.python3;
  };

  sudo = super.sudo.override {
    withInsults = true;
  };

  endless-sky = super.callPackage ../pkgs/endless-sky {};
  slurm-git = super.callPackage ../pkgs/slurm-git {};

  # compton = super.compton.override {
  #   configFile = ../../compton.conf;
  # };

  randomGithubPackagesIFoundAround = {
    inherit (snack) snack-exe;
  };

}
