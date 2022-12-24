require("noice").setup({
    cmdline = {
        format = {
            cmdline = { pattern = "^:", icon = ": ", lang = "vim" },
            filter = { pattern = "^:%s*!", icon = " ", lang = "bash" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = " " },
            lua = { pattern = "^:%s*lua%s+", icon = " ", lang = "lua" },
        },
    },
    messages = {
        enabled = false,
    },
    popupmenu = {
        backend = "cmp",
    },
})
