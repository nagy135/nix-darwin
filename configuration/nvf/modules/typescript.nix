{...}: {
  config.vim.languages.ts = {
    enable = true;
    lsp.servers = ["tsgo"];
    extensions = {
      # "ts-error-translator" = {
      #   enable = true;
      #   setupOpts = {
      #     auto_attach = true;
      #     auto_override_publish_diagnostics = false;
      #     servers = [ "tsgo" ];
      #   };
      # };
    };
  };
}
