set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Bundles
Plugin 'gmarik/Vundle.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
Bundle 'pangloss/vim-javascript'
Bundle 'plasticboy/vim-markdown'
Bundle 'tpope/vim-dispatch'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-haml'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'terryma/vim-expand-region'

call vundle#end() 

set background=dark

if isdirectory($HOME . '/.vim/bundle/vim-colors-solarized')
  colorscheme solarized          " make vim easy on the eyes
endif

:runtime macros/matchit.vim       " enable matchit for textobj-ruby plugin

let mapleader = ","               " use comma for leader

" Spellcheck and wrap git commit messages at recommended 72 chars
autocmd Filetype gitcommit setlocal spell textwidth=72

" Remove trailing whitespace on save
autocmd BufWritePre *.rb,*.js,*.jst,*.haml,*.html,*.css,*.sass :call <SID>StripTrailingWhitespaces()

" Resize panes when vim is resized
autocmd VimResized * :wincmd =

" fix "crontab: temp file must be edited in place" error
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" Highlight debugger statements
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<debugger\>"
au BufEnter *.js syn match error contained "\<debugger\>"

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

" copy current selection to OS X clipboard
vmap <F2> :w !pbcopy<CR><CR>

" ctrl-f to bring up Ack.vim
map <C-F> :Ack<space>

" Use ag (silver searcher) instead of ack for speed
let g:ackprg = 'ag --nogroup --nocolor --column --skip-vcs-ignores'

" ctrl-g to search for a ruby method definition
map <C-G> :Ack<space>def\\s\(self\\.\)?

" search for a ruby method definition in the current file
map <Leader>m /def\s\(self\.\)\?

" open tag in new window
map <Leader>g :stag<CR>

" rename the current file
map <leader>n :call RenameFile()<cr>

" select text that was just pasted (useful for performing commands such as
" formatting)
nnoremap <leader>v V`]

" use v and C-v to expand/shrink selection
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" don't show generated files in listings
set wildignore+=test/reports,spec/reports,tmp,.sass-cache,.DS_Store

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|(spec|test)\/reports)$',
  \ }

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
set splitbelow                    " Open new splits below instead of above

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
set colorcolumn=115               " make it easier to see when my lines are getting 
                                  " too long (github cuts off at about 115 chars on
                                  " diffs)

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

" Open folds by default
set nofoldenable

" Avoid hanging when saving some files
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["eruby", "haml", "sass", "scss"] }

map <Leader>r :w<CR> :call <SID>RunSpec(0)<CR>
map <Leader>R :w<CR> :call <SID>RunSpec(1)<CR>

function! RenameFile()
  let s:old_name = expand('%')
  let s:new_name = input('New file name: ', expand('%'), 'file')
  if s:new_name != '' && s:new_name != s:old_name
    " create the directory if it doesn't already exist
    let s:dir = fnamemodify(s:new_name, ":p:h")
    if !isdirectory(s:dir)
      call mkdir(s:dir, "p")
    endif
    unlet s:dir

    try " first try to move with git so history is preserved properly
      exec ':Gmove ' . s:new_name
    catch E768
      " swap file exists, ignore and edit the moved file
      exec ':edit ' . s:new_name
    catch E492
      " file is not in git, move it outside of git
      exec ':saveas ' . s:new_name
      exec ':silent !rm ' . s:old_name
    catch /fugitive: fatal: not under version control/
      " file is not in git, move it outside of git
      exec ':saveas ' . s:new_name
      exec ':silent !rm ' . s:old_name
    endtry
    redraw!
  endif

  unlet s:old_name
  unlet s:new_name
endfunction

function! <SID>RunSpec(whole_file)
  let s:source_path = expand('%')

  if empty(matchstr(s:source_path, '_spec.rb$'))
    let s:spec_path = substitute(s:source_path, '\.rb$', '', '')
    let s:spec_path = s:spec_path . '_spec.rb'
    let s:spec_path = substitute(s:spec_path, 'app/', 'spec/', '')
    if empty(matchstr(s:spec_path, 'spec/'))
      let s:spec_path = "spec/" . s:spec_path
    endif
  else
    if a:whole_file
      let s:spec_path = s:source_path
    else
      let s:spec_path = s:source_path . ":" . line(".")
    endif
  endif

  execute('Dispatch cd $VAGRANT_DIR && vagrant exec bin/rspec ' . s:spec_path)

  unlet s:source_path
  unlet s:spec_path
endfunction

function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

" for tmux to automatically set paste and nopaste mode at the time pasting (as
" happens in VIM UI)
" Found here: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
 
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif
 
  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"
 
  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction
 
let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")
 
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
 
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
