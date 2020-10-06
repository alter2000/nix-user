self: super:

let
  unstable = import (fetchTarball
      "channel:nixpkgs-unstable"
      # "https://github.com/nixos/nixpkgs/master"
    ) { inherit (self) config; };
in
{
  devPkgs = ( super.devPkgs or {} ) // {
    inherit (self)
      direnv
      gitRepo
      git-lfs
      lazygit
      patchelf
      tcsh
    ;

    inherit (self) virtmanager;

    inherit (self) nix-prefetch-scripts;
  }
  // self.asstPkgs
  // self.lintPkgs
  // self.pyPkgs
  // self.rubyPkgs
  // self.rustPkgs
  ;

  cPkgs = ( super.cPkgs or {} ) // {
    inherit (self)
      vagrant
      platformio

      # binutils
    ;
    inherit (unstable) ccls;
    clang = super.hiPrio self.clang;
  };

  rustPkgs = ( super.rustPkgs or {} ) // {
    inherit (self)
      rustup
    ;
  };

  rubyPkgs = ( super.rubyPkgs or {} ) // {
    ruby = self.ruby_2_6;
    bundix = self.bundix.overrideAttrs (old: {
      ruby = self.ruby_2_6;
    });
  };

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
      python-language-server
      jedi
      # neovim
    ]);
    # tim = (super.callPackage ../pkgs/tim.nix);
    # mypy = self.mypy;
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
      inetutils
      sysstat
      pstree
      dfc
      lsof
      nix-index
      ttyplot
      # niv
      gnumake
    ;
  };

  lintPkgs = ( super.lintPkgs or {} ) // {
    inherit (self)
      nodejs
      ansible-lint
      vim-vint
      shfmt
      shellcheck
      htmlTidy
      universal-ctags
      texlab
      # nix-direnv
    ;
    inherit (self.nodePackages) bash-language-server;
  };
}
