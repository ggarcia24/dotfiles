-- Apparently is better to use SH :(
vim.opt.shell = "/bin/sh"

require("plugins")

--Make line numbers default
vim.wo.number = true
vim.o.relativenumber = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme nightfly]])

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

--Set highlight on search
vim.o.hlsearch = false

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

--Remap , as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Whitespace/Indenting
vim.g.smartindent = true
vim.g.copyindent = true
vim.g.shiftwidth = 2
vim.g.softtabstop = 2
vim.g.expandtab = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

--
-- PLUGIN CONFIGURATION
--

-- which-key
vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
})

require("bad_practices").setup()

require("bufferline").setup({
  options = {
    numbers = "buffer_id",
    indicator = {
      stile = "underline",
    },
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
    always_show_bufferline = true,
    show_close_icon = true,
  },
})

require("nvim-autopairs").setup({})

-- MASON
require("mason").setup()
require("mason-lspconfig").setup()

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- Stolen from LunarVIM
---filter passed to vim.lsp.buf.format
---always selects null-ls if it's available and caches the value per buffer
---@param client table client attached to a buffer
---@return boolean if client matches
function format_filter(client)
  local filetype = vim.bo.filetype
  local n = require("null-ls")
  local s = require("null-ls.sources")
  local method = n.methods.FORMATTING
  local available_formatters = s.get_available(filetype, method)

  if #available_formatters > 0 then
    return client.name == "null-ls"
  elseif client.supports_method("textDocument/formatting") then
    return true
  else
    return false
  end
end

-- Add nvim-lspconfig plugin
local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
  local attach_opts = { silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, attach_opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, attach_opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, attach_opts)
  vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, attach_opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, attach_opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, attach_opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, attach_opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, attach_opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, attach_opts)

  -- Autoformat on Save
  -- Stolen from: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = format_filter,
        })
      end,
    })
  end
end

-- Enable the following language servers
local servers = { "rust_analyzer", "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- null-ls setup
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- Formatting
    -- LUA
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),
    -- Python
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length=120" },
    }),
    null_ls.builtins.formatting.isort,
    -- Django
    null_ls.builtins.formatting.djlint,
    null_ls.builtins.formatting.cbfmt,
    -- Javascript/Typescript
    null_ls.builtins.formatting.prettier,
    -- Markdown
    null_ls.builtins.formatting.markdownlint,
    -- Diagnostics
    null_ls.builtins.diagnostics.commitlint,
    -- Javascript/Typescript
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.tsc,
    -- Others
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.diagnostics.cfn_lint,
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.editorconfig_checker,
    -- OpenAPI
    -- null_ls.builtins.diagnostics.vacuum,
    -- null_ls.builtins.diagnostics.spectral,
    -- Python
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.vulture,
    -- Django
    null_ls.builtins.diagnostics.djlint,
    -- PHP
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.diagnostics.phpmd,
    null_ls.builtins.diagnostics.phpstan,
    null_ls.builtins.diagnostics.psalm,
    -- Code Action
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,
    -- Completition
    null_ls.builtins.completion.spell,
  },
  on_attach = on_attach,
})

-- Enable the following language servers
local servers = { "rust_analyzer", "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = fmtAugroup,
  callback = function(ev)
    vim.lsp.buf.format({})
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- nvim-cmp supports additional completion capabilities
-- completeopt is used to manage code suggestions
-- menuone: show popup even when there is only one suggestion
-- noinsert: Only insert text when selection is confirmed
-- noselect: force us to select one from the suggestions
vim.opt.completeopt = { "menuone", "noselect", "noinsert", "preview" }
-- shortmess is used to avoid excessive messages
vim.opt.shortmess = vim.opt.shortmess + { c = true }

local cmp = require("cmp")
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    -- Shift+TAB to go to the Previous Suggested item
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    -- Tab to go to the next suggestion
    ["<Tab>"] = cmp.mapping.select_next_item(),
    -- CTRL+SHIFT+f to scroll backwards in description
    ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
    -- CTRL+F to scroll forwards in the description
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- CTRL+SPACE to bring up completion at current Cursor location
    ["<C-Space>"] = cmp.mapping.complete(),
    -- CTRL+e to exit suggestion and close it
    ["<C-e>"] = cmp.mapping.abort(),
    --
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --
    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  -- sources are the installed sources that can be used for code suggestions
  sources = {
    { name = "path" },
    { name = "nvim_lsp", keyword_length = 3 },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua", keyword_length = 2 },
    { name = "buffer", keyword_length = 2 },
    { name = "vsnip", keyword_length = 2 },
  },
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- NvimTree
require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  view = {
    width = 40,
  },
})

local function open_nvim_tree(data)
  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  if not real_file and not no_name then
    return
  end

  -- open the tree, find the file but don't focus it
  require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
-- Close NVim when NvimTree is the last buffer open
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if
      layout[1] == "leaf"
      and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
      and layout[3] == nil
    then
      vim.cmd("confirm quit")
    end
  end,
})

--
require("neogen").setup({
  enabled = true, --if you want to disable Neogen
  input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
  -- jump_map = "<C-e>"       -- (DROPPED SUPPORT, see [here](#cycle-between-annotations) !) The keymap in order to jump in the annotation fields (in insert mode)
})

--
require("lualine").setup({
  options = {
    icons_enabled = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_c = { "branch", "diff", "diagnostics" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

-- Gitsigns
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "-" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  numhl = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    delay = 250,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    -- Actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hR", gs.reset_buffer)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end)
    map("n", "<leader>tb", gs.toggle_current_line_blame)
    map("n", "<leader>hd", gs.diffthis)
    map("n", "<leader>hD", function()
      gs.diffthis("~")
    end)
    map("n", "<leader>td", gs.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})

require("Comment").setup()

require("leap").add_default_mappings()

require("todo-comments").setup()
