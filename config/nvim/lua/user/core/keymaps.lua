local keymap = vim.keymap

-- Resize windows
keymap.set("n", "<C-h>", "<cmd>vertical resize -10<CR>")
keymap.set("n", "<C-l>", "<cmd>vertical resize +10<CR>")
keymap.set("n", "<C-j>", "<cmd>resize +10<CR>")
keymap.set("n", "<C-k>", "<cmd>resize -10<CR>")

-- Indent in visual mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Disable ex mode
keymap.set("n", "Q", "<Nop>")

-- Yank current file path to system buffer
keymap.set("n", "yF", '<cmd>let @+ = expand("%")<CR>')
-- Yank current file and line
keymap.set("n", "yL", '<cmd>let @+ = expand("%") . ":" . line(".")<CR>')


-- Movement between windows

keymap.set("n", "<leader>wh", "<C-W>h")
keymap.set("n", "<leader>wj", "<C-W>j")
keymap.set("n", "<leader>wk", "<C-W>k")
keymap.set("n", "<leader>wl", "<C-W>l")
keymap.set("n", "<leader>wc", "<C-W>c")

keymap.set("t", "<C-w>h", [[<C-\><C-N><C-W>h]])
keymap.set("t", "<C-w>j", [[<C-\><C-N><C-W>j]])
keymap.set("t", "<C-w>k", [[<C-\><C-N><C-W>k]])
keymap.set("t", "<C-w>l", [[<C-\><C-N><C-W>l]])
keymap.set("t", "<C-w>c", [[<C-\><C-N><C-W>c]])

keymap.set("n", "<leader>q", "<cmd>q<CR>")
keymap.set("n", "<leader>Q", "<cmd>qall<CR>")

keymap.set("n", "<leader>rf", "<cmd>cnf<CR>")
keymap.set("n", "<leader>rn", "<cmd>cn<CR>")
keymap.set("n", "<leader>rp", "<cmd>cp<CR>")
keymap.set("n", "<leader>rc", "<cmd>ccl<CR>")

keymap.set("n", "<leader>bb", "<cmd>b#<CR>")

vim.cmd("cnoreabbrev git Git")

-- vim.cmd("cnoreabbrev ag Ack")
-- vim.cmd("cnoreabbrev aG Ack")
-- vim.cmd("cnoreabbrev Ag Ack")
-- vim.cmd("cnoreabbrev AG Ack")

vim.cmd("cnoreabbrev ag GrepperRg")
vim.cmd("cnoreabbrev aG GrepperRg")
vim.cmd("cnoreabbrev Ag GrepperRg")
vim.cmd("cnoreabbrev AG GrepperRg")
vim.cmd("cnoreabbrev Rg GrepperRg")
vim.cmd("cnoreabbrev rg GrepperRg")
vim.cmd("cnoreabbrev Ack GrepperRg")
vim.cmd("cnoreabbrev ack GrepperRg")

vim.cmd("cnoreabbrev Gbl Git blame")


function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  keymap.set('t','<C-x>','<Cmd>TermExec cmd="<C-c>"<CR>')
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


if vim.fn.has("gui_vimr") then
  keymap.set("n", "<S-D-}>", "<cmd>:tabnext<CR>")
  keymap.set("n", "<S-D-{>", "<cmd>:tabprevious<CR>")
end
