{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.none-ls = {
      enable = true;
      enableLspFormat = true;
      settings = {
        updateInInsert = false;
      };
      sources = {
        code_actions = {
          gitsigns.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          statix.enable = true;
          yamllint.enable = true;
        };
        formatting = {
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
          # prettier = {
          #   enable = true;
          #   disableTsServerFormatter = true;
          #   settings = ''
          #     {
          #       extra_args = { "--no-semi" },
          #     }
          #   '';
          # };
          stylua.enable = true;
          yamlfmt = {
            enable = true;
          };
          hclfmt.enable = true;
        };
      };
    };
  };
}
