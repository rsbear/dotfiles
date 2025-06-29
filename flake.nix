{
  description = "Darwin system flake with Git, SSH, and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      # Define the username for easy reuse.
      username = "rr";

      # Common configuration shared across all hosts.
      # Host-specific settings, like homebrew packages, have been removed.
      commonConfiguration =
        { pkgs, ... }:
        {
          system.primaryUser = username;

          environment.systemPackages = [ ];

          nix.settings.experimental-features = "nix-command flakes";

          users.users.${username} = {
            name = username;
            home = "/Users/${username}";
          };

          # Home Manager configuration for the user.
          home-manager.users.${username} =
            { pkgs, ... }:
            {
              imports = [
                # Import the nixvim module
                inputs.nixvim.homeManagerModules.nixvim
                # Import your custom nixvim, shells, and other configs
                ./nixvim
                ./shells.nix
                ./evil-helix.nix
              ];

              home.stateVersion = "23.11";
              nixpkgs.config.allowUnfree = true;
              fonts.fontconfig.enable = true;

              # User-specific packages are managed here.
              home.packages = with pkgs; [
                git
                httpie
                qmk
                lazygit
                warp-terminal
                # lang stuff
                deno
                go
                gopls
                golangci-lint
                tailwindcss
              ];

              programs.git = {
                enable = true;
                userName = "rsbear";
                userEmail = "hellorosss@gmail.com";
                extraConfig = {
                  init.defaultBranch = "main";
                  core.editor = "${pkgs.neovim}/bin/nvim";
                  pull.rebase = true;
                };
              };

              programs.ssh = {
                enable = true;
                matchBlocks = {
                  "github.com" = {
                    user = "git";
                    identityFile = "/Users/${username}/.ssh/id_ed25519_github";
                  };
                };
              };
            };

          services.karabiner-elements = {
            enable = true;
            package = pkgs.karabiner-elements.overrideAttrs (old: {
              version = "14.13.0";
              src = pkgs.fetchurl {
                inherit (old.src) url;
                hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
              };
              dontFixup = true;
            });
          };

          system.defaults = {
            NSGlobalDomain = {
              InitialKeyRepeat = 10;
              KeyRepeat = 1;
            };
            finder.AppleShowAllExtensions = true;
          };
          system.keyboard.enableKeyMapping = true;

          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 5;
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      darwinConfigurations."Rosss-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        # Pass flake inputs to all modules automatically.
        specialArgs = { inherit inputs; };
        modules = [
          # 1. Import the common configuration for all hosts.
          commonConfiguration

          # 2. Import Home Manager for darwin.
          home-manager.darwinModules.home-manager

          # 3. Import the new, centralized homebrew configuration.
          ./homebrew.nix

          # 4. Define host-specific settings, like which Homebrew packages to install.
          {
            homebrew.casks = [
              "ghostty"
            ];
            homebrew.brews = [
              # You can add command-line tools here, e.g., "jq"
            ];
          }
        ];
      };

      # Formatter for the project.
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
    };
}
