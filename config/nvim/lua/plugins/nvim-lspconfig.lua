return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      vtsls = {
        settings = {
          typescript = {
            format = {
              indentStyle = 1,
              insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
            },
          },
        },
      },
      rubocop = {
        enabled = false,
      },
      ruby_lsp = {
        init_options = {
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
        },
      },
    },
  },
}
