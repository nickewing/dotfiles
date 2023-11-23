local function config()
  require("onedark").setup({
    style = "warm",
    toggle_style_key = "<leader>ct",
    toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' },

    highlights = {
      MatchParen = { fg = "none", bg = "none", fmt = "underline" },
    }
  })
end

return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = config
}
