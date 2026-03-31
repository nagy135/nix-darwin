local function get_dotfiles_root()
  local config_path = vim.uv.fs_realpath(vim.fn.stdpath("config")) or vim.fn.stdpath("config")
  return vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(config_path)))
end

local function get_wiki_root()
  local dotfiles_root = get_dotfiles_root()
  local candidates = {
    vim.fn.expand("~/wiki"),
    dotfiles_root .. "/wiki/wiki",
    vim.fn.expand("~/vimwiki"),
    dotfiles_root .. "/wiki/vimwiki",
  }

  for _, wiki_root in ipairs(candidates) do
    if vim.fn.isdirectory(wiki_root) == 1 then
      if vim.uv.fs_stat(wiki_root .. "/index.norg") or vim.uv.fs_stat(wiki_root .. "/index.wiki") then
        return wiki_root
      end
    end
  end

  for _, wiki_root in ipairs(candidates) do
    if vim.fn.isdirectory(wiki_root) == 1 then
      return wiki_root
    end
  end

  return vim.fn.expand("~/wiki")
end

local function open_wiki_index()
  local wiki_root = get_wiki_root()
  local candidates = {
    wiki_root .. "/index.norg",
    wiki_root .. "/index.wiki",
    wiki_root .. "/README.md",
  }

  for _, path in ipairs(candidates) do
    if vim.uv.fs_stat(path) then
      vim.cmd.edit(vim.fn.fnameescape(path))
      return
    end
  end

  vim.notify("No wiki index file found in " .. wiki_root, vim.log.levels.WARN)
end

function _G.GetJsonPath()
  local node = vim.treesitter.get_node()
  if not node then
    print("No node found!")
    return
  end

  local path = {}
  while node do
    if node:type() == "pair" then
      local key_node = node:child(0)
      if key_node and key_node:type() == "string" then
        local key_text = vim.treesitter.get_node_text(key_node, 0)
        table.insert(path, 1, key_text)
      end
    end
    node = node:parent()
  end

  print("JSON Path: " .. table.concat(path, "."))
end

