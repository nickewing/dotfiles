local function config()
  local default = "onedark"
  local theme = require('last-color').recall() or default
  vim.cmd(('colorscheme %s'):format(theme))
end

return {
  "raddari/last-color.nvim",
  config = config
}
