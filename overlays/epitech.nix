self: super:

let
in
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
      kubectl k9s
      kubernetes-helm
      azure-cli
      # doctl
    ;
    inherit (self.ncurses) dev;
  }
  // self.epiBuildPkgs
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
}
