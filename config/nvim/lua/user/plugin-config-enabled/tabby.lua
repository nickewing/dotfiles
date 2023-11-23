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
    -- current_tab = 'TabLineSel',
    current_tab = { fg = '#F8FBF6', bg = '#896a98', style = 'italic' },
    tab = 'TabLine',
    tab_modified = 'TabLine',
    win = 'TabLine',
    tail = 'TabLine',
  }

  require('tabby.tabline').set(function(line)
    return {
      -- {
        -- { '   ', hl = theme.head },
        -- line.sep('', theme.head, theme.fill),
      -- },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab

        return {
          line.sep('', hl, theme.fill),
          tab.close_btn(''), -- show a close button
          tab_modified(tab.id) and "" or "",
          -- tab.number() .. ":",
          tab.name(),
          line.sep('', hl, theme.fill),
          hl = hl,
          margin = ' ',
        }
      end),
      -- line.spacer(),
      -- shows list of windows in tab
      -- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
      --   local hl = win.is_current() and theme.win or theme.fill
      --   local buffer = win.buf()
      --   local buf_name = win.buf_name()
      --
      --   -- local modified = vim.bo[buffer.id].modified and "" or ""
      --
      --   if string.find(buf_name, "NvimTree") then
      --     return {}
      --   else
      --     return {
      --       line.sep(' ', theme.win, theme.fill),
      --       -- modified,
      --       -- win.file_icon(),
      --       lsp_diagnostic_icon(buffer.id),
      --       ' ',
      --       buf_name,
      --       line.sep(' ', theme.win, theme.fill),
      --       hl = hl,
      --       margin = '',
      --     }
      --   end
      -- end),
      -- {
        -- line.sep('', theme.tail, theme.fill),
        -- { '  ', hl = theme.tail },
      -- },
      hl = theme.fill,
    }
  end,
  {
      tab_name = {
        name_fallback = function(tabid)
          local api = require('tabby.module.api')
          local buf_name = require('tabby.feature.buf_name')

          local wins = api.get_tab_wins(tabid)
          local cur_win = api.get_tab_current_win(tabid)
          local name = ''

          if api.is_float_win(cur_win) then
            name = '[Floating]'
          else
            name = truncate(buf_name.get(cur_win), max_tab_name_length)
          end

          if #wins > 1 then
            name = string.format('%s (%d)', name, #wins)
          end

          return name
        end
      },

  })
end

return {
  "nanozuki/tabby.nvim",
  lazy = false,
  config = config,
  -- priority = 900
}
