return {
  "snacks.nvim",
  keys = {
    { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
  },
  opts = {
    indent = { enabled = false },
    picker = {
      layout = "ivy",
      sources = {
        files = {
          hidden = true,
          ignored = false,
        },
        explorer = {
          hidden = true,
          ignored = true,
          auto_close = true,
          win = {
            list = {
              keys = {
                ["<C-T>"] = { "tab", mode = { "n", "i" } },
                ["<C-S-T>"] = { "terminal", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
    dashboard = {
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
    },
  },
}
