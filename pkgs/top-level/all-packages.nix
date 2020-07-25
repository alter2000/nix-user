{ system ? builtins.currentSystem
, pkgs   ? <nixpkgs> }:

let

  pkgs  = import <nixpkgs> { inherit system; };
  aPkg  = x: import (fetchTarball x);
  ghPkg = x: aPkg ("https://github.com/" + x + "/tarball/master");

  snack  = (ghPkg "nmattia/snack").snack-exe;

  pboy   = ghPkg "2mol/pboy";

  neuron = let s = fetchGit { url = "https://github.com/srid/neuron"; ref = "master"; };
            in import s.outPath { gitRev = s.shortRev; };
  # neuronSrc = fetchGit { url = "https://github.com/srid/neuron"; ref = "master"; };

  ghcide = import (builtins.fetchTarball "https://github.com/cachix/ghcide-nix/tarball/master") {};

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
    ghcide
  ;
  # neuron = import neuronSrc.outPath { gitRev = neuronSrc.shortRev; };

}
