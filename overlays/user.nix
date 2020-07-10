# kanged from https://gist.github.com/LnL7/570349866bb69467d0caf5cb175faa74
self: super:

{
  userPackages = ( super.userPackages or {} ) // {

    nix-env-rebuild = super.writeScriptBin "nix-env-rebuild" ''
      #!${super.stdenv.shell}
      if ! command -v nix-env &>/dev/null; then
          echo "warning: nix-env was not found in PATH, add nix to userPackages" >&2
          PATH=${self.nix}/bin:$PATH
      fi
      PENV=(
              devPkgs
              # epiPkgs
              haskellPkgs
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
      gnupg
      jrnl
      keynav
      zip
      sxhkd
      firefox
      go-mtpfs
      hledger
      fd

      imagemagick
      imv
      feh
      libnotify
      msmtp
      neomutt
      notmuch
      offlineimap
      pamixer
      pass
      passff-host
      urlscan
      zathura
      pandoc
      torbrowser

      maim
      neofetch
      ncmpcpp
      weechat
      up  # ultimate plumber
      cozy

      ncdu
      pavucontrol
      pipes
      pulsemixer
      pywal
      mpc_cli
      mpd
      mpv

      alacritty
      toilet
      transmission-gtk

      lolcat
      ffmpeg-full
      # beets
    ;

    inherit (self)
      teeworlds
      termite
      steam
      jdk
      tdesktop
      # mattermost-desktop
      gparted
      f2fs-tools
      cryptsetup
      dosfstools
      # udftools
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

    myTexlive = super.texlive.combine {
      inherit (self.texlive) scheme-full noto;
      # pkgFilter = pkg: pkg.tlType == "run" || pkg.tlType == "bin" || pkg.pname == "cm-super";
    };

  };
}
