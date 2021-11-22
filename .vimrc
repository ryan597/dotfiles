" Plugins --------------------------------------------------------------------

" File type detection
filetype on

" Enable plugins
filetype plugin on
filetype indent on

set laststatus=2
set noshowmode

let g:lightline = {
    \ 'colorscheme': 'one',
    \ }


let g:rainbow_active = 1

let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/pack/plugins/start/ycm/.ycm_extra_conf.py'


" Syntax ---------------------------------------------------------------------

" Turn on syntax highlighting
syntax on

" Line numbering
set number


" Cursor ---------------------------------------------------------------------
" Cursor highlighting
set cursorline
"set cursorcolumn


" Spacing --------------------------------------------------------------------
" Spaces not tabs
set shiftwidth=4
set tabstop=4
set expandtab


" Colorscheme ----------------------------------------------------------------

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme one
set background=dark
