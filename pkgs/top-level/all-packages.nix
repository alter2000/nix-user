{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };
  snack = import (fetchTarball https://github.com/nmattia/snack/tarball/master);
  pboy = import (fetchTarball https://github.com/2mol/pboy/tarball/master);
in
rec {

  endless-sky = pkgs.callPackage ../endless-sky {};

  slurm-git = pkgs.callPackage ../slurm-git {};

  inherit (snack) snack-exe;
  inherit pboy;
}
