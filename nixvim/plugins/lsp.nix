{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        # keymaps = {
        #   silent = true;
        #   diagnostic = {
        #     # Navigate in diagnostics
        #     "<leader>k" = "goto_prev";
        #     "<leader>j" = "goto_next";
        #   };
        #
        #   lspBuf = {
        #     gd = "definition";
        #     gD = "references";
        #     gt = "type_definition";
        #     gi = "implementation";
        #     K = "hover";
        #     re = "rename";
        #   };
        # };

        servers = {
          gopls = {
            enable = true;
            filetypes = [
              "go"
              "gomod"
              "gowork"
              "gotmpl"
            ];
            settings = {
              usePlaceholders = true;
              completeUnimported = true;
              completeFunctionCalls = true;
              staticcheck = true;
              matcher = "fuzzy";
              analyses = {
                unusedparams = true;
                shadow = true;
              };
            };
          };
          nixd = {
            enable = true;
            # settings =
            #   let
            #     flake = ''(builtins.getFlake "github:elythh/flake)""'';
            #     flakeNixvim = ''(builtins.getFlake "github:elythh/nixvim)""'';
            #   in
            #   {
            #     nixpkgs = {
            #       expr = "import ${flake}.inputs.nixpkgs { }";
            #     };
            #     formatting = {
            #       command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
            #     };
            #     options = {
            #       nixos.expr = ''${flake}.nixosConfigurations.grovetender.options'';
            #       nixvim.expr = ''${flakeNixvim}.packages.${pkgs.system}.default.options'';
            #     };
            #   };
          };
          yamlls = {
            enable = true;
            settings = {
              schemaStore = {
                enable = false;
                url = "";
              };
            };
          };
          denols.enable = true;
          golangci_lint_ls.enable = true;
          lua_ls.enable = true;
          cssls.enable = true; # CSS
          tailwindcss.enable = true; # TailwindCSS
          html.enable = true; # HTML
          astro.enable = true; # AstroJS
          svelte.enable = false; # Svelte
          pyright.enable = true; # Python
          nil_ls.enable = true; # Nix
          dockerls.enable = true; # Docker
          bashls.enable = true; # Bash
          markdown_oxide.enable = true; # Markdown
        };
      };
      lsp-format = {
        enable = true;
      };
    };
  };
}
