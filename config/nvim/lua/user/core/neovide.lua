if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", [[<Cmd>set paste<CR><C-r>+<Cmd>set nopaste<CR>]])
  vim.keymap.set("t", "<D-v>", [[<C-\><C-N>"+Pi]]) -- Paste term mode

  -- Select all
	vim.keymap.set("n", "<D-a>", "ggVG")
	vim.keymap.set("i", "<D-a>", "<ESC>ggVG")
	vim.keymap.set("v", "<D-a>", "<ESC>ggVG")

  vim.keymap.set("n", "<D-z>", "u") -- Undo
  -- Not working in neovide
  vim.keymap.set("n", "<C-S-z>", "<C-r>") -- Redo

  vim.keymap.set("n", "<D-w>", "<cmd>:q<CR>")
  vim.keymap.set("t", "<D-w>", [[<C-\><C-N><cmd>:q<CR>]])

  -- This should be <S-D-]> but there is a bug in Neovide preventing the use of
  -- shifted mappings with special characters so this matches for both <S-D-]> and <D-]>
  vim.keymap.set("n", "<D-]>", "<cmd>:tabnext<CR>")
  vim.keymap.set("t", "<D-]>", [[<C-\><C-N><cmd>:tabnext<CR>]])
  vim.keymap.set("n", "<D-[>", "<cmd>:tabprevious<CR>")
  vim.keymap.set("t", "<D-[>", [[<C-\><C-N><cmd>:tabprevious<CR>]])

  vim.keymap.set("n", "<D-t>", "<cmd>:tabnew<CR>")
  vim.keymap.set("t", "<D-t>", [[<C-\><C-N><cmd>:tabnew<CR>]])

  vim.keymap.set("n", "<D-1>", "1gt")
  vim.keymap.set("n", "<D-2>", "2gt")
  vim.keymap.set("n", "<D-3>", "3gt")
  vim.keymap.set("n", "<D-4>", "4gt")
  vim.keymap.set("n", "<D-5>", "5gt")
  vim.keymap.set("n", "<D-6>", "6gt")
  vim.keymap.set("n", "<D-7>", "7gt")
  vim.keymap.set("n", "<D-8>", "8gt")
  vim.keymap.set("n", "<D-9>", "9gt")

  vim.keymap.set("t", "<D-1>", [[<C-\><C-N>1gt]])
  vim.keymap.set("t", "<D-2>", [[<C-\><C-N>2gt]])
  vim.keymap.set("t", "<D-3>", [[<C-\><C-N>3gt]])
  vim.keymap.set("t", "<D-4>", [[<C-\><C-N>4gt]])
  vim.keymap.set("t", "<D-5>", [[<C-\><C-N>5gt]])
  vim.keymap.set("t", "<D-6>", [[<C-\><C-N>6gt]])
  vim.keymap.set("t", "<D-7>", [[<C-\><C-N>7gt]])
  vim.keymap.set("t", "<D-8>", [[<C-\><C-N>8gt]])
  vim.keymap.set("t", "<D-9>", [[<C-\><C-N>9gt]])

  -- vim.opt.guifont = "MesloLGM Nerd Font Mono:h12"  -- GUI font
  -- vim.opt.guifont = "MesloLGSDZ Nerd Font Mono:h12"  -- GUI font
  -- vim.opt.guifont = "FiraCode Nerd Font Mono:h12"  -- GUI font
  -- vim.opt.guifont = "IntoneMono Nerd Font Mono:h12.2"  -- GUI font
  -- vim.opt.guifont = "DejaVuSansM Nerd Font Mono:h12"  -- GUI font
  -- vim.opt.guifont = "BlexMono Nerd Font Mono:h12"  -- GUI font
  -- vim.opt.guifont = "OpenDyslexicM Nerd Font Mono:h12"  -- GUI font
  vim.opt.guifont = "MesloLGSDZ Nerd Font Mono:h12"  -- GUI font
  vim.opt.linespace = -2

  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.05
  vim.g.neovide_scroll_animation_length = 0
end
