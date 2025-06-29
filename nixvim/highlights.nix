# nixvim/highlights.nix
# https://nix-community.github.io/nixvim/NeovimOptions/highlightOverride/index.html
{ pkgs, ... }:

{
  programs.nixvim = {
    highlightOverride = {

      #   # applies to the content and the surrounding quotes.
      #   String = {
      #     bg = "#293D34"; # A dark blue/gray background. Choose any color you like.
      #   };
      #
      #   # Apply color to the "function" keyword.
      #   TSKeywordFunction = {
      #     fg = "#f09336";
      #     bg = "#905820";
      #   };
      #
      #   # Make function definitions and calls bold.
      #   TSFunction = {
      #     bold = true;
      #   };
      #
      #   # Style for function arguments/parameters.
      #   TSParameter = {
      #     fg = "#F38D78";
      #     bg = "#613830";
      #   };
      #
    };
  };
}
