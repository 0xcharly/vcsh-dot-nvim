local mappings = require("user.mappings")

-- UI.
mappings.nnoremap("<leader>z", function() require("zen-mode").toggle({}) end)
mappings.nnoremap("<leader>Z", function()
    require("zen-mode").toggle({
        window = {
            options = {
                number = false, -- disable number column
                relativenumber = false, -- disable relative numbers
            },
        },
    })
end)
