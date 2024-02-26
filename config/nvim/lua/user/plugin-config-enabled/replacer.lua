local function config()
  vim.api.nvim_create_autocmd('FileType', {
    desc = 'Add replacer bindings to quickfix',
    pattern = 'qf',
    group = vim.api.nvim_create_augroup('qf_replacer', { clear = true }),

    callback = function()
      vim.keymap.set("n", "<leader>R", function()
        require('replacer').run()
      end, { desc = "Run replacer.nvim" })
    end,
  })
end

return {
  'gabrielpoca/replacer.nvim',
  opts = {
    rename_files = false,
  },
  config = config
}
