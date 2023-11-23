local function config()
  require("lualine").setup({
    options = {
      disabled_filetypes = {
        -- statusline = { 'qf', 'NvimTree', 'Trouble', 'toggleterm' }
        statusline = { 'qf', 'NvimTree', 'Trouble' }
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {
        'branch',
        'diff',
        'diagnostics',
        {
          'filename',
          path = 4
        }
      },
      lualine_c = {
        {
          require('lsp-progress').progress,
          color = { fg = '#ffaa88' },
        }
      },
      lualine_x = {'searchcount', 'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
  })

  vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = "lualine_augroup",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
  })

  require('lsp-progress').setup({})
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "linrongbin16/lsp-progress.nvim",
  },
  config = config
}
