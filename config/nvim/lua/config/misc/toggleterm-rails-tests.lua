local ui = require("toggleterm.ui")
local Terminal = require("toggleterm.terminal").Terminal

local rails_term
local rails_test_term
local last_run = ""

local function new_shell_term()
  return Terminal:new({ cmd = "$SHELL", hidden = true })
end

-- Returns the name of the child directory containing the Rails root,
-- or nil if the current directory is itself the Rails root.
local function rails_root_subdir()
  local cwd = vim.fn.getcwd()
  if vim.fn.filereadable(cwd .. "/config/application.rb") == 1 then
    return nil
  end
  local hits = vim.fn.glob(cwd .. "/*/config/application.rb", false, true)
  for _, hit in ipairs(hits) do
    local subdir = vim.fn.fnamemodify(hit, ":h:h")
    if vim.fn.getftype(subdir) ~= "link" then
      return vim.fn.fnamemodify(subdir, ":t")
    end
  end
  return nil
end

local function rails_cmd_prefix()
  local subdir = rails_root_subdir()
  if subdir then
    return "cd " .. subdir .. "; source .envrc; bin/rails"
  end
  return "bin/rails"
end

local function current_file()
  local path = vim.fn.expand("%")
  local subdir = rails_root_subdir()
  if subdir then
    local prefix = subdir .. "/"
    if path:sub(1, #prefix) == prefix then
      path = path:sub(#prefix + 1)
    end
  end
  return path
end

local function close_term(term)
  if term then
    ui.set_origin_window()
    ui.close(term)
    ui.stopinsert()
  end
end

local function close_test_term()
  close_term(rails_test_term)
end

local function run_test(test_command)
  last_run = test_command

  close_test_term()

  if not rails_test_term then
    rails_test_term = new_shell_term()
  end

  rails_test_term:open()
  local cmd = rails_root_subdir() and (test_command .. "; cd -") or test_command
  rails_test_term:send(cmd, true)
end

local function run_test_file()
  local test_command = rails_cmd_prefix() .. " test -v " .. current_file()
  run_test(test_command)
end

local function run_test_line()
  local test_command = rails_cmd_prefix() .. " test -v " .. current_file() .. ":" .. vim.fn.line(".")
  run_test(test_command)
end

local function run_last()
  if last_run then
    run_test(last_run)
  end
end

local function close_rails_term()
  close_term(rails_term)
end

local function run_rails_command(command)
  if not rails_term then
    rails_term = new_shell_term()
  end

  rails_term:toggle()
  rails_term:send(rails_cmd_prefix() .. " " .. command, true)
end

local function close_all_rails_terms()
  close_rails_term()
  close_test_term()
end

vim.api.nvim_create_user_command("R", function(args)
  run_rails_command(args.args)
end, { desc = "Run rails command", nargs = "*" })

vim.keymap.set("n", "<leader>rf", run_test_file, { desc = "Run Rails test file" })
vim.keymap.set("n", "<leader>rt", run_test_line, { desc = "Run Rails test under cursor" })
vim.keymap.set("n", "<leader>rr", run_last, { desc = "Run last Rails test again" })
vim.keymap.set("n", "<leader>rc", close_all_rails_terms, { desc = "Close Rails console" })
