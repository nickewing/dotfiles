let g:using_neovim_gtk = exists('g:GtkGuiLoaded')
let g:using_neovim_qt = exists("*GuiName") && GuiName() == 'nvim-qt'
let g:using_gnvim = exists("g:gnvim")
let g:using_macvim = has('gui_macvim')
let g:using_other_gui = has('gui_running')
let g:using_vimr = has('gui_vimr')

if g:using_neovim_gtk
  " call rpcnotify(1, 'Gui', 'Font', 'Hack Bold 9')
  " call rpcnotify(1, 'Gui', 'Font', 'Fira Mono for Powerline Medium 9')
  " call rpcnotify(1, 'Gui', 'Font', 'Roboto Mono Medium for Powerline Medium 9')
  " call rpcnotify(1, 'Gui', 'Font', 'Source Code Pro for Powerline Semibold 9')
  " call rpcnotify(1, 'Gui', 'Font', 'Noto Mono for Powerline Bold 9')
  call rpcnotify(1, 'Gui', 'Font', 'Meslo LG S for Powerline Bold 9')

  " call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
  " let g:GuiInternalClipboard = 1
elseif g:using_neovim_qt
  " Makes tab bar match theme
  " GuiAdaptiveColor 1
  " set guifont=Monego\ Nerd\ Font:h9
  set guifont=Meslo\ LG\ S\ for\ Powerline:h9:b
  " set guifont=Fira\ Mono\ for\ Powerline:h9:w57
elseif g:using_gnvim
  set guifont=Meslo\ LG\ S\ for\ Powerline\ Bold:h9

  call gnvim#enable_ext_cmdline(0)
  " call gnvim#enable_ext_tabline(0)
elseif g:using_macvim
  " set guifont=Monaco:h12
  " set guifont=Fira\ Code:h12
  " set guifont=Hasklig:h12
  set transparency=5
  set macligatures
end

" Disable scrollbars and toolbar.
set guioptions-=rL

colorscheme onedark

" Use thick vertical splits
" hi VertSplit guibg=fg guifg=fg
" hi VertSplit guibg=#4b5263 guifg=#4b5263
