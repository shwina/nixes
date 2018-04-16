let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  versions = {
    ihaskell = fetchFromGitHub {
      owner = "gibiansky";
      repo = "IHaskell";
      rev = "bf6759ed8e0a151d5cd190a0e00d107b607be68b";
      sha256 = "1cnydc5klqd8dzfj9npcq3wxw63pg9s847gqi4l7hs4w47q1mns4";
    };
    nixpkgs = fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs-channels";
      rev = "0653b73bf61f3a23d28c38ab7e9c69a318d433de";
      sha256 = "0s9m3g6nj7bflmrbhx8pcna6s8c9npn75p8ngyj5s8zbdaj7rs7l";
    };
  };
in import "${versions.ihaskell}/release.nix" {
  nixpkgs = import versions.nixpkgs {};
  packages = self: with self; [
    lens
  ];
}
