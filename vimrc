if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Plugins
Plug 'altercation/vim-colors-solarized'
Plug 'alvan/vim-closetag'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'christoomey/vim-tmux-navigator'
Plug 'DataWraith/auto_mkdir'
Plug 'jgdavey/vim-blockle'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'mileszs/ack.vim'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdcommenter'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/YankRing.vim'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-abolish'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
call plug#end()

set background=dark

if isdirectory($HOME . '/.vim/plugged/vim-colors-solarized')
  colorscheme solarized          " make vim easy on the eyes
endif

:runtime macros/matchit.vim       " enable matchit for textobj-ruby plugin

let mapleader = ","               " use comma for leader

" Spellcheck and wrap git commit messages at recommended 72 chars
autocmd Filetype gitcommit setlocal spell textwidth=72

" Autoformat all files on save (this also removes trailing whitespace)
au BufWrite * :Autoformat

" Resize panes when vim is resized
autocmd VimResized * :wincmd =

" fix "crontab: temp file must be edited in place" error
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" Highlight debugger statements
au BufEnter *.rb syn match error contained "\<binding.pry\>"
au BufEnter *.rb syn match error contained "\<binding.remote_pry\>"
au BufEnter *.rb syn match error contained "\<debugger\>"
au BufEnter *.js syn match error contained "\<debugger\>"

" bind control-l to hashrocket
imap <C-l> <Space>=><Space>

" open tag in horizontal split
nnoremap <C-]> <C-w><C-]>

" put search result at center of screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Disable ex mode
nnoremap Q <nop>

" use FZF to fuzzy-search files
nnoremap <C-P> :Files<cr>

" use Shift-Q to close all splits
nnoremap Q :qa<cr>

" prevent YankRing from overwriting <C-P> mapping
let g:yankring_replace_n_pkey = ''

" Don't jump to the next line when closing. This is annoying if e.g. we're
" trying to close brackets on the current line and there's another bracket on
" the next line
let g:AutoPairsMultilineClose = 0

" Turn off vim-autoformat autoindent fallback
let g:autoformat_autoindent = 0

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

" Use rg (ripgrep) instead of ack for speed
if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif

let g:ack_use_dispatch = 1

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

" use 'w!!' to save files as root
cnoremap w!! %!sudo tee > /dev/null %

" handle cases where I accidentally use uppercase :WQ
cnoreabbrev W w
cnoreabbrev Q q

" use v and C-v to expand/shrink selection
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" don't show generated files in listings
set wildignore+=test/reports,spec/reports,tmp,.sass-cache,.DS_Store

set nocompatible                  " choose no compatibility with legacy vi
set backupcopy=no                 " avoid creating a '4913' file on every save
syntax enable
set encoding=utf-8
set showcmd                       " display incomplete commands
filetype plugin indent on         " load file type plugins + indentation
set number                        " show line numbers
set scrolloff=3                   " always show 3 lines above and below the cursor
set ruler                         " show row/column # at bottom right
set lazyredraw                    " fix scroll drift when holding down a move key
set autoread                      " when a file changes outside of vim and hasn't been changed inside vim, reload it
set wildmode=longest,list         " shell-style filename completion
set splitbelow                    " Open new splits below instead of above
set regexpengine=1                " Enable the old regexp engine, to speed up syntax highlighting in ruby files

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
set undodir=~/.vimtmp

" Make underscore (_) a word delimiter
set iskeyword-=_

" colorize parenthesis
map <Leader>p :RainbowParenthesesToggle<CR>

" When swapfile is found skip the message and edit the file
set shortmess+=A

" Open folds by default
set nofoldenable

" Don't reset cursor to start of line when moving around
set nostartofline

" show a status line even if there's only one window
set ls=2

" enable closetag
let g:closetag_filenames = '*.html,*.html.erb,*.hbs'

autocmd QuickFixCmdPost *grep* cwindow

noremap <Leader>r :w<CR>:call <SID>RunSpec(0)<CR>
noremap <Leader>R :w<CR>:call <SID>RunSpec(1)<CR>

" Don't lint files when text changes
let g:ale_lint_on_text_changed = 'never'

function! RenameFile()
  let l:old_name = expand('%')
  let l:new_name = input('New file name: ', expand('%'), 'file')
  if l:new_name != '' && l:new_name != l:old_name
    " create the directory if it doesn't already exist
    let l:dir = fnamemodify(l:new_name, ":p:h")
    if !isdirectory(l:dir)
      call mkdir(l:dir, "p")
    endif
    unlet l:dir

    try " first try to move with git so history is preserved properly
      exec ':Gmove ' . l:new_name
    catch E768
      " swap file exists, ignore and edit the moved file
      exec ':edit ' . l:new_name
    catch E492
      " file is not in git, move it outside of git
      exec ':saveas ' . l:new_name
      exec ':silent !rm ' . l:old_name
    catch /fugitive: fatal: not under version control/
      " file is not in git, move it outside of git
      exec ':saveas ' . l:new_name
      exec ':silent !rm ' . l:old_name
    endtry
    redraw!
  endif

  unlet l:old_name
  unlet l:new_name
endfunction

function! <SID>RunSpec(whole_file)
  let l:source_path = expand('%')
  let l:rspec_command = strlen($RSPEC_COMMAND) ? $RSPEC_COMMAND : 'rspec'

  if empty(matchstr(l:source_path, '_spec.rb$'))
    let l:spec_path = substitute(l:source_path, '\.rb$', '', '')
    let l:spec_path = l:spec_path . '_spec.rb'
    let l:spec_path = substitute(l:spec_path, 'app/', 'spec/', '')
    if empty(matchstr(l:spec_path, 'spec/'))
      let l:spec_path = "spec/" . l:spec_path
    endif
  else
    if a:whole_file
      let l:spec_path = l:source_path
    else
      let l:spec_path = l:source_path . ":" . line(".")
    endif
  endif

  let l:command = 'Dispatch ' . l:rspec_command . ' ' . l:spec_path

  execute(l:command)

  unlet l:source_path
  unlet l:spec_path
endfunction

" for tmux to automatically set paste and nopaste mode at the time pasting (as
" happens in VIM UI)
" Found here: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" https://gist.github.com/dahu/3344530
function! MaximizeWithoutResizingQuickfix()
  let qfwnr = get(get(filter(map(range(1,winnr('$')), '[v:val, getwinvar(v:val, "&buftype")]'), 'v:val[1] =~ "quickfix"'), 0, []), 0, -1)
  let qfh = winheight(qfwnr)
  wincmd _
  if qfwnr != -1
    exe qfwnr . "wincmd w"
    exe "resize " . qfh
    wincmd p
  endif
endfunction

" Jump up to the enclosing indent (only works with properly 2-space indented files)
function! UpToEnclosingIndent()
  let search_regex = '^' . repeat(' ', indent(line('.')) - 2) . '\w'
  execute "normal! m'"
  execute search(search_regex, 'b')
endfunction

noremap <leader>u :call UpToEnclosingIndent()<cr>

" prevent maximizing the current window from breaking the quickfix window
" https://gist.github.com/dahu/3344530
noremap <C-w>_ :call MaximizeWithoutResizingQuickfix()<cr>
