local function config()
  require('pqf').setup({
    signs = { error = "", warning = "", hint = "󰠠", info = "" },

    -- By default, only the first line of a multi line message will be shown. --
    -- When this is true, multiple lines will be shown for an entry, separated by a
    -- space
    show_multiple_lines = false,

    -- How long filenames in the quickfix are allowed to be. 0 means no limit.
    -- Filenames above this limit will be truncated from the beginning with [...]
    max_filename_length = 0,
  })
end

return {
  "yorickpeterse/nvim-pqf",
  config = config
}
