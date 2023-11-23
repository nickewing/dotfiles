local function config()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "tsserver",
      "html",
      "cssls",
      -- "solargraph", __ installed with project Gemfile
      -- "ruby_ls", -- installed with project Gemfile
      "lua_ls",
      "eslint",
    },

    automatic_installation = true
  })
end

return {
   "williamboman/mason.nvim",
  lazy = false,
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", lazy = false }
  },
  config = config
}
