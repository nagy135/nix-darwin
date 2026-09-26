{pkgs, ...}: let
  # nixpkgs does not bundle Chromium on macOS. Use the installed Chrome,
  # while allowing another browser via PUPPETEER_EXECUTABLE_PATH.
  mermaidCli =
    if pkgs.stdenv.hostPlatform.isDarwin
    then
      pkgs.writeShellScriptBin "mmdc" ''
        export PUPPETEER_EXECUTABLE_PATH="''${PUPPETEER_EXECUTABLE_PATH:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
        exec ${pkgs.mermaid-cli}/bin/mmdc "$@"
      ''
    else pkgs.mermaid-cli;
in {
  config.vim.languages.markdown = {
    enable = true;
    treesitter.enable = true;
    lsp.enable = false;
    format.enable = false;
    extraDiagnostics.enable = false;
    extensions.render-markdown-nvim.enable = true;
  };

  config.vim.utility.images.image-nvim = {
    enable = true;
    setupOpts = {
      backend = "kitty";
      processor = "magick_cli";
      max_width_window_percentage = 90;
      max_height_window_percentage = 50;
      integrations.markdown = {
        enabled = true;
        download_remote_images = false;
      };
    };
  };

  config.vim.extraPackages = [mermaidCli];

  # nvf initializes extraPlugins after its built-in image.nvim module.
  config.vim.extraPlugins.diagram-nvim = {
    # Pin the executable: ~/.zshenv can reorder PATH in the plugin's jobs.
    package = pkgs.vimPlugins.diagram-nvim.overrideAttrs (old: {
      postPatch =
        (old.postPatch or "")
        + ''
          substituteInPlace lua/diagram/renderers/mermaid.lua \
            --replace-fail '"mmdc"' '"${mermaidCli}/bin/mmdc"'
        '';
    });
    setup = ''
      require("diagram").setup({
        integrations = { require("diagram.integrations.markdown") },
        events = {
          render_buffer = { "InsertLeave", "TextChanged", "BufWritePost" },
        },
        renderer_options = {
          mermaid = { theme = "dark", background = "transparent", scale = 2 },
        },
      })

      -- Render after startup/window layout rather than inside BufWinEnter.
      vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter" }, {
        callback = function(event)
          local buf = event.buf
          vim.schedule(function()
            if vim.api.nvim_get_current_buf() == buf and vim.bo[buf].filetype == "markdown" then
              require("diagram").render()
            end
          end)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.keymap.set("n", "<leader>mp", require("render-markdown").toggle,
            { buffer = event.buf, desc = "Markdown preview (toggle)" })
          vim.keymap.set("n", "<leader>mv", require("diagram").show_diagram_hover,
            { buffer = event.buf, desc = "View diagram in new tab" })
          vim.keymap.set("n", "<leader>mr", require("diagram").render,
            { buffer = event.buf, desc = "Refresh Markdown diagrams" })
        end,
      })
    '';
  };

  config.vim.notes = {
    todo-comments.enable = true;
    neorg = {
      enable = true;
      treesitter.enable = true;
      setupOpts = {
        load = {
          "core.defaults".enable = true;
          "core.concealer" = {};
          "core.dirman" = {
            config = {
              workspaces = {
                wiki = "~/wiki";
              };
              default_workspace = "wiki";
            };
          };
        };
      };
    };
  };
}
