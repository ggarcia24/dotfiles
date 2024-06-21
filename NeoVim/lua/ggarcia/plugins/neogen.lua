return { 
    "danymat/neogen", 
    -- Uncomment next line if you want to follow only stable versions
    version = "*" ,
    config = function ()
        require("neogen").setup({
        enabled = true, --if you want to disable Neogen
        input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
        -- jump_map = "<C-e>"       -- (DROPPED SUPPORT, see [here](#cycle-between-annotations) !) The keymap in order to jump in the annotation fields (in insert mode)
        })
    end
}
