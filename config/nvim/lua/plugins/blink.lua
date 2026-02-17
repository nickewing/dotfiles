return {
  "saghen/blink.cmp",
  dependencies = {
    "mikavilpas/blink-ripgrep.nvim",
  },
  event = "VeryLazy",
  opts = {
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        -- disabled in favor of ripgrep
        -- "buffer",
        "ripgrep",
      },
      providers = {
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
        },

        -- Show Buffer completions with LSP
        -- See: https://cmp.saghen.dev/configuration/sources.html#show-buffer-completions-with-lsp
        -- defaults to `{ 'buffer' }`
        lsp = { fallbacks = {} },
      },
    },

    keymap = {
      preset = "none",

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "show", "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "show", "select_next", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
  },
}
