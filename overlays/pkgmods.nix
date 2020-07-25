self: super:

let
  unstable = import (fetchTarball
      "channel:nixpkgs-unstable"
      # "https://github.com/nixos/nixpkgs/master"
    ) { inherit (self) config; };

  own = import ../pkgs/top-level/all-packages.nix { inherit (self) system; };

  nur = import (fetchTarball "https://github.com/nix-community/NUR/tarball/master") {
        inherit (self) pkgs;
      };

in rec {

  unstablePkgs = ( super.unstablePkgs or {} ) // {
    inherit (unstable)
      minecraft
      niv
    ;

    inherit (own)
      endless-sky
      pboy
      # neuron
    ;

    inherit (own.ghcide) ghcide-ghc883;
    inherit vimpp;
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
      url = "https://dist.torproject.org/torbrowser/9.0.9/tor-browser-linux64-9.0.9_en-US.tar.xz";
      sha256 = "0ws4s0jn559j1ih60wqspxvr5wpqww29kzk0xzzbr56wfyahp4fg";
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
