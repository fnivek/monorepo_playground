# A playground for me to test the concepts of a monorepo

[![Lint](https://github.com/fnivek/monorepo_playground/actions/workflows/ci.yml/badge.svg)](https://github.com/fnivek/monorepo_playground/actions/workflows/ci.yml)

## Copybara Setup

### GitHub Authentication

Copybara needs credentials for GitHub rest APIs.

- Make a fine-grained token
  - Give access to all repos copybara will use
  - Give it read write access to pull requests
  - Copy the token, you only get one chance to see it
- Export these environment variables
  - GITHUB_TOKEN='paste your token here.'
  - GIT_TERMINAL_PROMPT=0

## Development Tools

- nix - for reproducable builds and dev environments.
- gotask - for task automation.
- direnv - for automated environment setup.
- Git - version control.
- copybara - instead of submodules, for code sharing and individual releases.
