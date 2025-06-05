local function config()
  require("nvim-bqf").setup({
    filter = {
      fzf = {
        extra_opts = {'--bind', 'ctrl-o:toggle-all', '--delimiter', '│'}
      }
    }
  })
end

return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  config = config,
}
