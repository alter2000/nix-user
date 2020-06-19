self: super:

{
  epiPkgs = ( super.epiPkgs or {} ) // {
    inherit (self)
      gdb
      manpages
      valgrind
      netcat
      binutils-unwrapped

      gnumake
      cmake
      bear
      icdiff
      nixops
      nodejs
      inkscape

      ansible
      sourcetrail
      direnv
      nasm
      radare2-cutter
      appimage-run
      pkg-config
    ;
    inherit (self.ncurses) dev;
    gcc = super.lowPrio self.gcc;
  };
}
