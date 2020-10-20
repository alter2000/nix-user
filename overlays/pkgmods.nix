self: super:

let
  unstable = import (fetchTarball
      "channel:nixpkgs-unstable"
      # "https://github.com/nixos/nixpkgs/master"
    ) { inherit (self) config; };

  own = import ../pkgs/top-level/all-packages.nix { inherit (self) system; };

  nur = import (super.fetchFromGitHub {
      owner = "nix-community";
      repo = "NUR";
      rev = "a222153291e7754422a6c287f6f441b6cea6e0b6";
      sha256 = "0i6ysnypvva4yss68zsabmkqgynl88iilrr47c00bl1kg962ikmi";
    }) { inherit (self) pkgs; };

in {
  inherit own;
  inherit unstable;
  inherit nur;

  unstablePkgs = ( super.unstablePkgs or {} ) // {
    inherit (unstable)
      minecraft
      niv
      kitty
    ;

    inherit (own.ghcide) ghcide-ghc884;
    # inherit (self) vimpp;
  };

  polybar = unstable.polybar.override {
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
    nlSupport = true;
    i3Support = true;
  };

  ncmpcpp = super.ncmpcpp.override { visualizerSupport = true; };

  torbrowser = super.lib.overrideDerivation super.torbrowser (old: {
    src = super.fetchurl {
      url = "https://dist.torproject.org/torbrowser/9.5.4/tor-browser-linux64-9.5.4_en-US.tar.xz";
      sha256 = "0kkgsra7rgy167h8jh54gjn8ncajbj9krqfmqcvcba700kdq2vax";
    };
  });

  tmux = super.lib.overrideDerivation super.tmux (old: {
    buildInputs = old.buildInputs ++ [ super.utf8proc ];
    # nativeBuildInputs = old.nativeBuildInputs ++ [ super.utf8proc ];
    configureFlags = old.configureFlags ++ [ "--enable-utf8proc" ];
  });

  vimpp = super.vim_configurable.overrideAttrs (old: {
    multibyteSupport = true;
    netbeansSupport = false;
    ftNixSupport = false;
    configureFlags = let inherit (super.lib) filter hasPrefix;
      in filter (f: !hasPrefix "--disable-fontset" f) (old.configureFlags ++ [
          "--enable-autoservername" "--enable-fontset" "--enable-multibyte"
          "--disable-netbeans"
    ]);
    # [ "python3" "X11" "xfontset" "autoservername" ];
  });

  # sudo = super.sudo.override { withInsults = true; };

}
