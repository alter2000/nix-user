self: super:

{
  epiPkgs = ( super.epiPkgs or {} ) // {
    inherit (self)
      gdb
      manpages
      valgrind
      netcat
      gcc-unwrapped
      binutils-unwrapped

      gnumake
      cmake
      bear
      icdiff
      inkscape

      sourcetrail
      direnv
      nasm
      radare2-cutter
      appimage-run
      pkg-config
    ;
    inherit (self.ncurses) dev;
  };
}
