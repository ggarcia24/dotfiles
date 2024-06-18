vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
-- Apparently is better to use SH :(
opt.shell = "/bin/sh"

-- Keep signcolumn on by default
opt.signcolumn = "yes"
--Make line numbers default
opt.number = true
opt.relativenumber = true

opt.background = "dark" -- or "light" for light mode

-- set termguicolors to enable highlight groups
opt.termguicolors = true

--Enable mouse mode
opt.mouse = "a"

-- Decrease update time
opt.updatetime = 250

-- Whitespace/Indenting
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
-- opt.copyindent = true

opt.backspace = "indent,eol,start"
--Enable break indent
opt.breakindent = true
opt.wrap = false

opt.clipboard=unnamed -- copy to the system clipboard
opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true


--Set highlight on search
opt.hlsearch = false
--Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- -- Highlight on yank
-- local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
--   group = highlight_group,
--   pattern = "*",
-- })

-- require("Comment").setup()
