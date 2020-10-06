self: super:

let
  hspkgset = self.haskell.packages.ghc883;
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

  unstable = import (fetchTarball
      "channel:nixpkgs-unstable"
      # https://github.com/nixos/nixpkgs/master
    ) { inherit (self) config; };
  obSrc = import (fetchTarball
      "https://github.com/obsidiansystems/obelisk/tarball/master"
    ) { inherit (self) config; };

  # TODO: add these to the global project
  hsLibs = p: with p; [
    async
    bytestring
    conduit
    filepath
    mtl
    text
    turtle
  ];
in
{
  haskellPkgs = ( super.haskellPkgs or {} ) // {
      # ghcide
    henv = hspkgset.ghcWithHoogle (ps: with ps; [
      hasktags
      stylish-haskell
      # threadscope
      unlit
      # patat
      # arbtt
    ]);
    # ++ hsLibs ps);

    inherit (self)
      ghcid
      hlint
      stack
      cabal-install
      cabal2nix
    ;
    inherit (unstable.haskellPackages) implicit-hie;
    hie = all-hies.selection { selector = p: {
      inherit (p) ghc884;
    }; };
  }
  # // self.reflexPkgs
  ;

  reflexPkgs = ( super.reflexPkgs or {} ) // {
    obelisk = obSrc.command;
  };
}
