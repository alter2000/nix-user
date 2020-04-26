{
  allowUnfree = true;
  allowUnfreeRedistributable = true;

  overlays = [
    ./pkgmods.nix
    ./user.nix
    ./epitech.nix
    ./devel.nix
    ./hspkgs.nix
    # ./emacs.nix  # why oh why
  ];

  # oraclejdk = { accept_license = true; pluginSupport = true; }
}
