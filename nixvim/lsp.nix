{
  keymaps = 
  (builtins.map (key: {
    inherit key;
    action = "<cmd>lua vim.lsp.buf.rename()<CR>";
    options = {
      silent = true;
    };
  }) [ "<leader>rn" "<leader>gr" ])
  ++
  [
    {
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      key = "gd";
      options = {
        silent = true;
      };
    }
    {
      action = "<cmd>lua vim.lsp.buf.references()<CR>";
      key = "gr";
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
    {
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      key = "<leader>ca";
      options = {
        silent = true;
      };
    }
  ];
  plugins.lsp-format.enable = true;
  plugins.lsp = {
    enable = true;

    servers = {
      tsserver.enable = true;
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
