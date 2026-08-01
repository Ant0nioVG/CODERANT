vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#000000", ctermbg = 0 })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000", ctermbg = 0 })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000", ctermbg = 0 })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "#000000", ctermbg = 0 })
  end,
})
