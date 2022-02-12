local fn = vim.fn

local util = {}

---Check if a cmd is executable
-----@param e string
-----@return boolean
function util.executable(e) return fn.executable(e) > 0 end

return util
