self: super:

let
  unstable = import (fetchTarball
      "channel:nixpkgs-unstable"
    ) { inherit (self) config; };

  master = import (fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/master.tar.gz"
    ) { inherit (self) config; };

  own = import ../pkgs/top-level/all-packages.nix { inherit (self) system; };

  nvim-nightly = import (builtins.fetchTarball {
    url = https://github.com/mjlbach/neovim-nightly-overlay/archive/master.tar.gz;
  }) self super;

in {
  inherit own;
  inherit unstable;
  inherit master;

  unstablePkgs = ( super.unstablePkgs or {} ) // {
    inherit (master)
      minecraft
      kitty
    ;
    # inherit (self) vimpp;
  };

  polybar = super.polybar.override {
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
    nlSupport = true;
    i3Support = true;
  };

  ncmpcpp = super.ncmpcpp.override { visualizerSupport = true; };

  # torbrowser = super.lib.overrideDerivation super.torbrowser (old: {
  #   src = super.fetchurl {
  #     url = "https://dist.torproject.org/torbrowser/10.5.4/tor-browser-linux64-10.5.4_en-US.tar.xz";
  #     sha256 = "0000000000000000000000000000000000000000000000000000";
  #   };
  # });

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

  nvimpp = self.wrapNeovim nvim-nightly.neovim-nightly {
    viAlias = false;
    vimAlias = true;
    withNodeJs = true;
    withPython = false;
    withPython3 = true;
    withRuby = false;
  };

  # sudo = super.sudo.override { withInsults = true; };
}
