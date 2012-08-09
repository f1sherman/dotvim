call pathogen#infect()
call pathogen#helptags()

:colorscheme ir_black		          " make vim easy on the eyes

:runtime macros/matchit.vim       " enable matchit for textobj-ruby plugin

let mapleader = ","               " use comma for leader

" auto reload .vimrc when it's changed
au BufWritePost .vimrc so ~/.vimrc

" bind control-l to hashrocket
imap <C-l> <Space>=><Space>

" open tag in horizontal split
nnoremap <C-]> <C-w><C-]>

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

" don't show generated files in listings (and Command-T)
set wildignore+=test/reports/**,tmp,.sass-cache,.DS_Store

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
  let s:old_name = expand('%')
  let s:new_name = input('New file name: ', expand('%'), 'file')
  if s:new_name != '' && s:new_name != s:old_name
    " create the directory if it doesn't already exist
    let s:dir = fnamemodify(s:new_name, ":p:h")
    if !isdirectory(s:dir)
      call mkdir(s:dir, "p")
    endif

    try " first try to move with git so history is preserved properly
      exec ':Gmove ' . s:new_name
    catch
      exec ':saveas ' . s:new_name
      exec ':silent !rm ' . s:old_name
    finally
      exec ':CommandTFlush'
    endtry
    redraw!
  endif

  unlet s:old_name
  unlet s:new_name
endfunction
