self: super:

let
  unstable = import (fetchTarball
      "channel:nixpkgs-unstable"
      # "https://github.com/nixos/nixpkgs/master"
    ) { inherit (self) config; };

  own = import ../pkgs/top-level/all-packages.nix { inherit (self) config; };

  nur = import (fetchTarball "https://github.com/nix-community/NUR/tarball/master") {
        inherit (self) pkgs;
      };

in

{

  unstablePkgs = ( super.unstablePkgs or {} ) // {
    inherit (unstable)
      torbrowser
      texlab
      minecraft-launcher
      niv
    ;
  };

  polybar = unstable.polybar.override {
    githubSupport = true;
    i3Support = true;
    nlSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

  # sudo = super.sudo.override { withInsults = true; };

}
