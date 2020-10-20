self: super:

let
  hspkgset = self.haskell.packages.ghc883;
  # all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

  unstable = import (fetchTarball
      "channel:nixpkgs-unstable"
      # https://github.com/nixos/nixpkgs/master
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
      pretty-simple
    ] ++ hsLibs ps);

    inherit (self)
      hlint
      stack
      cabal-install
      cabal2nix
    ;
    inherit (unstable.haskellPackages) implicit-hie haskell-language-server;
    # hie = all-hies.selection { selector = p: {
    #   inherit (p) ghc884;
    # }; };
  }
  ;
}
