local max_tab_name_length = 15

local function lsp_diagnostic_icon(buf)
  local diagnostics = vim.diagnostic.get(buf)
  local count = {0, 0, 0, 0}

  for _, diagnostic in ipairs(diagnostics) do
    count[diagnostic.severity] = count[diagnostic.severity] + 1
  end
  if count[1] > 0 then
    return vim.bo[buf].modified and "" or ""
  elseif count[2] > 0 then
    return vim.bo[buf].modified and "" or ""
  end
  return vim.bo[buf].modified and "" or ""
end

local function tab_modified(tab)
  local wins = require("tabby.module.api").get_tab_wins(tab)
  for _, x in pairs(wins) do
    if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
      return true
    end
  end
  return false
end

local function truncate(s, n)
  if string.len(s) > n then
    return s:sub(1, n - 1) .. "…"
  else
    return s
  end
end

local function config()
  local theme = {
    fill = 'TabLineFill',
    head = 'TabLine',
    current_tab = 'TabLineSel',
    -- current_tab = { fg = '#F8FBF6', bg = '#896a98', style = 'italic' },
    -- current_tab_modified = { fg = '#FF8888', bg = '#896a98', style = 'italic' },
    tab_modified = { fg = '#FF8888' },
    tab = 'TabLine',
    -- tab_modified = 'TabLine',
    -- win = 'TabLine',
    tail = 'TabLine',
  }

  require('tabby').setup({
    line = function(line)
      return {
        {
          { '  ', hl = theme.head },
          line.sep('', theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab

          local is_modified = tab_modified(tab.id);

          -- if tab.is_current() and is_modified then
          --   hl = theme.current_tab_modified;
          -- elseif tab.is_current() then
          --   hl = theme.current_tab;
          -- elseif is_modified then
          --   hl = theme.tab_modified;
          -- else
          --   hl = theme.tab;
          -- end

          -- print(vim.inspect(hl))

          return {
            line.sep('', hl, theme.fill),
            is_modified and "" or "",
            tab.number(),
            tab.name(),
            tab.close_btn(''),
            line.sep('', hl, theme.fill),
            hl = hl,
            margin = ' ',
          }
        end),
        {
          line.sep('', theme.tail, theme.fill),
          { '  ', hl = theme.tail },
        },
        hl = theme.fill,
      }
    end,
    -- option = {}, -- setup modules' option,
  })
end

return {
  "nanozuki/tabby.nvim",
  lazy = false,
  config = config,
  -- priority = 900
}
