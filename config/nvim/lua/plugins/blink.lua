local function config()
  require("blink.cmp").setup({
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

    term = {
      enabled = true,
      keymap = {
        preset = "none",
        -- manual trigger key, in case auto_show is false
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-p>"] = { "show", "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "show", "select_next", "fallback_to_mappings" },
      }, -- Inherits from top level `keymap` config when not set
      sources = {
        "path",
        "ripgrep",
      },
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
        },
        -- Inherits from top level config options when not set
        list = {
          selection = {
            -- When `true`, will automatically select the first item in the completion list
            preselect = nil,
            -- When `true`, inserts the completion item automatically when selecting it
            auto_insert = nil,
          },
        },
        -- Whether to automatically show the window when new completion items are available
        menu = { auto_show = nil },
        -- Displays a preview of the selected item on the current line
        ghost_text = { enabled = nil },
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
  })
end

return {
  "saghen/blink.cmp",
  dependencies = {
    "mikavilpas/blink-ripgrep.nvim",
  },
  event = "VeryLazy",
  config = config,
}
