with import <nixpkgs> {};
let
  pythonEnv = python310.withPackages(ps: [
  ]);
in mkShell {
  packages = [
    wakeonlan
    xz
  ];
}
