local mappings = require("user.mappings")

mappings.nnoremap("<leader>a", function() require("harpoon.mark").add_file() end)
mappings.nnoremap("<C-e>", function() require("harpoon.ui").toggle_quick_menu() end)
mappings.nnoremap("<c-h>", function() require("harpoon.ui").nav_file(1) end)
mappings.nnoremap("<c-t>", function() require("harpoon.ui").nav_file(2) end)
mappings.nnoremap("<c-n>", function() require("harpoon.ui").nav_file(3) end)
mappings.nnoremap("<c-s>", function() require("harpoon.ui").nav_file(4) end)
