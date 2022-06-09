set background=dark

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


