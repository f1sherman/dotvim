call pathogen#infect()
call pathogen#helptags()

:colorscheme ir_black		          " make vim easy on the eyes

:runtime macros/matchit.vim       " enable matchit for textobj-ruby plugin

let mapleader = ","               " use comma for leader

" auto reload .vimrc when it's changed
au BufWritePost .vimrc so ~/.vimrc

" bind control-l to hashrocket
imap <C-l> <Space>=><Space>

" use ; instead of : (save a bunch of keystrokes)
nnoremap ; :

" open tag in horizontal split
nnoremap <C-]> <C-w><C-]>

" use jk instead of esc
inoremap jk <Esc>

" put search result at center of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" easier moving between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" command-shift-f to bring up Ack.vim
map <D-F> :Ack<space>

" command-shift-m to search for a ruby method definition
map <D-M> :Ack<space>def\\s\(self\\.\)?

" search for a ruby method definition in the current file
map <Leader>m /def\s\(self\.\)\?

" open tag in new window
map <Leader>g :stag<CR>

" rename the current file
map <leader>n :call RenameFile()<cr>

" select text that was just pasted (useful for performing commands such as
" formatting)
nnoremap <leader>v V`]

" command-/ to comment/uncomment lines
map <D-/> ,c<space>

set nocompatible                  " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                       " display incomplete commands
filetype plugin indent on         " load file type plugins + indentation
set number                        " show line numbers
set scrolloff=3                   " always show 3 lines above and below the cursor
set cursorline                    " highlight the line the cursor is on
set ruler                         " show row/column # at bottom right

"" Whitespace
set wrap                          " wrap lines
set linebreak                     " don't break words
set tabstop=2 shiftwidth=2        " a tab is two spaces
set softtabstop=2                 " backspace 2 spaces at a time
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode
set formatoptions=qrn1            " custom comment formatting, see :help fo-table
set textwidth=79                  " this, in addition to formatoptions=q, allows me 
                                  " to type gq to format comments
set colorcolumn=150               " make it easier to see when my lines are getting 
                                  " too long

"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital 
                                  " letter

" Don't clutter my dirs up with swp and tmp files
set backupdir=~/.vimtmp
set directory=~/.vimtmp

" Make underscore (_) a word delimiter
set iskeyword-=_

" colorize parenthesis
map <Leader>p :RainbowParenthesesToggle<CR>

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    exec ':CommandTFlush'
    redraw!
  endif
endfunction
