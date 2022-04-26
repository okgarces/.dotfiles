local M = { 
  clear_registry_function = function()
    regs = string.gmatch('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789*+/-"', ".")
    for r in regs do
      vim.fn["setreg"](r, {})
    end
  end
}
return M
