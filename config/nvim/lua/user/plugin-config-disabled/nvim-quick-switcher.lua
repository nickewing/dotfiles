local function config()
  local keymap = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  -- Angular
  keymap("n", "<leader>oy", "<cmd>:lua require('nvim-quick-switcher').find('.service.ts')<CR>", opts)
  keymap("n", "<leader>ou", "<cmd>:lua require('nvim-quick-switcher').find('.component.ts')<CR>", opts)
  keymap("n", "<leader>oo", "<cmd>:lua require('nvim-quick-switcher').find('.component.html')<CR>", opts)
  keymap("n", "<leader>op", "<cmd>:lua require('nvim-quick-switcher').find('.module.ts')<CR>", opts)
end

return {
  "Everduin94/nvim-quick-switcher",
  config = config
}
