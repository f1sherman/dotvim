set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'ervandew/screen'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'mileszs/ack.vim'
Bundle 'wincent/Command-T'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'

set background=dark
colorscheme solarized          " make vim easy on the eyes

:runtime macros/matchit.vim       " enable matchit for textobj-ruby plugin

let mapleader = ","               " use comma for leader

" auto reload .vimrc when it's changed (augroup is necessary to keep from
" slowing vim down as the file is changed)
augroup ReloadVimrc
  au!
  au BufWritePost .vimrc so ~/.vimrc
augroup END

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

" move up/down on displayed lines rather than actual lines
noremap k gk
noremap j gj

" ctrl-f to bring up Ack.vim
map <C-F> :Ack<space>

" ctrl-m to search for a ruby method definition
map <C-M> :Ack<space>def\\s\(self\\.\)?

" search for a ruby method definition in the current file
map <Leader>m /def\s\(self\.\)\?

" open tag in new window
map <Leader>g :stag<CR>

" rename the current file
map <leader>n :call RenameFile()<cr>

" select text that was just pasted (useful for performing commands such as
" formatting)
nnoremap <leader>v V`]

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
set lazyredraw                    " fix scroll drift when holding down a move key
set autoread                      " when a file changes outside of vim and hasn't been changed inside vim, reload it
set wildmode=longest,list         " shell-style filename completion

"" Whitespace
set wrap                          " wrap lines
set linebreak                     " don't break words
set tabstop=2 shiftwidth=2        " a tab is two spaces
set softtabstop=2                 " backspace 2 spaces at a time
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode
set formatoptions=qrn1            " custom comment formatting, see :help fo-table
set textwidth=120                 " this, in addition to formatoptions=q, allows me 
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

" When swapfile is found skip the message and edit the file
set shortmess+=A

" --- Command-T options ---
" Ctl-t to open command-T
map <C-T> :CommandT<CR>
"Flush the command-t buffer with ,r
map <Leader>f :CommandTFlush<CR>
let g:CommandTMaxHeight=15          " set command-t window max height
let g:CommandTAlwaysShowDotFiles=1  " show dotfiles in command-t
let g:CommandTScanDotDirectories=1  " show files in dotdirectories in command-t
let g:CommandTMaxFiles=100000       " increase file limit for command-t

" --- Screen options ---
let g:ScreenImpl = 'Tmux'
let g:ScreenShellTmuxInitArgs = '-2'
let g:ScreenShellInitialFocus = 'shell'
let g:ScreenShellQuitOnVimExit = 0
map <F5> :ScreenShellVertical<CR>
map <Leader>r :w<CR> :call ScreenShellSend('rspec ' . matchstr(@%, 'spec/.*') . ':' . line("."))<CR>
map <Leader>R :w<CR> :call ScreenShellSend('rspec ' . matchstr(@%, 'spec/.*'))<CR>

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
