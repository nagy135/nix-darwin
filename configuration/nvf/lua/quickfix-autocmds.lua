local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    if vim.opt_local.modifiable:get() then
      require("lint").try_lint()
    end
  end,
})

local function set_qf_maps(buf)
  vim.keymap.set("n", "dd", function()
    local lnum = vim.fn.line(".") - 1
    local qflist = vim.fn.getqflist()
    table.remove(qflist, lnum + 1)
    vim.fn.setqflist(qflist, "r")
  end, { buffer = buf, silent = true })

  vim.keymap.set("n", "q", "<cmd>cclose<cr>", { buffer = buf, silent = true })

  vim.keymap.set("n", ">", function()
    require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
  end, { buffer = buf, desc = "Expand quickfix context" })

  vim.keymap.set("n", "<", function()
    require("quicker").collapse()
  end, { buffer = buf, desc = "Collapse quickfix context" })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args)
    set_qf_maps(args.buf)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

local ts_log_maps = {
  ["<leader>;p"] = { "yiwoconsole.log('', );<ESC>hPF'P<ESC>", "variable" },
  ["<leader>;P"] = { "yiwOconsole.log('', );<ESC>hPF'P<ESC>", "variable (above)" },
  ["<leader>;;p"] = { "yiwoconsole.log('================\\n', '', , '\\n================');<ESC>F,PF'Pa: <ESC>", "variable with lines" },
  ["<leader>;;P"] = { "yiwOconsole.log('================\\n', '', , '\\n================');<ESC>F,PF'Pa: <ESC>", "variable with lines (above)" },
  ["<leader>;;j"] = { "yiwoconsole.log('================\\n', '', , '\\n================');<ESC>F,PF'Pa: <ESC>f,laJSON.stringify(<ESC>f,i, null, 2)<ESC>", "JSON.stringify variable with lines" },
  ["<leader>;;J"] = { "yiwOconsole.log('================\\n', '', , '\\n================');<ESC>F,PF'Pa: <ESC>f,laJSON.stringify(<ESC>f,i, null, 2)<ESC>", "JSON.stringify variable with lines (above)" },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function(args)
    for lhs, spec in pairs(ts_log_maps) do
      vim.keymap.set("n", lhs, spec[1], { buffer = args.buf, desc = spec[2] })
    end
  end,
})
