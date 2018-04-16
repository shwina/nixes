{
  nixpkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/120b013e0c082d58a5712cde0a7371ae8b25a601.tar.gz") {}
}:
nixpkgs.stdenv.mkDerivation {
  name = "my-env";
  buildInputs = [
    ( import ./build.nix { inherit nixpkgs; })
  ];
}
