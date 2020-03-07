self: super:

let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

  unstable = import ../unstable.nix {
        inherit (self) config;
      };
in
{
  pyPkgs = ( super.pyPkgs or {} ) // {
    pyEnv = self.python37.withPackages (ps: with ps; [
      ipython
      ipdb
      python
      pip
      virtualenv
      requests

      yapf
      pylint
      flake8

      goobook
      mps-youtube
      subliminal
      python-language-server
      # neovim
      # terminal_velocity
    ]);
    tim = (super.callPackage ../pkgs/tim.nix);
    mypy = self.mypy;
  };

  devPkgs = ( super.devPkgs or {} ) // {
    inherit (self)
      direnv
      gitRepo
      git-lfs
      patchelf

      tcsh
      universal-ctags

      ansible-lint
      vim-vint
      shfmt
      shellcheck
      htmlTidy
    ;

    inherit (self) virtmanager;

    inherit (self) nix-prefetch-scripts;
  };

  cPkgs = ( super.cPkgs or {} ) // {
    inherit (self)
      vagrant
      platformio

      ccls
      binutils
    ;
    clang = super.hiPrio self.clang;
  };

  haskellPkgs = ( super.haskellPkgs or {} ) // {
    env = self.haskellPackages.ghcWithHoogle (ps: with ps; [
      hlint
      hindent
      ghcid
      hasktags

      markdown-unlit
      stylish-haskell

      cabal-install
      cabal2nix
      stack
    ]);

    hie = all-hies.unstableFallback.selection { selector = p: {
      inherit (p)
        # ghc844
        # ghc864
        ghc865
        ghc881
      ;
    }; };
  };

  rustPkgs = ( super.rustPkgs or {} ) // {
    inherit (self)
      rustup
      rls
    ;
  };

  rubyPkgs = ( super.rubyPkgs or {} ) // rec {
    ruby = self.ruby_2_6;
    bundix = self.bundix.overrideAttrs (old: {
      inherit ruby;
    });
  };

  jetbrainsPkgs = ( super.jetbrainsPkgs or {} ) // {
    inherit (self)
      clion
      datagrip
      pycharm-professional
      webstorm
    ;
  };

  androidPkgs = ( super.androidPkgs or {} ) // {
    inherit (self)
      android-studio
      apktool
      genymotion
    ;
  };

  c68Pkgs = ( super.c68Pkgs or {} ) // {
    inherit (self)
      ansible
      bind
    ;

    inherit (self.python37Packages)
      yamllint
    ;
  };

  asstPkgs = ( super.asstPkgs or {} ) // {
    inherit (self)
      pciutils
      dfc
      lsof
    ;
  };
}
