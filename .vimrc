" ************ global settings ************

" system colorscheme
"colorscheme desert

" support 256
set t_Co=256
" colorscheme molokai
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

set number
set background=dark
" highlight words which be searched
set hlsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set laststatus=2

function! CurDir()
	let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
	return curdir
endfunction

" Format the statusline
set statusline=
set statusline+=%f "path to the file in the buffer, relative to current directory
set statusline+=\ %h%1*%m%r%w%0* " flag
set statusline+=\ [%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding}, " encoding
set statusline+=%{&fileformat}] " file format
set statusline+=\ PWD:%r%{CurDir()}%h
set statusline+=\ Char:%-14.(%l,%c%V%)\ %<%P
set statusline+=\ Line:%l/%L

" Chinese help manual
set helplang=cn
" highlight syntax
syntax on
" search without upper or lower in smart
set ignorecase smartcase

" 高亮一列
hi ColorColumn ctermbg=lightgreen
autocmd FileType python,c,cpp set cc=131

" ************* operation key map ***************
" 删除行尾空格
" map <F4> <ESC>:%s/\s\+$//g <CR>

" ************* plugins ***************

" Vundle
" :PluginInstall    - installs plugins; append `!` to update or just
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

" indentLine
let g:indentLine_char = '¦'
let g:indentLine_first_char = '¦'
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'

" nerdtree
" 查看文件树
"map <C-n> :NERDTreeToggle<CR>

" nerdcommenter
" 快速批量加减注释
" <leader>cc 注释当前行和选中行
" <leader>cu 取消注释
" <Leader>符默认为 \
" Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
