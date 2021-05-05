{
  description = "Development version of the next major version of gLabels";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
  let 
    pkgs = nixpkgs.legacyPackages.${system}; 
    name = "flauschige-uhr";
  in
  rec {
    packages."${name}" = pkgs.stdenv.mkDerivation {
      inherit name;
      src = builtins.path { path = ./.; inherit name; };
      buildInputs = with pkgs; [ glibc.static ];
      makeFlags = [ "DESTDIR=$(out)/bin" ];
    };
    defaultPackage = packages."${name}";
    apps."${name}" = flake-utils.lib.mkApp { drv = packages."${name}"; };
    defaultApp = apps."${name}";
  });
}
