local ui  = require('toggleterm.ui')
local Terminal  = require('toggleterm.terminal').Terminal

local rails_test_command_prefix = "bin/rails test -v "

local rails_term
local rails_test_term
local last_run = ""

local function new_shell_term()
  return Terminal:new({ cmd = "$SHELL", hidden = true })
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
  rails_test_term:send(test_command, true)
end

local function run_test_file()
  local test_command = rails_test_command_prefix .. vim.fn.expand("%")
  run_test(test_command)
end

local function run_test_line()
  local test_command = rails_test_command_prefix .. vim.fn.expand("%") .. ":" .. vim.fn.line(".")
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
  rails_term:send(command, true)
end

local function close_all_rails_terms()
  close_rails_term()
  close_test_term()
end

vim.api.nvim_create_user_command("R", function(args)
  run_rails_command("bin/rails " .. args.args)
end, { desc = "Run rails command", nargs = "*" })

vim.keymap.set("n", "<leader>rt", run_test_file, { desc = "Run Rails test file" })
vim.keymap.set("n", "<leader>rl", run_test_line, { desc = "Run Rails test line" })
vim.keymap.set("n", "<leader>rr", run_last, { desc = "Run last Rails test again" })
vim.keymap.set("n", "<leader>rc", close_all_rails_terms, { desc = "Close Rails console" })
