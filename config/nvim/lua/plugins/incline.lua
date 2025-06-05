return {
  "b0o/incline.nvim",
  event = "VeryLazy",
  opts = {
    window = {
      padding = 0,
      margin = { horizontal = 0, vertical = 0 },
    },
    render = function(props)
      local devicons = require("nvim-web-devicons")
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      if filename == "" then
        filename = "[No Name]"
      end
      local ft_icon, ft_color = devicons.get_icon_color(filename)
      local modified = vim.bo[props.buf].modified
      return {
        ft_icon and { " ", ft_icon, " ", guifg = ft_color } or " ",
        { filename, guifg = modified and "#FF8888" or "", gui = modified and "bold,italic" or "bold" },
        " ",
      }
    end,
  },
}
