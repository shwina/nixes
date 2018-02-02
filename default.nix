#with import <nixpkgs> { };
{
  nixpkgs ? import (fetchTarball "https://github.com/jb55/nixpkgs/archive/39cd40f7bea40116ecb756d46a687bfd0d2e550e.tar.gz") {}
}:
let
  jekyll_env = nixpkgs.bundlerEnv rec {
    name = "jekyll_env";
    ruby = nixpkgs.ruby_2_2;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
  pkgs = nixpkgs.pkgs;
  python36Packages = nixpkgs.python36Packages;
  pypi2nix = import ./requirements.nix { inherit pkgs; };
  nbval = import ./nbval.nix { inherit pkgs; };
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "env";
    buildInputs = [
      jekyll_env
      nbval
      python36Packages.jupyter
      python36Packages.pillow
      python36Packages.numpy
      python36Packages.toolz
      python36Packages.bokeh
      python36Packages.matplotlib
      python36Packages.flake8
      python36Packages.pylint
      pypi2nix.packages."pykwalify"
      pypi2nix.packages."vega"
      pypi2nix.packages."progressbar2"
      python36Packages.pytest
    ];
  }
