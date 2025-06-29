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
    inputs@{ self
    , nix-darwin
    , nixpkgs
    , home-manager
    , nixvim
    , nix-homebrew
    , homebrew-core
    , homebrew-cask
    , homebrew-bundle
    }:
    let
      username = "rr";
      configuration = { pkgs, ... }: {
        system.primaryUser = "rr";

        environment.systemPackages = [ ];

        nix.settings.experimental-features = "nix-command flakes";

        users.users.${username} = {
          name = username;
          home = "/Users/${username}";
        };

        # Home Manager configuration for the user.
        home-manager.users.${username} = { pkgs, ... }: {

          imports = [
            # Import the nixvim module
            nixvim.homeManagerModules.nixvim
            # Import your custom nixvim configuration
            ./nixvim

            ./shells.nix
            ./evil-helix.nix
          ];

          home.stateVersion = "23.11";
          nixpkgs.config.allowUnfree = true;
          # Enable custom fonts
          fonts.fontconfig.enable = true;

          # User-specific packages are managed here.
          # The shell tools have been moved to shells.nix
          home.packages = [
            pkgs.git

            # apps
            # pkgs.vim # <<< REMOVE THIS, nixvim provides Neovim >>>
            pkgs.httpie
            pkgs.qmk
            pkgs.lazygit
            pkgs.warp-terminal

            # lang stuff
            pkgs.deno
            pkgs.go
            pkgs.gopls
            pkgs.golangci-lint
            pkgs.tailwindcss
          ];

          programs.git = {
            enable = true;
            userName = "rsbear";
            userEmail = "hellorosss@gmail.com";
            extraConfig = {
              init.defaultBranch = "main";
              # <<< CHANGE THIS TO USE THE NIXVIM-PROVIDED EDITOR >>>
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

        homebrew.enable = true;
        homebrew.casks = [
          "ghostty"
        ];
        homebrew.brews = [ ];

        system.defaults = {
          NSGlobalDomain = {
            InitialKeyRepeat = 10;
            KeyRepeat = 1;
          };
          finder.AppleShowAllExtensions = true;
        };
        system.keyboard = {
          enableKeyMapping = true;
        };

        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 5;
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      darwinConfigurations."Rosss-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "rr";
              taps = {
                "homebrew/homebrew-bundle" = homebrew-bundle;
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
              mutableTaps = false;
            };
          }
        ];
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
    };
}
