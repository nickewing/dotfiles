local function config()
  require("onedark").setup({
    style = "warm",
    toggle_style_key = "<leader>ct",
    toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' },

    highlights = {
      -- MatchParen = { fg = "none", bg = "none", fmt = "underline" },
      TabLineSel = { fg = '#F8FBF6', bg = '#896a98', style = 'italic' },
    }
  })
end

return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = config
}
