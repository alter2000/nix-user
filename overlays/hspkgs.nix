self: super:

let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

  unstable = import (fetchTarball
      "channel:nixpkgs-unstable"
      # https://github.com/nixos/nixpkgs/master
    ) { inherit (self) config; };
  obSrc = import (fetchTarball
      "https://github.com/obsidiansystems/obelisk/tarball/master"
    ) { inherit (self) config; };
in
{
  haskellPkgs = ( super.haskellPkgs or {} ) // {
    henv = self.haskellPackages.ghcWithHoogle (ps: with ps; [
      hlint
      hindent
      ghcid
      hasktags

      markdown-unlit
      # stylish-haskell
      # threadscope

      cabal-install
      cabal2nix
      stack
    ]);

    hie = all-hies.selection { selector = p: {
      inherit (p)
        # ghc844
        # ghc864
        ghc865
        ghc881
      ;
    }; };
  };

  reflexPkgs = ( super.reflexPkgs or {} ) // {
    obelisk = obSrc.command;
  };
}
