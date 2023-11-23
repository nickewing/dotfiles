local function config()
  local barbar = require("barbar")

  barbar.setup({
    sidebar_filetypes = {
      -- Use the default values: {event = 'BufWinLeave', text = nil}
      NvimTree = true,
      -- Or, specify the text used for the offset:
      undotree = {text = 'undotree'},
      -- Or, specify the event which the sidebar executes when leaving:
      ['neo-tree'] = {event = 'BufWipeout'},
      -- Or, specify both
      Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
    },
  });

  local map = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  -- Move to previous/next
  map('n', '<S-D-{>', '<Cmd>BufferPrevious<CR>', opts)
  map('n', '<S-D-}>', '<Cmd>BufferNext<CR>', opts)
  -- Re-order to previous/next
  -- map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
  -- map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
  -- Goto buffer in position...
  map('n', '<D-1>', '<Cmd>BufferGoto 1<CR>', opts)
  map('n', '<D-2>', '<Cmd>BufferGoto 2<CR>', opts)
  map('n', '<D-3>', '<Cmd>BufferGoto 3<CR>', opts)
  map('n', '<D-4>', '<Cmd>BufferGoto 4<CR>', opts)
  map('n', '<D-5>', '<Cmd>BufferGoto 5<CR>', opts)
  map('n', '<D-6>', '<Cmd>BufferGoto 6<CR>', opts)
  map('n', '<D-7>', '<Cmd>BufferGoto 7<CR>', opts)
  map('n', '<D-8>', '<Cmd>BufferGoto 8<CR>', opts)
  map('n', '<D-9>', '<Cmd>BufferGoto 9<CR>', opts)
  map('n', '<D-0>', '<Cmd>BufferLast<CR>', opts)
  -- Pin/unpin buffer
  -- map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
  -- Close buffer
  map('n', '<D-w>', '<Cmd>BufferClose<CR>', opts)
  -- Wipeout buffer
  --                 :BufferWipeout
  -- Close commands
  --                 :BufferCloseAllButCurrent
  --                 :BufferCloseAllButPinned
  --                 :BufferCloseAllButCurrentOrPinned
  --                 :BufferCloseBuffersLeft
  --                 :BufferCloseBuffersRight
  -- Magic buffer-picking mode
  map('n', '<D-b>', '<Cmd>BufferPick<CR>', opts)
  -- Sort automatically by...
  -- map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
  -- map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
  -- map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
  -- map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
end

return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  -- opts = {
  --   -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
  --   -- animation = true,
  --   -- insert_at_start = true,
  --   -- …etc.
  --
  --   sidebar_filetypes = {
  --     -- Use the default values: {event = 'BufWinLeave', text = nil}
  --     NvimTree = true,
  --     -- Or, specify the text used for the offset:
  --     undotree = {text = 'undotree'},
  --     -- Or, specify the event which the sidebar executes when leaving:
  --     ['neo-tree'] = {event = 'BufWipeout'},
  --     -- Or, specify both
  --     Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
  --   },
  -- },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
  -- config = config
  -- keys = {
  --   { '<S-D-{>', '<Cmd>BufferPrevious<CR>', desc = "Previous Tab" },
  --   { '<S-D-}>', '<Cmd>BufferNext<CR>', desc = "Next Tab" }
  -- },
  config = config,
}
