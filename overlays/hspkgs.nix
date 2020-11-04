self: super:

let
  hspkgset = self.haskell.packages.ghc883;

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
    henv = hspkgset.ghcWithHoogle (ps: with ps; [
      stylish-haskell
      # threadscope
      unlit
      # patat
      # arbtt
      pretty-simple
      hpc-lcov
    ] ++ hsLibs ps);

    inherit (self)
      stack
      cabal-install
      cabal2nix
    ;
    inherit (self.unstable) hlint;
    inherit (self.unstable.haskellPackages)
      implicit-hie
      haskell-language-server
    ;
  }
  ;
}
