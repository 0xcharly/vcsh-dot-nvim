local M = {}
_G.Status = M

function M.fold()
	local line = vim.v.lnum
	if vim.fn.foldlevel(line) <= vim.fn.foldlevel(line - 1) then
		return "  "
	end

	return vim.fn.foldclosed(line) > 0 and " " or " "
end

function M.status_column()
	local components = {
    -- [[%#FoldColumn#%{v:lua.Status.fold()}]],
    [[ %s]],
		[[%=]],
		[[%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''}]],
    [[ ]],
	}
	return table.concat(components, "")
end

vim.opt.statuscolumn = M.status_column()

return M
