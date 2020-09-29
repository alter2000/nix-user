# kanged from https://gist.github.com/LnL7/570349866bb69467d0caf5cb175faa74
self: super:

let
  own = import ../pkgs/top-level/all-packages.nix { inherit (self) system; };
in {
  userPackages = ( super.userPackages or {} ) // {

    nix-env-rebuild = super.writeScriptBin "nix-env-rebuild" ''
      #!${super.stdenv.shell}
      if ! command -v nix-env &>/dev/null; then
        echo "warning: nix-env was not found in PATH, add nix to userPackages" >&2
        PATH=${self.nix}/bin:$PATH
      fi
      PENV=(
        devPkgs
        epiPkgs
        haskellPkgs
        haskellPkgs.henv
        userPackages
        unstablePkgs
      )
      exec nix-env -f '<nixpkgs>' -r -iA \
            ''${PENV[@]} \
            "$@"
    '';

    inherit (self)
      # busybox
      alsaUtils
      jrnl
      keynav
      sxhkd
      firefox
      alacritty
      gnupg
      hledger

      msmtp
      notmuch
      offlineimap
      pamixer
      pass
      passff-host
      urlscan
      torbrowser

      maim
      neomutt
      neofetch
      toilet
      lolcat
      pipes
      pywal

      pavucontrol
      transmission-gtk
    ;

    inherit (self)
      termite
      jdk
      tdesktop
      weechat
      # mattermost-desktop
    ;

    inherit (self.xorg)
      xinit
      xkbcomp
    ;

    inherit (self.gitAndTools)
      pass-git-helper
      git-imerge
      gitFull
      tig
    ;

    inherit (own) xmonad;
  }
  // self.gamePkgs
  // self.filePkgs
  // self.streamPkgs
  ;

  filePkgs = ( super.filePkgs or {} ) // {
    inherit (self)
      cryptsetup
      dosfstools
      mtools
      f2fs-tools
      go-mtpfs
      gparted
      # udftools
    ;

    inherit (self)
      fd
      libnotify
      ncdu
      # up  # ultimate plumber
      zip
    ;

    inherit (self)
      # beets
      cozy
      feh
      ffmpeg-full
      imagemagick
      imv
      lollypop
      mpc_cli
      mpd
      mpv
      ncmpcpp
      pandoc
      pulsemixer
      zathura
    ;

    myTexlive = super.texlive.combine {
      inherit (self.texlive) scheme-full noto;
      # pkgFilter = pkg: pkg.tlType == "run" || pkg.tlType == "bin" || pkg.pname == "cm-super";
    };

  };

  gamePkgs = ( super.gamePkgs or {} ) // {
    inherit (self)
      teeworlds
      steam
    ;
  };

  streamPkgs = ( super.streamPkgs or {} ) // {
    inherit (self)
      obs-studio
      obs-wlrobs
    ;
  };
}
