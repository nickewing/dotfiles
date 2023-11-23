local function config()
  local telescope = require("telescope");
  local builtin = require("telescope.builtin")
  local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
  local keymap = vim.keymap

  telescope.setup({
    defaults = {
      layout_strategy = "bottom_pane",
      layout_config = {
        bottom_pane = {
          height = 40,
          preview_cutoff = 40,
          prompt_position = "bottom"
        },
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- ... also accepts theme settings, for example:
        -- theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      }
    }
  })

  telescope.load_extension("fzf")
  telescope.load_extension("live_grep_args")

  keymap.set("n", "<leader>f", builtin.find_files, { desc = "Telescope files"})
  keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Telescope live grep" })
  keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
  keymap.set("n", "<leader>*", live_grep_args_shortcuts.grep_word_under_cursor, { desc = "Telescope word under cursor" })
  keymap.set("v", "<leader>*", live_grep_args_shortcuts.grep_visual_selection, { desc = "Telescope word under cursor" })

  vim.api.nvim_create_user_command("Ack", function(args)
    local default_text = args.fargs[1]
    -- TODO: support multiple directories later, maybe
    local search_dirs = {args.fargs[2]}

    telescope.extensions.live_grep_args.live_grep_args({
      default_text = default_text,
      search_dirs = search_dirs
    })
  end, { desc = "Grep in Telescope", nargs = "*" })

  -- require("telescope").extensions.live_grep_args.live_grep_args()
end

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      event = "VeryLazy",
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      event = "VeryLazy",
      version = "^1.0.0",
    }
  },
  config = config,
  event = "VeryLazy",
}
