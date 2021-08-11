self: super:

let
  obSrc = import (super.fetchFromGitHub {
      owner = "obsidiansystems";
      repo = "obelisk";
      rev = "v0.8.0.0";
      sha256 = "1wm2q4blqga6appp193idkapnqsan7qnkz29kylqag1y11fk4rrj";
    }) { inherit (self) config; };

  easy-ps = import (super.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "eb64583e3e15749b3ae56573b2aebbaa9cbab4eb";
      sha256 = "0hr7smk7avdgc5nm1r3drq91j1hf8wimp7sg747832345c8vq19a";
    }) {};
in
{
  webPkgs = ( super.webPkgs or {} ) // {
    inherit (self.nodePackages)
      pnpm
      yarn
      create-react-app
      create-react-native-app
      # tsserver
      # prettier
      csslint
      # parcel-bundler
      # bower
    ;
  }
  // self.purescriptPkgs
  ;

  reflexPkgs = ( super.reflexPkgs or {} ) // {
    obelisk = obSrc.command;
  };

  purescriptPkgs = ( super.purescriptPkgs or {} ) // {
    inherit (easy-ps.inputs)
      purs
      pscid
      purp
      pulp
      purty
      psc-package
      spago
      # zephyr
    ;

    inherit (self.unstable.nodePackages)
      purescript-language-server
      purescript-psa
    ;
  };
}
