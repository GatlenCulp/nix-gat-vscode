{ inputs, self, ... }:
{
  flake.overlays.default = (
    final: prev: {
      stable = import inputs.nixpkgs-stable {
        allowUnfree = true;
        system = prev.stdenv.hostPlatform.system;
        overlays = prev.lib.attrValues self.overlays;
      };
      # Add vscode-marketplace from nix-vscode-extensions
      vscode-marketplace = inputs.nix-vscode-extensions.extensions.${prev.stdenv.hostPlatform.system}.vscode-marketplace;
    }
  );
}
