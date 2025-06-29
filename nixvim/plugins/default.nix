{
  imports = [
    ./blink-cmp.nix
    ./lsp.nix
    ./none-ls.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    plugins.web-devicons.enable = true;
    plugins.snacks = {
      enable = true;
    };
    plugins.trouble = {
      enable = true;
    };
    plugins.oil = {
      enable = true;
    };
    plugins.grug-far = {
      enable = true;
      settings = {
        debounceMs = 1000;
        minSearchChars = 1;
        maxSearchMatches = 2000;
        normalModeSearch = false;
        maxWorkers = 8;
        engine = "ripgrep";
        engines = {
          ripgrep = {
            path = "rg";
            showReplaceDiff = true;
          };
        };
      };
    };
    plugins = {
      # A beautiful and functional statusline
      lualine.enable = true;
    };

  };
}
