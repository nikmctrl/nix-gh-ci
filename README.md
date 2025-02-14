[![Nix Omnix CI](https://github.com/nikmctrl/nix-gh-ci/actions/workflows/ci-nix.yml/badge.svg?branch=main)](https://github.com/nikmctrl/nix-gh-ci/actions/workflows/ci-nix.yml)

# Nix GH Ci
- A quick example rust project with custom github actions ci
- features:
  - Based on [juspay/omnix](https://github.com/juspay/omnix)
  - Various Nix native ci checks
  - Building every flake output, and returning the store paths (to be consumed by a service like cachix e.g. `cachix push )
  - automated flake lock pull requests (when outdated)
  - Multiple CI workflows, currently:
    - One that supports nixbuild.net (a free online nix builder)
    - One that uses ssh to connect to a remote builder
    
