if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Plugins
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/YankRing.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'kana/vim-textobj-user'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-dispatch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-haml'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'terryma/vim-expand-region'
Plug 'vim-ruby/vim-ruby'
Plug 'Valloric/YouCompleteMe'
Plug 'DataWraith/auto_mkdir'
Plug 'jiangmiao/auto-pairs'
call plug#end()

set background=dark

if isdirectory($HOME . '/.vim/plugged/vim-colors-solarized')
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

" Disable ex mode
nnoremap Q <nop>

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

let g:ctrlp_match_window = 'top,order:ttb,min:1,max:20'
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  " ag is fast enough that we don't need caching
  let g:ctrlp_use_caching = 0

  " remove file limit
  let g:ctrlp_max_files = 0
  
  " fix slow update when holding the backspace key
  let g:ctrlp_lazy_update = 10

  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

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

" Avoid hanging when saving some files
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["eruby", "haml", "sass", "scss"] }

" Disable the 'not following' shellcheck error since there isn't much to do about it
let g:syntastic_sh_shellcheck_args = '-e SC1091'

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

" Jump to the enclosing Block (only works with properly 2-space indented files)
function! JumpToEnclosingBlock()
  let search_regex = '^' . repeat(' ', indent(line('.')) - 2) . '\w'
  execute search(search_regex, 'b')
endfunction

noremap <leader>b :call JumpToEnclosingBlock()<cr>

" prevent maximizing the current window from breaking the quickfix window
" https://gist.github.com/dahu/3344530
noremap <C-w>_ :call MaximizeWithoutResizingQuickfix()<cr>
