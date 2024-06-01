{
  keymaps = 
  (builtins.map (key: {
    inherit key;
    action = "<cmd>lua vim.lsp.buf.rename()<CR>";
    options = {
      silent = true;
      desc = "rename symbol";
    };
  }) [ 
    "<leader>rn"
    "<leader>cr"
  ])
  ++
  [
    # {
    #   action = "<cmd>lua vim.lsp.buf.definition()<CR>";
    #   key = "gd";
    #   options = {
    #     silent = true;
    #     desc = "go to definition";
    #   };
    # }
    # {
    #   action = "<cmd>lua vim.lsp.buf.references()<CR>";
    #   key = "gr";
    #   options = {
    #     silent = true;
    #     desc = "find references";
    #   };
    # }
    {
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      key = "K";
      options = {
        silent = true;
        desc = "show hover information";
      };
    }
    {
      action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      key = "[d";
      options = {
        silent = true;
        desc = "previous diagnostic";
      };
    }
    {
      action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      key = "]d";
      options = {
        silent = true;
        desc = "next diagnostic";
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      key = "<leader>ca";
      options = {
        silent = true;
        desc = "code action";
      };
    }
    {
      action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>";
      key = "<leader>lh";
      options = {
        silent = true;
        desc = "toggle inlay hints";
      };
    }
  ];
  plugins.lsp-format.enable = true;
  plugins.lsp = {
    enable = true;

    servers = {
      tsserver = {
        enable = true;
        settings = 
        let
          js_ts_config = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayVariableTypeHints = false;
            };
          };
        in {
          typescript = js_ts_config;
          javascript = js_ts_config;
        };
      };
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
}
