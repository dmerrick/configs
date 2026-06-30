# Dana's configs

My dotfiles, managed with [chezmoi](https://chezmoi.io).

Migrated from GNU Stow → chezmoi (2026-06). The repo is now chezmoi's source
format: `dot_zshrc` → `~/.zshrc`, `private_dot_ssh/` → `~/.ssh/` (0600), etc.

## Bootstrap a new machine

One command installs chezmoi, clones this repo, and applies everything —
dotfiles, then (on macOS) `brew bundle` and a few system defaults:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dmerrick/configs
```

On Linux (e.g. the seedbox) the macOS-only configs — Hammerspoon, Finicky,
SwiftBar — are skipped automatically via `.chezmoiignore`.

## Day-to-day

- `chezmoi edit ~/.zshrc` — edit a managed file (edits the source copy)
- `chezmoi apply` — write pending changes to `$HOME`
- `chezmoi diff` — preview what apply would change
- `chezmoi re-add` — pull a live edit back into the source
- `chezmoi cd` — open a shell in the source repo to commit/push

On this machine the source is `~/configs` (set in `~/.config/chezmoi/chezmoi.toml`);
a fresh `chezmoi init` defaults to `~/.local/share/chezmoi`. The `chezmoi`
commands work the same either way.

## What's tracked

zsh, git, ghostty, tmux, vim, ssh, finicky, hammerspoon, the SwiftBar plugins,
k9s config (applied to `~/.config/k9s`, read via `K9S_CONFIG_DIR`), `.aliases`,
and the `Brewfile`. The bootstrap scripts live in `run_*.tmpl`.

## SwiftBar plugins

`Documents/Swiftbar/*.sh` are menu-bar plugins in the portable
[xbar](https://github.com/matryer/xbar) format — plain scripts that print menu
lines to stdout. SwiftBar reads them from `~/Documents/Swiftbar` (chezmoi
creates that path on apply). The filename cadence (`name.1m.sh`) is the refresh
interval.

## Manual steps (not scriptable)

After the bootstrap command, finish the GUI-only bits:

- iCloud sign-in (leave Keychain sync off); enable FileVault
- Keyboard: Caps Lock → Escape; disable autocorrect/capitalization
- Sharing: set hostname; enable Screen Sharing + Remote Login
- Sign in to 1Password, Resilio Sync, RescueTime, OmniFocus, Fantastical
- Messages: enable iCloud Messages + SMS forwarding from iPhone
- Make Chrome the default browser / `mailto:` handler
- Generate an SSH key (`ssh-keygen -t ed25519`) and add it to GitHub
- App Store: sign in (the `mas` entries in the Brewfile need a logged-in account)
