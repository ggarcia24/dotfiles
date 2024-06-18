return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    ft = { 'python', 'css', 'php', 'typescript', 'javascript', 'lua', },
    opts = {
      indent = { char = "┊" },
    },
  }
