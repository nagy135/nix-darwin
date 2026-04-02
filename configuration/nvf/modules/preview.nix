{...}: {
  config.vim = {
    utility.preview.markdownPreview = {
      enable = true;
      filetypes = [
        "markdown"
        "norg"
      ];
    };

    keymaps = [
      {
        key = "<leader>mr";
        mode = "n";
        silent = true;
        desc = "Markdown preview toggle";
        action = "<cmd>MarkdownPreviewToggle<CR>";
      }
    ];
  };
}
