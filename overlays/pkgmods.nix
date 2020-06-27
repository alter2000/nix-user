self: super:

let
  unstable = import (fetchTarball
      "channel:nixpkgs-unstable"
      # "https://github.com/nixos/nixpkgs/master"
    ) { inherit (self) config; };

  own = import ../pkgs/top-level/all-packages.nix { inherit (self) system; };

  nur = import (fetchTarball "https://github.com/nix-community/NUR/tarball/master") {
        inherit (self) pkgs;
      };

in

{

  unstablePkgs = ( super.unstablePkgs or {} ) // {
    inherit (unstable)
      minecraft
      niv
    ;

    inherit (own)
      endless-sky
      pboy
      # neuron
    ;

    inherit (own.ghcide) ghcide-ghc883;
  };

  polybar = unstable.polybar.override {
    githubSupport = true;
    i3Support = true;
    nlSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

  torbrowser = super.lib.overrideDerivation super.torbrowser (old: {
    src = super.fetchurl {
      url = "https://dist.torproject.org/torbrowser/9.0.9/tor-browser-linux64-9.0.9_en-US.tar.xz";
      sha256 = "0ws4s0jn559j1ih60wqspxvr5wpqww29kzk0xzzbr56wfyahp4fg";
    };
  });

  # sudo = super.sudo.override { withInsults = true; };

}