local snacks_maps = {
  ["<leader><space>"] = { function() Snacks.picker.smart() end, "Smart Find Files" },
  ["<leader>,"] = { function() Snacks.picker.buffers() end, "Buffers" },
  ["<leader>/"] = { function() Snacks.picker.grep() end, "Grep" },
  ["<leader>:"] = { function() Snacks.picker.command_history() end, "Command History" },
  ["<leader>n"] = { function() Snacks.notifier.show_history() end, "Notification History" },
  ["<leader><leader>e"] = { function() Snacks.explorer() end, "File Explorer" },
  ["<leader>fb"] = { function() Snacks.picker.buffers() end, "Buffers" },
  ["<leader>fc"] = { function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, "Find Config File" },
  ["<leader>ff"] = { function() Snacks.picker.files() end, "Find Files" },
  ["<leader>fg"] = { function() Snacks.picker.git_files() end, "Find Git Files" },
  ["<leader>fp"] = { function() Snacks.picker.projects() end, "Projects" },
  ["<leader>fr"] = { function() Snacks.picker.recent() end, "Recent" },
  ["<leader>gb"] = { function() Snacks.picker.git_branches() end, "Git Branches" },
  ["<leader>gl"] = { function() Snacks.picker.git_log() end, "Git Log" },
  ["<leader>gL"] = { function() Snacks.picker.git_log_line() end, "Git Log Line" },
  ["<leader>gs"] = { function() Snacks.picker.git_status() end, "Git Status" },
  ["<leader>gS"] = { function() Snacks.picker.git_stash() end, "Git Stash" },
  ["<leader>gx"] = { function() Snacks.picker.git_diff() end, "Git Diff (Hunks)" },
  ["<leader>gf"] = { function() Snacks.picker.git_log_file() end, "Git Log File" },
  ["<leader>sB"] = { function() Snacks.picker.grep_buffers() end, "Grep Open Buffers" },
  ["<leader>sw"] = { function() Snacks.picker.grep_word() end, "Visual selection or word", { mode = { "n", "x" } } },
  ["<leader>s\""] = { function() Snacks.picker.registers() end, "Registers" },
  ["<leader>sa"] = { function() Snacks.picker.autocmds() end, "Autocmds" },
  ["<leader>sb"] = { function() Snacks.picker.lines() end, "Buffer Lines" },
  ["<leader>sc"] = { function() Snacks.picker.command_history() end, "Command History" },
  ["<leader>sC"] = { function() Snacks.picker.commands() end, "Commands" },
  ["<leader>sd"] = { function() Snacks.picker.diagnostics() end, "Diagnostics" },
  ["<leader>sD"] = { function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics" },
  ["<leader>sh"] = { function() Snacks.picker.help() end, "Help Pages" },
  ["<leader>sH"] = { function() Snacks.picker.highlights() end, "Highlights" },
  ["<leader>si"] = { function() Snacks.picker.icons() end, "Icons" },
  ["<leader>sj"] = { function() Snacks.picker.jumps() end, "Jumps" },
  ["<leader>sk"] = { function() Snacks.picker.keymaps() end, "Keymaps" },
  ["<leader>sl"] = { function() Snacks.picker.loclist() end, "Location List" },
  ["<leader>sm"] = { function() Snacks.picker.marks() end, "Marks" },
  ["<leader>sM"] = { function() Snacks.picker.man() end, "Man Pages" },
  ["<leader>sp"] = { function() Snacks.picker.lazy() end, "Search for Plugin Spec" },
  ["<leader>sq"] = { function() Snacks.picker.qflist() end, "Quickfix List" },
  ["<leader>sR"] = { function() Snacks.picker.resume() end, "Resume" },
  ["<leader>su"] = { function() Snacks.picker.undo() end, "Undo History" },
  ["<leader>uC"] = { function() Snacks.picker.colorschemes() end, "Colorschemes" },
  ["<leader>ss"] = { function() Snacks.picker.lsp_symbols() end, "LSP Symbols" },
  ["<leader>sS"] = { function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols" },
  ["<leader>z"] = { function() Snacks.zen() end, "Toggle Zen Mode" },
  ["<leader>Z"] = { function() Snacks.zen.zoom() end, "Toggle Zoom" },
  ["<leader>."] = { function() Snacks.scratch() end, "Toggle Scratch Buffer" },
  ["<leader>bd"] = { function() Snacks.bufdelete() end, "Delete Buffer" },
  ["<leader>cR"] = { function() Snacks.rename.rename_file() end, "Rename File" },
  ["<leader>gB"] = { function() Snacks.gitbrowse() end, "Git Browse", { mode = { "n", "v" } } },
  ["<leader>gg"] = { function() Snacks.lazygit() end, "Lazygit" },
  ["<leader>un"] = { function() Snacks.notifier.hide() end, "Dismiss All Notifications" },
  ["<C-/>"] = { function() Snacks.terminal() end, "Toggle Terminal", { mode = { "n", "t" } } },
  ["<C-_>"] = { function() Snacks.terminal() end, "which_key_ignore", { mode = { "n", "t" } } },
  ["]]"] = { function() Snacks.words.jump(vim.v.count1) end, "Next Reference", { mode = { "n", "t" } } },
  ["[["] = { function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference" },
}

for lhs, spec in pairs(snacks_maps) do
  local rhs, desc, extra = spec[1], spec[2], spec[3] or {}
  local opts = vim.tbl_extend("force", { desc = desc }, extra)
  local mode = opts.mode or "n"
  opts.mode = nil
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>y", "<cmd>silent !bash -n % | pbcopy<CR>")
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true })
end, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, wrap = true })
end, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]D", function()
  vim.diagnostic.goto_next({})
end, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "[D", function()
  vim.diagnostic.goto_prev({})
end, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>k", "<cmd>cp<CR>", { desc = "Quickfix previous" })
vim.keymap.set("n", "<leader>j", "<cmd>cn<CR>", { desc = "Quickfix next" })
vim.keymap.set("n", "<C-c>", "<cmd>cclose<CR>", { desc = "Quickfix close" })
vim.keymap.set("n", ",j", "<cmd>move .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", ",k", "<cmd>move .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<leader><C-h>", "<cmd>nohl<CR>", { desc = "No highlight" })
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Buffer previous" })
vim.keymap.set("n", "<leader>bo", "<cmd>%bdelete|edit #|normal`\"<CR>", { desc = "Buffer only" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Tab only" })
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Tab only" })
vim.keymap.set("n", "<leader><tab>c", "<cmd>tabc<CR>", { desc = "Tab close" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabc<CR>", { desc = "Tab delete" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabe<CR>", { desc = "Tab open current file" })

vim.keymap.set("n", "<leader>ml", function()
  vim.cmd.colorscheme("catppuccin-latte")
end, { desc = "Theme light" })

vim.keymap.set("n", "<leader>md", function()
  vim.o.background = "dark"
  vim.cmd.colorscheme("gruvbox-material")
end, { desc = "Theme dark" })

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>clr", "<cmd>LspRestart<CR>", { desc = "LSP restart" })
vim.keymap.set("n", "<leader><leader>j", _G.GetJsonPath, { desc = "Get JSON Path" })
vim.keymap.set("n", "<leader>ww", function()
  require("telescope.builtin").find_files({
    prompt_title = "Wiki Files",
    cwd = get_wiki_root(),
    follow = true,
    hidden = true,
  })
end, { desc = "[W]iki files" })
vim.keymap.set("n", "<leader>wg", function()
  require("telescope.builtin").live_grep({
    prompt_title = "Wiki Grep",
    search_dirs = { get_wiki_root() },
  })
end, { desc = "[W]iki grep" })
vim.keymap.set("n", "<leader>wr", function()
  require("telescope.builtin").grep_string({
    prompt_title = "Wiki word",
    search = vim.fn.expand("<cword>"),
    search_dirs = { get_wiki_root() },
  })
end, { desc = "[W]iki grep word" })
vim.keymap.set("n", "<leader>wi", open_wiki_index, { desc = "[W]iki index" })

vim.keymap.set("x", "aw", function()
  require("align").align_to_string({
    preview = true,
    regex = false,
  })
end, { noremap = true, silent = true, desc = "Align by string" })

vim.keymap.set("n", "<leader>fm", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "[F]ile [M]ini-explorer" })

vim.keymap.set("n", "<leader>S", function()
  require("snipe").open_buffer_menu()
end, { desc = "Open Snipe buffer menu" })

vim.keymap.set("n", "<leader>cb", "<cmd>NavicNotify<CR>", { desc = "[C]ode [B]readcrumbs" })
vim.keymap.set("n", "<leader>uu", "<cmd>UndotreeToggle<CR>", { desc = "Undotree (toggle)" })
vim.keymap.set("n", "<leader>uf", "<cmd>UndotreeFocus<CR>", { desc = "Undotree (focus)" })

local diffview_open = false
vim.keymap.set("n", "<leader>gdf", function()
  if diffview_open then
    require("diffview").close()
    diffview_open = false
  else
    vim.cmd("DiffviewFileHistory %")
    diffview_open = true
  end
end, { desc = "File History" })

vim.keymap.set("n", "<leader>gdt", function()
  if diffview_open then
    require("diffview").close()
    diffview_open = false
  else
    require("diffview").open({})
    diffview_open = true
  end
end, { desc = "Toggle Diff View" })

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

vim.keymap.set("n", "H", "<cmd>bprev<CR>", { desc = "[B]uffer [P]revious" })
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "[B]uffer [N]ext" })

vim.keymap.set("n", "<leader><leader>tb", function()
  require("typebreak").start(true)
end, { desc = "Typebreak" })

vim.keymap.set("n", "<leader>csr", "<cmd>SupermavenRestart<CR>", { desc = "Restart SuperMaven" })
vim.keymap.set("n", "<leader>cst", function()
  local api = require("supermaven-nvim.api")
  api.toggle()
  vim.notify("SuperMaven " .. (api.is_running() and "on" or "off"), vim.log.levels.INFO)
end, { desc = "Toggle SuperMaven" })

vim.keymap.set("n", "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<C-s>", function() require("flash").toggle() end, { desc = "Toggle Flash Search" })

vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Explorer" })
vim.keymap.set("n", "<leader>E", function()
  Snacks.explorer()
end, { desc = "Explorer focus" })
vim.keymap.set("n", "<leader>fB", function()
  Snacks.picker.buffers()
end, { desc = "[F]ind [B]uffers" })
