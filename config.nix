{
  allowUnfree = true;
  allowUnfreeRedistributable = true;
  android_sdk.accept_license = true;
  # allowBroken = true;

  overlays = [
    ./user.nix
    ./devel.nix
    ./epitech.nix
    ./hspkgs.nix
    ./pkgmods.nix
    # ./emacs.nix  # why oh why
  ];

  # oraclejdk = { accept_license = true; pluginSupport = true; }
}
