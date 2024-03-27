{
  plugins.bufferline.enable = true;
  colorschemes.melange.enable = true;
  keymaps = [
    {
      action = "<cmd>Neotree toggle<CR>";
      key = "<leader>e";
    }
    {
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      key = "gd";
      options = {
	silent = true;
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      key = "K";
      options = {
	silent = true;
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      key = "<leader>rn";
      options = {
	silent = true;
      };
    }
    {
      action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      key = "[d";
      options = {
	silent = true;
      };
    }
    {
      action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      key = "]d";
      options = {
	silent = true;
      };
    }
    # {
    #
    #   "<C-Space>" = "cmp.mapping.complete()";
    # }
    # {
    #   "<C-j>" = "cmp.mapping.scroll_docs(4)";
    # }
    # {
    #   "<C-k>" = "cmp.mapping.scroll_docs(-4)";
    # }
    {
      key = "<C-l>";
      action = "<cmd>lua cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })<CR>";
    }
    # {
    #   "<C-n>" = {
    #     action = ''
    #       function(fallback)
    #         if cmp.visible() then
    #           cmp.select_next_item()
    #         elseif require("luasnip").expand_or_jumpable() then
    #           require("luasnip").expand_or_jump()
    #         else
    #           fallback()
    #         end
    #       end
    #     '';
    #     modes = [ "i" "s" ];
    #   };
    # }
    # {
    #   "<C-p>" = {
    #     action = ''
    #       function(fallback)
    #         if cmp.visible() then
    #           cmp.select_prev_item()
    #         elseif require("luasnip").expand_or_jumpable() then
    #           require("luasnip").expand_or_jump()
    #         else
    #           fallback()
    #         end
    #       end
    #     '';
    #     modes = [ "i" "s" ];
    #   };
    # }
  ];

  globals = {
    mapleader = " ";
  };
  options = {
    number = true; # Show line numbers
    relativenumber = true; # Show relative line numbers
    shiftwidth = 2; # Tab width should be 2
  };

  plugins = {
    telescope = {
      enable = true;
      keymaps = {
	"<leader>ff" = {
	  action = "git_files";
	  desc = "Telescope Git Files";
	};
	"<leader>/" = "live_grep";
      };
    };
    treesitter.enable = true;
    lualine.enable = true;
    neo-tree.enable = true;
    noice.enable = true;
    copilot-vim.enable = true;


    lsp = {
      enable = true;

      servers = {
	tsserver.enable = true;
	rnix-lsp.enable = true;
	nixd.enable = true;

	lua-ls = {
	  enable = true;
	  settings.telemetry.enable = false;
	};
	rust-analyzer = {
	  enable = true;
	  installCargo = true;
	  installRustc = false;
	};
      };
    };

    cmp = {
      enable = true;
    };
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;

  };

  extraConfigLua = ''

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
	vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
	-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
	-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
  '';
}
