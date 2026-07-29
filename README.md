# Homebrew Tap

Homebrew formulae maintained by [Justus Schock](https://github.com/justusschock).

## Every Code

[Every Code](https://github.com/just-every/code) is a fast, local coding agent
for the terminal.

Install it with:

```sh
brew install justusschock/tap/just-every-code
```

Then launch it with:

```sh
coder
```

The `coder` executable conflicts with the unrelated
[`coder`](https://formulae.brew.sh/formula/coder) formula. Uninstall or unlink
that formula before installing `just-every-code`.

## Automatic updates

The `just-every-code` formula is checked against the latest upstream release
every day at 05:17 UTC. When a new version is available, the workflow verifies
all four release assets, updates their SHA-256 checksums, validates the formula,
and opens a pull request. It does not approve or merge the pull request.
