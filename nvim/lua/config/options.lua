-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Neovide options
if vim.g.neovide then
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.opt.termguicolors = true
end

vim.opt.relativenumber = false

vim.g.lazyvim_eslint_auto_format = false

vim.g.lazyvim_blink_main = true
