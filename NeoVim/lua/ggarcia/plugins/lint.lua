return {
    "mfussenegger/nvim-lint",
    config = function ()
      local lint = require("lint")
      lint.linters_by_ft = {
        text = { "", },
        markdown = { "markdownlint", },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          callback = function()
            lint.try_lint()
          end,
        })
    end
}
