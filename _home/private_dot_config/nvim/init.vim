if !has("compatible")
  " Install vim-plug if not found
  let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  
  " Run PlugInstall if there are missing plugins
  autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif
  
  " Plugins will be downloaded under the specified directory.
  call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
  
  " Declare the list of plugins.
  Plug 'tpope/vim-sensible'
  Plug 'junegunn/seoul256.vim'
  
  call plug#end()
endif

" length of an actual \t character:
set tabstop=4
" length to use when editing text (eg. TAB and BS keys)
" (0 for ‘tabstop’, -1 for ‘shiftwidth’):
set softtabstop=-1
" length to use when shifting text (eg. <<, >> and == commands)
" (0 for ‘tabstop’):
set shiftwidth=0
" round indentation to multiples of 'shiftwidth' when shifting text
" (so that it behaves like Ctrl-D / Ctrl-T):
set shiftround

" if set, only insert spaces; otherwise insert \t and complete with spaces:
set expandtab

" reproduce the indentation of the previous line:
set autoindent
" keep indentation produced by 'autoindent' if leaving the line blank:
set cpoptions+=I
" try to be smart (increase the indenting level after ‘{’,
" decrease it after ‘}’, and so on):
"set smartindent
" a stricter alternative which works better for the C language:
"set cindent
" use language‐specific plugins for indenting (better):
filetype plugin indent on

syntax on
set bg=dark
set tabpagemax=100

nnoremap j jzz
nnoremap k kzz
nnoremap <Down> jzz
nnoremap <Up> kzz

" highlight Cursor       ctermbg=blue guibg=blue
" highlight CursorLine   cterm=NONE    ctermbg=grey ctermfg=darkgrey guibg=grey guifg=darkgrey
" highlight CursorColumn cterm=NONE    ctermbg=darkgrey guibg=darkgrey
highlight Visual       cterm=reverse ctermbg=NONE
" nnoremap <Leader>c :set cursorline! cursorcolumn!
"
" augroup CourorLine
"   au!
"   au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
"   au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"   au WinLeave * setlocal nocursorcolumn
"   au WinLeave * setlocal nocursorline
" augroup END

" let &t_ti.="\e[1 q"
" let &t_SI.="\e[5 q"
" let &t_EI.="\e[1 q"
" let &t_te.="\e[0 q"

autocmd FileType yaml setlocal tabstop=2 softtabstop=-1 shiftwidth=0 expandtab
