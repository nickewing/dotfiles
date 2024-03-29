local function config()
  local toggleterm = require("toggleterm")

  toggleterm.setup()

  vim.keymap.set("n", "<leader>tt", toggleterm.toggle)
end

return {
  "akinsho/toggleterm.nvim",
  config = config
}

