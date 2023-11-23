local function config()
  vim.cmd("cnoreabbrev Gbl ToggleBlame")
end

return {
  "FabijanZulj/blame.nvim",
  config = config
}
