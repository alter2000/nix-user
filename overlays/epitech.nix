self: super:

{
  epiPkgs = ( super.epiPkgs or {} ) // {
    inherit (self)
      manpages
      icdiff
      inkscape
      sourcetrail
      direnv
      radare2-cutter
      appimage-run
      docker-compose
      kubectl k9s kustomize
      doctl
    ;
    inherit (self.ncurses) dev;
  }
  // self.epiBuildPkgs
  // self.epiTestPkgs
  ;

  epiBuildPkgs = ( super.epiBuildPkgs or {} ) // {
    inherit (self)
      gnumake
      cmake-format
      # cmake
      cmakeCurses
      # bear
      pkg-config

      nasm
      gcc-unwrapped
      binutils-unwrapped
    ;
    inherit (self.pythonPackages) compiledb;
  };

  epiTestPkgs = ( super.epiTestPkgs or {} ) // {
    inherit (self)
      gdb
      valgrind
      netcat
      # github-cli
      # gitkraken
    ;
  };
}
