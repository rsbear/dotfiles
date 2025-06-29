# nixvim/default.nix
# This is where Neovim configuration lives.
{ pkgs, ... }:

{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./autocmds.nix
    ./highlights.nix
    ./plugins
  ];

  # Enable the nixvim program
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # colorschemes.catppuccin.enable = true;
    # colorscheme = "catppuccin";

    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        background.dark = "mocha";
        background.light = "latte";
        transparent_background = true;
        show_end_of_buffer = false;

        styles.functions = [ "bold" ];

        color_overrides = {
          # dark mode
          mocha = {
            blue = "#e5e5e5";
            lavender = "#cccbcb";
            mauve = "#cccbcb";
            pink = "#cccbcb";
            rosewater = "#cccbcb";
            sapphire = "#cccbcb";
            sky = "#cccbcb";
            subtext1 = "#cccbcb";
            subtext2 = "#cccbcb";
            text = "#cccbcb";
            teal = "#979696";
            yellow = "#979696";

            overlay2 = "#858281";
          };
          # light mode
          latte = {
            blue = "#000000";
          };
        };

        custom_highlights = {
          # 1. Ensure string CONTENT and delimiters are highlighted
          # We add more specific string captures to ensure the content is included.
          "@string" = {
            fg = "#76BD92";
            bg = "NONE";
          };
          "@string.fragment" = {
            fg = "#76BD92";
            bg = "NONE";
          };
          "@string.content" = {
            fg = "#76BD92";
            bg = "NONE";
          };

          # Style for the 'function' and 'return' keywords
          "@keyword.function" = {
            fg = "#F5A06C";
            bg = "NONE";
          };
          "@keyword.return" = {
            fg = "#F5A06C";
            bg = "NONE";
          };

          #  Style for function parameters/arguments
          "@parameter" = {
            fg = "#D6C1D5";
            bg = "NONE";
          };

          # Brackets like <, >, />, etc.
          "@punctuation.bracket" = {
            fg = "#858281";
          }; # Gray
          "@tag.delimiter" = {
            fg = "#858281";
          }; # Gray (fallback)

          # Standard HTML tags like div, span, p
          "@tag" = {
            fg = "#cccbcb";
          }; # Light Gray

          # Custom components like <MyComponent>
          "@constructor" = {
            fg = "#ffffff";
          }; # White

        };

      };
    };

  };
}

# colorschemes.palette = {
#   enable = false;
#   settings = {
#
#     custom_palettes.main = {
#       darc = {
#         color0 = "NONE";
#         color1 = "#291415";
#         color2 = "#544344";
#         color3 = "#7F7273"; # keywords i think
#         color4 = "#948A8A"; # literal quotes as in "
#         color5 = "#A9A1A1"; # object properties
#         color6 = "#BFB9B9"; # comments
#         color7 = "#EAE8E8";
#         color8 = "#FFFFFF";
#       };
#       lite = {
#         color0 = "NONE";
#         color1 = "#FFFFFF";
#         color2 = "#D4D0D0";
#         color3 = "#A9A1A1"; # comments
#         color4 = "#948A8A"; # object properties
#         color5 = "#7F7273"; # literal quotes as in "
#         color6 = "#544344"; # keywords i think
#         color7 = "#3E2C2C";
#         color8 = "#291415";
#       };
#     };
#   };
#
# };
