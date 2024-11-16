_:
let
  get_bufnrs.__raw = ''
    function()
      local buf_size_limit = 1024 * 1024 -- 1MB size limit
      local bufs = vim.api.nvim_list_bufs()
      local valid_bufs = {}
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf)) < buf_size_limit then
          table.insert(valid_bufs, buf)
        end
      end
      return valid_bufs
    end
  '';
in
{
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        window = {
          completion.border = "rounded";
          documentation.border = "rounded";
        };
        mapping = {
          "<A-d>" = # Lua
            "cmp.mapping.scroll_docs(-4)";
          "<A-f>" = # Lua
            "cmp.mapping.scroll_docs(4)";
          "<A-Space>" = # Lua
            "cmp.mapping.complete()";
          "<A-e>" = # Lua
            "cmp.mapping.close()";
          "<Tab>" = # Lua
            "cmp.mapping(function(fallback)
									if cmp.visible() then
										cmp.select_next_item()
									elseif require('luasnip').locally_jumpable(1) then
										require('luasnip').jump(1)
									else
										fallback()
									end
								end, {'i','s'})";
          "<S-Tab>" = # Lua
            "cmp.mapping(function(fallback)
									if cmp.visible() then
										cmp.select_prev_item()
									elseif require('luasnip').locally_jumpable(-1) then
										require('luasnip').jump(-1)
									else
										fallback()
									end
								end, {'i','s'})";
          "<CR>" = # Lua
            "cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })";
        };

        preselect = # Lua
          "cmp.PreselectMode.None";

        snippet.expand = # Lua
          "function(args) require('luasnip').lsp_expand(args.body) end";

        sources = [
          {
            name = "nvim_lsp";
            priority = 1000;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "nvim_lsp_signature_help";
            priority = 1000;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "nvim_lsp_document_symbol";
            priority = 1000;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "treesitter";
            priority = 850;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "luasnip";
            priority = 750;
          }
          {
            name = "buffer";
            priority = 500;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "copilot";
            priority = 400;
          }
          {
            name = "rg";
            priority = 300;
          }
          {
            name = "path";
            priority = 300;
          }
          {
            name = "cmdline";
            priority = 300;
          }
          {
            name = "spell";
            priority = 300;
          }
          {
            name = "git";
            priority = 250;
          }
          {
            name = "calc";
            priority = 150;
          }
          {
            name = "emoji";
            priority = 100;
          }
        ];
      };
    };

    # friendly-snippets.enable = true;
    luasnip.enable = true;

    lspkind = {
      enable = true;

      cmp = {
        enable = true;

        menu = {
          buffer = "";
          calc = "";
          cmdline = "";
          codeium = "󱜙";
          emoji = "󰞅";
          git = "";
          luasnip = "";
          neorg = "";
          nvim_lsp = "";
          nvim_lua = "";
          path = "";
          spell = "";
          treesitter = "󰔱";
        };
      };
    };
  };
}