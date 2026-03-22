local CLAUDE_WIN_WIDTH = 120

local function set_claude_win_size()
  vim.api.nvim_win_set_width(0, CLAUDE_WIN_WIDTH)
  vim.wo.winfixwidth = true
end

local function claude_open_or_focus()
  local claude_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(buf)
    if name:match("claude") or vim.bo[buf].filetype == "claudecode" then
      claude_buf = buf
      break
    end
  end

  if not claude_buf then
    vim.cmd("ClaudeCode")
    set_claude_win_size()
    return
  end

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_buf(win) == claude_buf then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
      if vim.api.nvim_win_get_buf(win) == claude_buf then
        vim.api.nvim_win_close(win, false)
      end
    end
  end

  vim.cmd("botright vsplit")
  vim.api.nvim_set_current_buf(claude_buf)
  set_claude_win_size()
  vim.cmd("startinsert")
end

return {
  "coder/claudecode.nvim",
  opts = {},
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    { "<leader>aa", claude_open_or_focus, desc = "Pull Claude to current tab" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil" },
    },
    -- Diff management
    { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
