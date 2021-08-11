self: super:

let
  hspkgset = self.haskellPackages;

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
in {
  haskellPkgs = ( super.haskellPkgs or {} ) // {
    henv = hspkgset.ghcWithHoogle (ps: with ps; [
      # arbtt
      stylish-haskell
      threadscope
      unlit
      pretty-simple
      hpc-lcov
      implicit-hie
    ] ++ hsLibs ps);

    inherit (self)
      stack
      cabal-install
      cabal2nix
      hlint
    ;
    inherit (self.unstable.haskellPackages)
      haskell-language-server
    ;
  };
}
