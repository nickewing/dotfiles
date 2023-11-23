return {
  'gabrielpoca/replacer.nvim',
  opts = {rename_files = false},
  keys = {
    {
      '<leader>r',
      function() require('replacer').run() end,
      desc = "Run replacer.nvim"
    }
  }
}
