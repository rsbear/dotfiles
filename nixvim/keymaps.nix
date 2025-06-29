{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    plugins = {
      lsp = {

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            re = "rename";
          };
        };
      };
    };

    # Keymaps
    keymaps = [
      {
        action = ":Oil<CR>";
        key = "<leader><space>";
        options = {
          silent = true;
          noremap = true;
          desc = "Oil Mapping";
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options = {
          silent = true;
          desc = "Code action";
        };
      }

      {
        mode = "n";
        key = "<leader>so";
        action = ''<cmd>lua Snacks.picker.lsp_symbols()<cr>'';
        options = {
          desc = "Find lsp document symbols";
        };
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = ''<cmd>lua Snacks.picker.colorschemes()<cr>'';
        options = {
          desc = "~Find~ theme";
        };
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        options = {
          desc = "~Find~ live grep";
        };
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = ''<cmd>lua Snacks.picker.smart()<cr>'';
        options = {
          desc = "~Find~ Smart (Frecency)";
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = ''
          <cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })<cr>
        '';
        options = {
          desc = "~Find~ Grug-Far";
        };
      }

      {
        mode = "n";
        key = "<leader>w";
        action = ":w<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "Save buffer";
        };
      }

      {
        mode = "n";
        key = "?";
        action = ''<cmd>lua Snacks.picker.grep({ default_text = vim.fn.expand("<cword>") })<cr>'';
        options = {
          silent = true;
          noremap = true;
          desc = "Grep word under cursor using Snacks picker";
        };
      }

    ];
  };
}
