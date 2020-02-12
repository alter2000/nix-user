{ config }:

{
  unstable = fetchTarball
      # "channel:nixpkgs-unstable";
      "https://github.com/nixos/nixpkgs/master";
}
