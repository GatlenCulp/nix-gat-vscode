{
  description = "Gatlen's VSCode Configuration via Nix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";

    # hooks for git
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      _module.args = { inherit inputs; };
      imports = [
        ./modules/flake
        ./overlays
      ];

      # Expose Home Manager modules for use in home-manager configurations
      flake.homeManagerModules = import ./modules/home-manager;
    };
}
