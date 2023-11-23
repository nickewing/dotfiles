return {
  "itchyny/lightline.vim",
  init = function()
    vim.g.lightline = {
      enable = { statusline = 1, tabline = 0 },
      colorscheme = 'one',
    }
  end,
}
