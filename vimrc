call pathogen#infect()
call pathogen#helptags()

:colorscheme ir_black		          " make vim easy on the eyes

:runtime macros/matchit.vim       " enable matchit for textobj-ruby plugin

let mapleader = ","               " use comma for leader

" bind control-l to hashrocket
imap <C-l> <Space>=><Space>

" easier moving between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" command-shift-f to bring up Ack.vim
map <D-F> :Ack<space>

" command-shift-m to search for a method definition
map <D-M> :Ack<space>def\\s\(self\\.\)?

" find a method in the current file
map <Leader>m /def\s\(self\.\)\?

" command-/ to comment/uncomment lines
map <D-/> ,c<space>

set nocompatible                  " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                       " display incomplete commands
filetype plugin indent on         " load file type plugins + indentation
set number                        " show line numbers

"" Whitespace
set wrap                          " wrap lines
set linebreak                     " don't break words
set tabstop=2 shiftwidth=2        " a tab is two spaces
set softtabstop=2                 " backspace 2 spaces at a time
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode

"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

" Don't clutter my dirs up with swp and tmp files
set backupdir=~/.vimtmp
set directory=~/.vimtmp

" git blame for selected lines (stolen from https://github.com/r00k/dotfiles/blob/master/vimrc)
vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" run the current spec
map <Leader>rs :!bundle exec rspec % --format documentation<CR>

" run the current spec line (stolen from https://github.com/r00k/dotfiles/blob/master/vimrc)
map <Leader>rl :call RunCurrentLineInTest()<CR>

function! CorrectTestRunner()
  if match(expand('%'), '\.feature$') != -1
    return "cucumber"
  elseif match(expand('%'), '_spec\.rb$') != -1
    return "rspec"
  else
    return "ruby"
  endif
endfunction

function! RunCurrentTest()
  if CorrectTestRunner() == "ruby"
    exec "!ruby" expand('%:p')
  else
    exec "!" . CorrectTestRunner() . " --drb" . " " . expand('%:p')
  endif
endfunction

function! RunCurrentLineInTest()
  exec "!" . CorrectTestRunner() . " --drb" . " " . expand('%:p') . ":" . line(".")
endfunction
