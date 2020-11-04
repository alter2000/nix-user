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
      rev = "7b1c1635e16c7f12065db2f8ec049030fcc63655";
      sha256 = "1nybcann9aiwbvj95p6wam8xyhxwaxmfnkxmgylxcw42np2lvbzr";
    }) {};
in
{
  webPkgs = ( super.webPkgs or {} ) // {
    inherit (self.nodePackages)
      pnpm
      create-react-app
      create-react-native-app
      # tsserver
      # prettier
      csslint
      # yarn2nix
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
      # pulp
      purty
      # psc-package
      spago
      zephyr
    ;

    inherit (self.unstable.nodePackages)
      purescript-language-server
      purescript-psa
    ;
  };
}
