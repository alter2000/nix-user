{ system ? builtins.currentSystem
, pkgs   ? <nixpkgs> }:

let

  pkgs  = import <nixpkgs> { inherit system; };
  aPkg  = x: import (fetchTarball x);
  ghPkg = x: aPkg ("https://github.com/" + x + "/tarball/master");

  snack  = (ghPkg "nmattia/snack").snack-exe;

  # 1.4 broken
  pboy   = ghPkg "2mol/pboy";

  neuron = ghPkg "srid/neuron";
  # neuronSrc = fetchGit { url = "https://github.com/srid/neuron"; ref = "master"; };

  neuron-language-server = ghPkg "aca/neuron-language-server";

  ghcide = import (builtins.fetchTarball "https://github.com/cachix/ghcide-nix/tarball/master") {};

  unstable = import (fetchTarball "channel:nixpkgs-unstable") { inherit (pkgs) config; };

in
rec {

  endless-sky = pkgs.callPackage ../endless-sky {};

  slurm-git = pkgs.callPackage ../slurm-git {};

  papermc = pkgs.callPackage ../papermc {};

  xmonad = pkgs.callPackage /home/alter2000/.config/xmonad/nix {};

  inherit
    snack
    pboy
    neuron
    neuron-language-server
    ghcide
  ;

  inherit unstable;

}
