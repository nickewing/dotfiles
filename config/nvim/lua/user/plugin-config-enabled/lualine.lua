
local function config()
  local custom_fname = require('lualine.components.filename'):extend()
  local highlight = require'lualine.highlight'
  local default_status_colors = { modified = '#900000' }

  function custom_fname:init(options)
    custom_fname.super.init(self, options)
    self.status_colors = {
      modified = highlight.create_component_highlight_group(
        {bg = default_status_colors.modified}, 'filename_status_modified', self.options),
    }
    if self.options.color == nil then self.options.color = '' end
  end

  function custom_fname:update_status()
    local data = custom_fname.super.update_status(self)

    if vim.bo.modified then
      data = highlight.component_format_highlight(self.status_colors.modified) .. data
    end

    return data
  end

  require("lualine").setup({
    options = {
      disabled_filetypes = {
        statusline = { 'qf', 'NvimTree', 'Trouble' }
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {
        -- 'branch',
        {
          custom_fname,
          path = 4
        },
        'diff',
        'diagnostics',
        -- {
        --   'filename',
        --   path = 4
        -- }
      },
      lualine_c = {
        {
          require('lsp-progress').progress,
          color = { fg = '#ffaa88' },
        }
      },
      lualine_x = {
        -- 'searchcount',
        'encoding',
        'fileformat',
        'filetype'
      },
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
