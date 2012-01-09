" hide the toolbar in MacVim
if has("gui_running")
  set guioptions=egmrt
endif

" map command-t to command-T
if has("gui_macvim")
  macmenu &File.Open\ Tab\.\.\. key=<nop>
  map <D-T> :CommandT<CR>
endif

let g:CommandTMaxHeight=15
let g:CommandTAlwaysShowDotFiles=1
let g:CommandTScanDotDirectories=1
