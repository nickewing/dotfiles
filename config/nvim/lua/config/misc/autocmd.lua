-- Disable formatexpr for markdown files
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype
    if ft == "markdown" or ft == "text" then
      -- Disable LSP-based gq formatting
      vim.bo[bufnr].formatexpr = ""
    end
  end,
})

-- Don't hide characters like code block backticks in Markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Disable window titles on terminals & Claude Code
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.wo.winbar = ""
  end,
})
