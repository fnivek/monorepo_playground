# A playground for me to test the concepts of a monorepo.
## Copybara Setup
### Github Authentication
Copybara needs credentials for github rest apis.
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
- git - version control.
- copybara - instead of submodules, for code sharing and individual releases.
