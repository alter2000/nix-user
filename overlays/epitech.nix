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
    ;
    inherit (self.ncurses) dev;
  }
  // self.epiBuildPkgs
  // self.epiTestPkgs
  ;

  epiBuildPkgs = ( super.epiBuildPkgs or {} ) // {
    inherit (self)
      gnumake
      cmake
      bear
      pkg-config

      nasm
      gcc-unwrapped
      binutils-unwrapped
    ;
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
