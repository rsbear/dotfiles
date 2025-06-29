# homebrew.nix
# This file centralizes all Homebrew-related configuration.
{ inputs, config, ... }:
{
  # This import makes the `nix-homebrew` options available.
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  # This enables the `homebrew` module from nix-darwin.
  homebrew.enable = true;

  # Configure the nix-homebrew extension.
  nix-homebrew = {
    enable = true;
    # Use the primaryUser defined in the main configuration for consistency.
    user = config.system.primaryUser;
    enableRosetta = true;
    mutableTaps = false;
    # Manage Homebrew taps centrally from your flake inputs.
    taps = {
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
  };
}
