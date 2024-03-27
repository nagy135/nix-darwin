{
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
