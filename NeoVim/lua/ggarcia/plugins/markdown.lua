return {
  "iamcco/markdown-preview.nvim",
  'AckslD/nvim-FeMaco.lua',
  dependencies = {
    'dhruvasagar/vim-table-mode'
  },
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]() 
  end,
  config = function ()
    require("femaco").setup()
  end,
}
