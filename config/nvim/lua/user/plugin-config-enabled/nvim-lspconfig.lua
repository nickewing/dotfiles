local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function default_on_attach(client, bufnr)
  local keymap = vim.keymap

  local opts = { noremap = true, silent = true }

  opts.buffer = bufnr

  opts.desc = "Show LSP references"
  keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

  opts.desc = "Go to declaration"
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

  opts.desc = "Show LSP definitions"
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

  opts.desc = "Show LSP implementations"
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

  opts.desc = "Show LSP type definitions"
  keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

  opts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

  opts.desc = "Smart rename"
  keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts) -- smart rename

  opts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

  opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

  opts.desc = "Go to previous diagnostic"
  keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

  opts.desc = "Go to next diagnostic"
  keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

  opts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

  opts.desc = "Restart LSP"
  keymap.set("n", "<leader>lrs", ":LspRestart<CR>", opts)

  opts.desc = "Format file"
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)

  opts.desc = "Remove unsed"
  vim.keymap.set(
    "n",
    "<leader>lu",
    function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.removeUnused.ts" },
          diagnostics = {},
        },
      })
    end,
    opts
  )

  opts.desc = "Organize imports"
  vim.keymap.set(
    "n",
    "<leader>li",
    function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.organizeImports.ts" },
          diagnostics = {},
        },
      })
    end,
    opts
  )

  autocmd({ 'BufEnter', 'BufWritePre', 'CursorHold' }, {
    buffer = bufnr,

    callback = function()
      local params = vim.lsp.util.make_text_document_params(bufnr)

      if not client then return end

      client.request(
        'textDocument/diagnostic',
        { textDocument = params },
        function(err, result)
          if err then return end
          if not result then return end

          vim.lsp.diagnostic.on_publish_diagnostics(
            nil,
            vim.tbl_extend('keep', params, { diagnostics = result.items }),
            { client_id = client.id }
          )
        end
      )
    end,
  })
end

-- local function default_on_attach_plus_auto_format(client, buffer)
--   default_on_attach(client, buffer)
--
--   augroup('LspFormat', { clear = true })
--   autocmd('BufWritePre', {
--     group = 'LspFormat',
--     callback = function()
--       vim.lsp.buf.format()
--     end
--   })
-- end

local function default_on_attach_plus_auto_format(client, buffer)
  require("lsp-format").on_attach(client, buffer)
  default_on_attach(client, buffer)
end

local function config()
  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  -- used to enable autocompletion (assign to every lsp server config)
  local capabilities = cmp_nvim_lsp.default_capabilities()

  -- Change the Diagnostic symbols in the sign column (gutter)
  local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- local flags = { debounce_text_changes = 150 }
  local flags = {}

  lspconfig["html"].setup({
    capabilities = capabilities,
    on_attach = default_on_attach,
    flags = flags
  })

  lspconfig["jsonls"].setup({
    capabilities = capabilities,
    on_attach = default_on_attach_plus_auto_format
  })

  -- lspconfig["angularls"].setup {
  --   capabilities = capabilities,
  --   on_attach = default_on_attach,
  --   flags = flags
  -- }

  lspconfig["tsserver"].setup({
    capabilities = capabilities,
    on_attach = default_on_attach_plus_auto_format
  })

  lspconfig["eslint"].setup({
    capabilities = capabilities,
    on_attach = default_on_attach,
    flags = flags
  })

  lspconfig["cssls"].setup({
    capabilities = capabilities,
    on_attach = default_on_attach,
    flags = flags
  })

  lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = default_on_attach,
    settings = {
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          -- make language server aware of runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  })

  -- lspconfig["solargraph"].setup({
  --   cmd = { "bundle", "exec", "solargraph" },
  --   capabilities = capabilities,
  --   on_attach = default_on_attach,
  --   flags = flags
  -- })

  -- lspconfig["ruby-lsp"].setup({
  --   cmd = { "bundle", "exec", "ruby-lsp" },
  --   capabilities = capabilities,
  --   on_attach = default_on_attach_plus_auto_format,
  --   flags = flags
  -- })

  lspconfig["rust_analyzer"].setup({
    capabilities = capabilities,
    on_attach = default_on_attach_plus_auto_format,
    flags = flags
  })
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "lukas-reineke/lsp-format.nvim",
  },
  config = config
}
