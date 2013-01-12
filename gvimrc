if has("gui_macvim")
  set guioptions=egmrt                      " hide the toolbar in MacVim
  " Don't let the MacVim key bindings mess with command-t
  macmenu &File.Open\ Tab\.\.\. key=<nop>
  set vb  " Disable annoying error bell/beep sounds in macvim
endif
