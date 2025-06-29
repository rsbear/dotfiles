# ./shells.nix
# This file manages all shell-related tools and configurations.
{ pkgs, ... }:

{
  # Install packages that don't have a specific home-manager module
  # or are dependencies for other tools. The fonts are also placed here.
  home.packages = with pkgs; [
    ripgrep # A fast grep alternative, often used by other tools.
    nerd-fonts.jetbrains-mono
    nerd-fonts.geist-mono
  ];

  programs.zsh = {
    enable = true;
    # If this option is not disabled
    # `home-manager` installs `nix-zsh-completions`
    # which conflicts with `nix` in `home.packages`
    enableCompletion = false;
    autosuggestion.enable = true;
    shellAliases = {
      ls = "eza --icons";
      l = "eza -l --icons";
      ll = "eza -la --icons";
      la = "eza -a --icons";
      lt = "eza --tree --icons";
      lg = "lazygit";
      dots = "cd ~/.config";
      goodwork = "cd ~/goodwork";
      nixi = "sudo nix run nix-darwin -- switch --flake ~/.config";
    };
  };

  programs.nushell = {
    enable = true;
    # You can add initial configuration for nushell here
    extraConfig = ''
      # Don't show the welcome banner on startup
      $env.config = {
        show_banner: true
      }
    '';
  };

  programs.starship = {
    enable = true;
    # Automatically enables starship for supported shells (zsh, nushell, etc.)
    enableZshIntegration = true;
    enableNushellIntegration = true;
    # You can configure starship declaratively here, for example:
    # settings = {
    #   add_newline = false;
    #   format = "[](fg:color_blue) ... "; # Example format
    # };
  };

  # better shell history
  programs.atuin = {
    enable = true;
    # This automatically sets up shell integration for magical history
    enableZshIntegration = true;
    enableNushellIntegration = true;
    # You can add Atuin settings here, e.g., to configure sync
    # settings = {
    #   sync_address = "https://api.atuin.sh";
    # };
  };

  programs.zoxide = {
    enable = true;
    # Sets up the `z` command for intelligent `cd`
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  programs.eza = {
    enable = true;
    # Creates common aliases in Zsh (ls, l, ll, la)
    git = true;
    icons = "auto";
  };

  programs.yazi = {
    enable = true;
    # Sets up the 'yy' command to cd on quit
    enableZshIntegration = true;
  };

}
