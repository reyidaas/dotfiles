vim.cmd.colorscheme("oxocarbon")

-- Set NormalBorder (or FloatBorder) background to none
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#525252" })
vim.api.nvim_set_hl(0, "NormalBorder", { fg = "#525252" })

-- Set oxocarbon-matching colors after telescope setup
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#525252" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#78a9ff" }) -- Blue accent for prompt
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#525252" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#525252" })

-- Hide all semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
