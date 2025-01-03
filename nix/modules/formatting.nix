{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.flake-root.flakeModule
  ];
  perSystem = { config, ... }: {
    # Add your auto-formatters here.
    # cf. https://nixos.asia/en/treefmt
    treefmt.config = {
      projectRootFile = "flake.nix";

      programs = {
        nixpkgs-fmt.enable = true;
        rustfmt.enable = true;
        shfmt.enable = true;
        prettier.enable = true;
        jsonfmt.enable = true;
        taplo.enable = true;
        toml-sort.enable = true;
        yamlfmt.enable = true;
        actionlint.enable = true;
        deadnix.enable = true;
        statix.enable = true;
      };

    };
  };
}
