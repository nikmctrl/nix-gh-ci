default:
    @just --list

doc:
    nix build .#cargo-doc-live
    nix run .#cargo-doc-live

# Auto-format the source tree
fmt:
    treefmt --allow-missing-formatter --no-cache --fail-on-change

# Run 'cargo run' on the project
run *ARGS:
    cargo run {{ARGS}}

# Run 'cargo watch' to run the project (auto-recompiles)
watch *ARGS:
    cargo watch -x "run -- {{ARGS}}"

clippy:
    cargo clippy

test:
    cargo test
