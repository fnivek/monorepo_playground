{
  description = "An empty flake template that you can adapt to your own environment";

  # Flake inputs
  inputs = {
    # Unstable packages from nixpkgs.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Stable Nixpkgs from flake hub.
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
  };

  # Flake outputs
  outputs =
    { ... }@inputs:
    let
      # The systems supported for this flake's outputs
      supportedSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper for providing system-specific attributes
      forEachSupportedSystem =
        f:
        inputs.nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            # Provides a system-specific, configured Nixpkgs
            pkgs = import inputs.nixpkgs {
              inherit system;
              # Enable using unfree packages
              config.allowUnfree = true;
            };
            pkgs-unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          }
        );
    in
    {
      # Development environments output by this flake
      devShells = forEachSupportedSystem (
        { pkgs, pkgs-unstable }:
        {
          # Run `nix develop` to activate this environment or `direnv allow` if you have direnv installed
          default = pkgs.mkShell {
            # The Nix packages provided in the environment
            packages = with pkgs; [
              # Version control
              git
              pkgs-unstable.copybara

              # Language servers.
              helix
              nixfmt-rfc-style
              nil
              nixd
              vscode-langservers-extracted
              yaml-language-server
              # Ansible is broken see https://github.com/ansible/vscode-ansible/issues/1144
              # ansible-language-server
              taplo
              bash-language-server
              clang
              clang-tools

              # Go task
              go-task

              # environment control
              direnv
              nix-direnv
            ];

            # Set any environment variables for your development environment
            env = { };

            # Add any shell logic you want executed when the environment is activated
            shellHook = ''
              printf "Monorepo test.\n"
            '';
          };
        }
      );
    };
}
