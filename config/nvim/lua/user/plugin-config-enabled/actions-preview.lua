local function config()
  require("actions-preview").setup()

  vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
end

return {
  "aznhe21/actions-preview.nvim",
  config = config
}
