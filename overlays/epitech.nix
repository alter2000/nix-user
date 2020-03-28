self: super:

{
  epiPkgs = ( super.epiPkgs or {} ) // {
    inherit (self)
      gdb
      manpages
      valgrind

      gnumake
      icdiff
      nixops
      nodejs
      inkscape

      ansible
      sourcetrail
      direnv
      nasm
      radare2-cutter
    ;
    inherit (self.ncurses) dev;
    gcc = super.lowPrio self.gcc;
  };
}
