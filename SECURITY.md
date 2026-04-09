# Security Policy

This repository is a personal Neovim configuration. It is not a product and has no release cadence — there is only `master`.

## Scope

The realistic security concerns for a config like this are:

- A plugin spec that pulls code from a compromised or typosquatted source.
- A keymap, autocmd, or `conform`/LSP command that executes untrusted input from a buffer.
- Accidentally committed secrets (tokens, SSH keys, `.env` files).
- A `lazy-lock.json` pin that resolves to a known-malicious commit.

Anything outside that scope (upstream plugin vulnerabilities, Neovim core CVEs, OS-level issues) should be reported to the respective upstream project, not here.

## Reporting a vulnerability

**Do not open a public issue for a security problem.**

Use GitHub's **"Report a vulnerability"** button under the *Security* tab of this repository (private vulnerability reporting). If that is unavailable, contact the maintainer directly via the email address on their GitHub profile.

Please include:

- The file and line(s) involved.
- A description of the issue and the impact (what an attacker could do).
- Reproduction steps, if applicable.
- The commit SHA you observed the issue on.

You should expect an acknowledgement within a few days. Fixes land directly on `master`; there is no backport process.

## Supported versions

Only the current `master` is supported. Older commits are not patched.
