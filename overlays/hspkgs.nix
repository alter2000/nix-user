self: super:

let
  hspkgset = self.haskell.packages.ghc8107;

  # TODO: add these to the global project
  hsLibs = p: with p; [
    async
    bytestring
    conduit
    filepath
    mtl
    text
    # turtle
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
    haskell-language-server = self.unstable.haskell-language-server.override {
      supportedGhcVersions = [ "8107" "901" ];
    };
  };
}
