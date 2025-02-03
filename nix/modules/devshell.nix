{ ... }:
{
  perSystem = { config, self', pkgs, lib, ... }: {
    devShells.default = pkgs.mkShell {
      name = "rust-nix-gh-ci-example-shell";
      inputsFrom = [
        self'.devShells.rust
        config.treefmt.build.devShell
      ];
      packages = [
        pkgs.just
        pkgs.nixd # Nix language server
        pkgs.cargo-watch
        # config.process-compose.cargo-doc-live.outputs.package
        pkgs.cachix
      ];
    };
  };
}
