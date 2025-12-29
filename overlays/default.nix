{ inputs, self, ... }:
{
  flake.overlays.default =
    final: prev:
    let
      # Create a nixpkgs instance with unfree enabled and the vscode extensions overlay
      vscode-pkgs = import inputs.nixpkgs {
        system = prev.stdenv.hostPlatform.system;
        config.allowUnfree = true;
        overlays = [ inputs.nix-vscode-extensions.overlays.default ];
      };
    in
    {
      stable = import inputs.nixpkgs-stable {
        config.allowUnfree = true;
        system = prev.stdenv.hostPlatform.system;
        overlays = prev.lib.attrValues self.overlays;
      };
      # Use vscode-marketplace from the overlay-enabled nixpkgs
      # This way it inherits the allowUnfree configuration
      vscode-marketplace = vscode-pkgs.vscode-marketplace;
    };
}
