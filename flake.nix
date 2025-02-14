{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Dev tools
    cachix-deploy-flake.url = "github:cachix/cachix-deploy-flake";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-root.url = "github:srid/flake-root";
    omnix.url = "github:juspay/omnix";

    crane.url = "github:ipetkov/crane";
  };

  outputs = {nixpkgs, flake-utils, cachix-deploy-flake, treefmt-nix, flake-root, omnix, crane, ...}:
  flake-utils.lib.eachDefaultSystem (system:  
  let 
        pkgs = nixpkgs.legacyPackages.${system}; 
        cachix-deploy-lib = cachix-deploy-flake.lib pkgs;


        craneLib = crane.mkLib pkgs;
        
        commonArgs = {
          src = craneLib.cleanCargoSource ./.;
          strictDeps = true;

          buildInputs = with pkgs; [
            # Add extra build inputs here, etc.
            # openssl
          ];

          nativeBuildInputs = with pkgs; [
            # Add extra native build inputs here, etc.
            # pkg-config
          ];
        };

        # Build *just* the cargo dependencies, so we can reuse
        # all of that work (e.g. via cachix) when running in CI
        cargoArtifacts = craneLib.buildDepsOnly (commonArgs // {
          # Additional arguments specific to this derivation can be added here.
          # Be warned that using `//` will not do a deep copy of nested
          # structures
          pname = "mycrate-deps";
        });

        # Build the actual crate itself, reusing the dependency
        # artifacts from above.
        myCrate = craneLib.buildPackage (commonArgs // {
          inherit cargoArtifacts;
        });

      in
      {
        packages.default = myCrate;
        checks = {
         inherit
           # Build the crate as part of `nix flake check` for convenience
           myCrate;
        };

        packages.cachix-deploy = cachix-deploy-lib.spec {
            agents = {
              nikbook = pkgs.nano;
            };
          };
      });
  
}
