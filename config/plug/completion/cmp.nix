_:
let
  get_bufnrs.__raw = ''
    function()
      local buf_size_limit = 10 * 1024 -- 1MB size limit
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
        performance = {
          debounce = 100; # Delay before triggering completion
          throttle = 30; # Limit completion frequency
          fetching_timeout = 100; # Faster timeout for sources
          confirm_resolve_timeout = 80;
          async_budget = 1; # Process completions over multiple frames
          max_view_entries = 10; # Limit visible completions
        };
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
            name = "luasnip";
            priority = 1000;
          }
          {
            name = "nvim_lsp";
            priority = 750;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "nvim_lsp_signature_help";
            priority = 750;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "nvim_lsp_document_symbol";
            priority = 750;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "treesitter";
            priority = 300;
            option = {
              inherit get_bufnrs;
            };
          }
          {
            name = "buffer";
            priority = 500;
            keywordLength = 4;
            option = {
              inherit get_bufnrs;
            };
          }
          # {
          #   name = "rg";
          #   priority = 300;
          # }
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
            keywordLength = 4;
          }
          {
            name = "git";
            priority = 250;
          }
          # {
          #   name = "calc";
          #   priority = 150;
          # }
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
