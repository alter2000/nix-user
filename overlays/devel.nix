self: super:

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

    inherit (self) nix-prefetch-scripts;
  }
  // self.asstPkgs
  // self.cPkgs
  // self.lintPkgs
  // self.luaPkgs
  // self.pyPkgs
  # // self.rubyPkgs
  # // self.androidPkgs
  # // self.rustPkgs
  ;

  cPkgs = ( super.cPkgs or {} ) // {
    inherit (self)
      vagrant
      # platformio
      # binutils
    ;
    inherit (self.unstable) ccls;
    inherit (self.unstable) clang-tools;
    clang = super.hiPrio self.clang;
  };

  rustPkgs = ( super.rustPkgs or {} ) // {
    inherit (self)
      rustup
    ;
  };

  luaPkgs = ( super.luaPkgs or {} ) // {
    luaEnv = self.unstable.luajit.withPackages (ps: with ps; [
      moonscript
      # fennel
      compat53
      luarocks
      # luadoc

      # lustache
      # magick
      # luafun
      # lunix
    ]);
  };

  rubyPkgs = ( super.rubyPkgs or {} ) // {
    ruby = self.ruby_3_0;
    bundix = self.bundix.overrideAttrs (old: {
      ruby = self.ruby_3_0;
    });
  };

  pyPkgs = ( super.pyPkgs or {} ) // {
    pyEnv = self.python39.withPackages (ps: with ps; [
      ipython
      ipdb
      pip
      virtualenv
      # requests

      yapf
      pylint
      flake8

      youtube-dl
      goobook
      # python-language-server
      jedi
      (super.callPackage ../pkgs/conan {})
    ]);
    # tim = (super.callPackage ../pkgs/tim.nix);
    # inherit (self) mypy;
  };

  jetbrainsPkgs = ( super.jetbrainsPkgs or {} ) // {
    inherit (self.jetbrains)
      clion
      datagrip
      pycharm-professional
      webstorm
    ;
  };

  androidPkgs = ( super.androidPkgs or {} ) // {
    inherit (self.unstable)
      android-studio
      # apktool
      # genymotion
    ;
  };

  c68Pkgs = ( super.c68Pkgs or {} ) // {
    inherit (self) ansible bind;
    inherit (self.python37Packages) yamllint;
  };

  asstPkgs = ( super.asstPkgs or {} ) // {
    inherit (self)
      pciutils
      inetutils
      sysstat
      psmisc
      dfc
      lsof
      nix-index
      ttyplot
      gnumake
      # niv
      # tmate
    ;
  };

  lintPkgs = ( super.lintPkgs or {} ) // {
    inherit (self)
      nodejs
      ansible-lint
      vim-vint
      shfmt
      shellcheck
      # htmlTidy
      universal-ctags
      # texlab
      # nix-direnv
    ;
    inherit (self.nodePackages) bash-language-server;
  };
}
