require("nvim-treesitter.configs").setup({
    context_commentstring = { enable = true },
    ensure_installed = {
        "beancount",
        "c",
        "cpp",
        "dart",
        "devicetree",
        "fish",
        "help",
        "java",
        "javascript",
        "kotlin",
        "lua",
        "rst",
        "rust",
        "typescript",
    },
    highlight = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            -- mappings for incremental selection (visual mappings)
            init_selection = "<leader>v", -- maps in normal mode to init the node/scope selection
            node_incremental = "<leader>v", -- increment to the upper named parent
            node_decremental = "<leader>V", -- decrement to the previous node
            scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
        },
    },
    indent = { enable = true },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["aC"] = "@conditional.outer",
                ["iC"] = "@conditional.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
    textsubjects = { enable = true, keymaps = { ["<CR>"] = "textsubjects-smart" } },
    autopairs = { enable = true },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
    },
})
