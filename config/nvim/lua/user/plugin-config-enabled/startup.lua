local function config()
  require("startup").setup()
end

return {
  "startup-nvim/startup.nvim",
  config = config
}
