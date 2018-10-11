" Vundle
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
set nocompatible
filetype off  
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'Yggdroot/indentLine'
call vundle#end()
filetype plugin indent on

" First of all, to define your os's type
" Define a function: MySys(), is used to define os's type
" MySys() is a global varible, is also used in else
function! MySys()
	return "linux"
endfunction
"Set shell to be bash
if MySys() == "linux" || MySys() == "mac"
	set shell=bash
else
	"I have to run win32 python without cygwin
	"set shell=E:\cygwin\bin\sh
endif

" ******** General Setup *******************
" Some Vim's default 'bugs'
" backspace
set backspace=indent,eol,start
" Get out of VI's compatible mode
set nocompatible
" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
" enable error files and error jumping
set cf
" turns out I do like is sharing windows clipboard
set clipboard+=unnamed
" make sure it can save viminfo
set viminfo+=
" none of these should be word dividers, so make them not be
set isk+=_,$,@,%,#,-
" tell us when anything is changed via :...
set report=0
" open large file
" ref: http://www.vim.org/tips/tip.php?tip_id=343
if !exists("my_auto_commands_loaded")
        let my_auto_commands_loaded = 1
        let g:LargeFile = 1024 * 1024 * 20
        augroup LargeFile
                autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
        augroup END
endif 
" spell check
"set spell
" turn off it
" set nospell
" Usage:
" ]s move to next wrong spelled word
" [s similiar to above
" z= show cadadiate words
" zg tell vim the word is correct
" zw opposite to above

" define mapleader (shortcuts)
let mapleader = ","
let g:mapleader = ","

" show lines' number
" set nu
set number
" we are using a dark background
set background=dark

" For Search
" highlight words which be searched
set hlsearch
" Searching when you input
set incsearch
" search without upper or lower in smart
set ignorecase smartcase
" Turn on Wild menu
set wildmenu
" set magic
set magic
" show matching bracet
set showmatch
" How many tenths of a second to blink
set matchtime=4
" for SuperTab
" enhence tab to complementation
" ~/.vim/plugin/supertab.vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=1643
" let g:SuperTabRetainCompletionType=2
" let g:SuperTabDefaultCompletionType="<C-X><C-O>"
"what to show when I hit :set lis
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
" Grep.vim
" Grep in vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=311
" ~/.vim/plugin/grep.vim
nnoremap <silent> <F4> :Grep<CR>

" history
" Sets how many lines of history VIM have to remember
set history=100
" Set to auto read when a file is changed from the outside
set autoread
" backup
" make backup file
" set backup
" where to put backup file
" set backupdir=~/bak/vim.auto/vim/
" directory is the directory for temp file
" set directory=~/bak/vim.auto/vim/
" When using make, where should it dump the file
" set makeef=error.mkf

" *******************Format and Appearance of VIM *******************
" Setup auto indent
" set the width of tabs to 4
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Highlight long lines
" REF: http://vim.wikia.com/wiki/Highlight_long_lines
"au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" auto convert tab to blank when input tab
" set expandtab
" convert all tabs to blank
" retab
" to solve the different between shiftwidth and tabstop
" set smarttab
" convert tab to character, tab will show as: >-
" set list listchars=tab:>-
" don't break a whole word
set lbr
" Wrap the line
set wrap
" do not redraw while running macros (much faster)
set lz
" Set 7 lines to the curors - when moving vertical
set so=7
" Always show current position
set ruler
" The commandbar is 2 high
set cmdheight=1
" Backspace and cursor keys wrap: Strong h and l
set whichwrap+=<,>,h,l
" diff
set diffopt=horizontal

" Status line
" Always hide the statusline
set laststatus=2
" here, define a function: Cursor()
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

" File explorer
" Split vertically
let g:explVertical=1
" Window size
" width of 35 pixels
let g:explWinSize=35
let g:explSplitLeft=1
let g:explSplitBelow=1
" Hide some file
let g:explHideFiles='^.,.*.class$,.*.swp$,.*.pyc$,.*.swo$,.DS_Store$'
"Hide the help thing..
let g:explDetailedHelp=0

" Tabs and Buffer
" Change buffer - without saving
" set hid
" Moving around and tab
" Ref: http://www.linuxgem.org/tip/tabs-in-vim.html
:map <C-j> :tabprevious<CR>
:map <C-k> :tabnext<CR>
:map <C-n> :tabnew . <CR>
:map <C-l> :TlistToggle <CR>
":imap <F2> <ESC>:tabprevious<CR>i
":imap <F3> <ESC>:tabnext<CR>i
:imap <C-n> <ESC>:tabnew . <CR>i
:imap <C-l> <ESC>:TlistToggle <CR>i
if has("usetab")
	set switchbuf=usetab
endif
if has("stal")
	set stal=2
endif

" File Operation
" Enable filetype plugin
if has("eval")
	filetype plugin on
	filetype indent on
endif
" Favorite filetype
" default filetype is unix
set ffs=unix,dos,mac
nmap <leader>fd :set ff=dos<cr>
nmap <leader>fu :set ff=unix<cr>


" Setup for Unicode
" Chinese help manual
set helplang=cn
if has("multi_byte")
	" tell Vim which teminal's Encode
	set fileencodings=utf-8,gb2312,gbk,gb18030
	set termencoding=utf-8
	" set encode to UTF8
	set encoding=utf-8
	" File encode
	set fenc=utf-8
	" set file's type and format
	set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
	" for Chinese documents
	let &termencoding=&encoding
	set fileencodings=utf-8,cp936,big5
endif
" FencView.vim : Autodetect multiple encodings 
" HomePage: http://www.vim.org/scripts/script.php?script_id=1708
"let g:fencview_autodetect = 1    
" if you use vim in tty
" 'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
if has("ambiwidth")
	set ambiwidth=double
endif
" The module of 'break line' to support asia language
set fo+=mB

" ********* For Coding ***************
" basic personal information
let g:author = "huangzhipeng"
let g:author_ref = "huangzhipeng"
let g:company = "Maimiao Tech"
let g:copyright = "Copyright Maimiaotech.com"
let g:email = "huangzhipeng@maimiaotech.com"
let g:license = "Copyright Maimiaotech.com"
" highlight syntax
" syntax enable
" support 256
" REF: http://plog.longwin.com.tw/my_note-unix/2008/12/19/vim-screen-set-support-256-color-2008
set t_Co=256
if &t_Co > 2 || has("gui_running")
	  syntax on
endif
if &t_Co == 256
    "syntax on
    "syntax enable
    "set background=dark
    "let g:solarized_termtrans=1
    "let g:solarized_termcolors=256
    "let g:solarized_degrade=0
    "let g:solarized_contrast="normal"
    "let g:solarized_visibility="normal"
    "colorscheme solarized
    "colorscheme desert256
    colorscheme 256_asu1dark 
    "colorscheme molokai
    "let g:molokai_original = 1
    "let g:rehash256 = 1
    "let g:seoul256_background = 233
    "colorscheme seoul256
    "set background=dark
    "colorscheme monokai
    "colorscheme 256_adaryn 
	"colorscheme 256_automation 
	"colorscheme 256_darkdot 
	"colorscheme 256_redblack
endif

" syntax for which 
map <leader>cpp :set syntax=c<cr>
map <leader>html :set syntax=xhtml<cr>
map <leader>js :set ft=javascript<cr>
map <leader>pl :set syntax=perl<cr>
map <leader>py :set syntax=python<cr>
map <leader>rb :set syntax=ruby<cr>
map <leader>sh :set syntax=sh<cr>

" Code Folding
" Enable folding, but by default make it act like folding is off, because folding is
" annoying in anything but a few rare cases
set foldenable " Turn on folding
set foldmethod=indent " Make folding indent sensitive
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
"set foldopen-=search " don't open folds when you search into them
"set foldopen-=undo " don't open folds when you undo stuff
au BufReadPost *.h,*.c,*.cpp,*.cc,*.java,*.pl,*.py,*.rb    syn region myFold start="{" end="}" transparent fold
au BufReadPost *.h,*.c,*.cpp,*.cc,*.java,*.pl,*.py,*.rb    syn sync fromstart
au BufReadPost *.h,*.c,*.cpp,*.cc,*.java,*.pl,*.py,*.rb    set foldmethod=syntax

" General
let g:snip_set_textmate_cp=1

" Code Complete 
" autocomplpop.vim : Automatically open the popup menu for completion 
" REF:http://www.vim.org/scripts/script.php?script_id=1879
" AutoComplPopEnable 
" AutoComplPopDisable 

" ============== C/CPP ========================
if has("autocmd")
 	autocmd FileType c,cpp filetype on
 	autocmd FileType c,cpp filetype indent on
 	autocmd FileType c,cpp filetype plugin on
 	" about tab, follow gnu style: tab width is 4
 	autocmd FileType c,cpp set tabstop=4
 	autocmd FileType c,cpp set shiftwidth=4
 	autocmd FileType c,cpp set softtabstop=4
 	autocmd FileType c,cpp setlocal textwidth=80
 	autocmd FileType c,cpp set tags+=./tags
endif

" omnifunc
" REF: http://forum.ubuntu.org.cn/viewtopic.php?f=63&t=148237&start=15
if has("autocmd")
	autocmd FileType c set omnifunc=ccomplete#Complete
	autocmd FileType c set omnifunc=cppcomplete#Complete
	autocmd FileType cpp set omnifunc=ccomplete#Complete
	autocmd FileType cpp set omnifunc=cppcomplete#Complete
	"autocmd FileType cpp set tags+=~/.vim/templates/boost.tags
	autocmd FileType cpp set tags+=~/.vim/templates/std.tags
	" REF: http://vim.wikia.com/wiki/C%2B%2B_code_completion
	let OmniCpp_NamespaceSearch = 1
	let OmniCpp_GlobalScopeSearch = 1
	let OmniCpp_ShowAccess = 1
	let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
	let OmniCpp_MayCompleteDot = 1 " autocomplete after .
	let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
	let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
	let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
	" automatically open and close the popup menu / preview window
	au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
	set completeopt=menuone,menu,longest,preview
endif

" C-support
" http://www.vim.org/scripts/script.php?script_id=213
" ~/.vim/c-support/
" Here can set many options, and reference it
" http://lug.fh-swf.de/vim/vim-doc/csupport.html
" enhence header template
" ~/.vim/plugin/c-support-plugin.vim
let g:c_author = g:author 
let g:c_email = g:email
let g:c_company = g:company

" a.vim
" ~/.vim/plugin
" HomePage: http://vim.sourceforge.net/scripts/script.php?script_id=31
" A few of quick commands to swtich between source files and header files quickl" some scripts
" :A switches to the header file corresponding to the current file being edited (or vise versa) 
" :AS splits and switches 
" :AV vertical splits and switches 
" :AT new tab and switches 
" :AN cycles through matches 
" :IH switches to file under cursor 
" :IHS splits and switches 
" :IHV vertical splits and switches 
" :IHT new tab and switches 
" :IHN cycles through matches 
" <Leader>ih switches to file under cursor 
" <Leader>is switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp) 
" <Leader>ihn cycles through matches 
"if has("autocmd")
"	autocmd FileType c,cpp source ~/.vim/plugin/a.vim 
"endif

" echofunc.vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=1735
" ~/.vim/plugin
" When you type '(' after a function name in insert mode, the function declaration will be displayed in the command line automatically
"if has("autocmd")
"	autocmd FileType c,cpp source ~/.vim/plugin/echofunc.vim
"endif 

" Cscope
" HomePage: http://cscope.sourceforge.net/
"set cscopequickfix=s-,c-,d-,i-,t-,e-

" OmniCppComplete : C/C++ omni-completion with ctags database 
" HomePage: http://www.vim.org/scripts/script.php?script_id=1520
" autoload

" ================= bash ===========================
if has("autocmd")
 	autocmd FileType sh filetype on
 	autocmd FileType sh filetype indent on
 	autocmd FileType sh filetype plugin on
endif
" bash-support
" ~/.vim/bash-support
" HomePage: http://www.vim.org/scripts/script.php?script_id=365
let g:BASH_AuthorName = g:author 
let g:BASH_AuthorRef = g:author_ref
let g:BASH_Email = g:email
let g:BASH_Company = g:company
" genutils.vim
" This script provides functions that are mostly useful to script developers,
" but some of the functions can be easily converted to good utilities. 
" ~/.vim/plugin/genutils.vim
" ~/.vim/autoload/genutils.vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=197
"source ~/.vim/plugin/genutils.vim

" ======================== Perl ================================
if has("autocmd")
 	autocmd FileType perl filetype on
 	autocmd FileType perl filetype indent on
 	autocmd FileType perl filetype plugin on
endif
if has("autocmd")
	autocmd FileType perl set omnifunc=perlcomplete#CompletePERL
endif
" perl-support
" ~/.vim/perl-support
" HomePage: http://www.vim.org/scripts/script.php?script_id=556
" ~/.vim/plugin/perl-support-plugin.vim
let g:perl_author = g:author
let g:perl_email = g:email 
let g:perl_company = g:company
let g:perl_copyright = g:copyright 

" ====================== Python ======================================
" filetype on
if has("autocmd")
 	autocmd FileType python filetype on
 	autocmd FileType python filetype indent on
 	autocmd FileType python filetype plugin on
endif
" tab
if has("autocmd")
	autocmd FileType python set tabstop=4
	autocmd FileType python set softtabstop=4
	autocmd FileType python set shiftwidth=4
	autocmd FileType python set autoindent
	autocmd FileType python set cindent
	autocmd FileType python set expandtab
	autocmd FileType python set smarttab
	autocmd FileType python set foldcolumn=1
     "autocmd FileType python setlocal textwidth=80
	" extra
	" REF: http://py.vaults.ca/~x/python_and_vim.html
	autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
	" Trim Trailing Whitespace
	" Many people like to remove any extra whitespace from the ends of lines.
	" Here is one way to do it when saving your file
	"autocmd BufWritePre *.py normal :%s/\s\+$//e
endif

"if has("autocmd")
"	autocmd FileType python set omnifunc=pythoncomplete#Complete
"endif
" -- syntax 
" python.vim
" Enhanced version of the original (from vim6.1) python.vim for Python
" programming language. 
" HomePage: http://www.vim.org/scripts/script.php?script_id=790
" ~/.vim/syntax/python.vim

" -- complete
" ~/.vim/ftplugin/python_fn.vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=30
"	- Select a block of lines with the same indentation 
"   - Select a function 
"   - Select a class 
"   - Go to previous/next class/function 
"   - Go to the beginning/end of a block 
"   - Comment/uncomment the selection 
"   - Jump to the last/next line with the same indent 
"   - Shift a block (left/right) 
"   - Creates list of classes and functions for easy code navigation 
if has("autocmd")
	autocmd FileType python source ~/.vim/ftplugin/python_fn.vim
endif

"" python_ifold
"" HomePage: http://www.vim.org/scripts/script.php?script_id=2002
"" Improved version of python_fold. Uses folding expression for python code.
if has("autocmd")
	autocmd FileType python source ~/.vim/ftplugin/python_ifold.c.vim
endif

" pyflakes
" HomePage:http://www.vim.org/scripts/script.php?script_id=2441
if has("gui_running")
   highlight SpellBad term=underline gui=undercurl guisp=Orange 
endif   

" pydoc
" Python documentation view- and search-tool (uses pydoc) 
" HomePage: http://www.vim.org/scripts/script.php?script_id=910
" :Pydoc foo.bar.baz (e.g. :Pydoc re.compile) 
" :PydocSearch foobar 
" under the cursor by pressing <leader>pW
let g:pydoc_cmd = "/usr/bin/pydoc" 
let g:pydoc_highlight = 0

" python_open_module : open the python module file below the cursor when
" coding python
nmap <leader>fd :set ff=dos<cr>
nmap oo :pom_key_open<cr>
nmap ow :pom_key_open_in_win<cr>
nmap ot :pom_key_open_in_tab<cr>

" python-support for vim
let g:python_author = g:author 
let g:python_contact = g:email
let g:python_license = g:license
let g:python_copyright = g:copyright


" ***************** Django ********************************
" REF: http://code.djangoproject.com/wiki/UsingVimWithDjango
"
" Django Projects : Allows you to use django management commands from within vim
" REF: http://www.vim.org/scripts/script.php?script_id=2392
"
" ***************** YAML **********************************
" yaml.vim : Syntax coloring and functions for YAML 
" REF: http://www.vim.org/scripts/script.php?script_id=739
if has("autocmd")
	autocmd BufNewFile,BufRead *.yaml,*.yml source ~/.vim/syntax/yaml.vim 
endif
" YAML Highlight script for VIM editor
" HomePage: http://github.com/trans/yaml_vim/tree/master
if has("autocmd")
	autocmd BufNewFile,BufRead *.yaml,*.yml source ~/.vim/scripts/yamlsort.vim 
endif

" reStructuredText 
if has("autocmd")
	autocmd BufNewFile,BufRead *.rst set tabstop=2
	autocmd BufNewFile,BufRead *.rst set softtabstop=2
	autocmd BufNewFile,BufRead *.rst set shiftwidth=2
	autocmd BufNewFile,BufRead *.rst set autoindent
	autocmd BufNewFile,BufRead *.rst set cindent
	autocmd BufNewFile,BufRead *.rst set expandtab
	autocmd BufNewFile,BufRead *.rst set smarttab
endif
" VST : Vim reStructured Text 
" HomePage: http://www.vim.org/scripts/script.php?script_id=1334
" VST is script which makes possible to export text files with simple markup
" to HTML or LaTeX format or S5 HTML presentation.

" rest.vim : A reStructuredText syntax mode 
if has("autocmd")
	autocmd BufNewFile,BufRead *.rst set syntax=rest
endif

" DotOutlineTree : Helps you edit structured text. 

" protocol buffer
"augroup filetype
"	 au! BufRead,BufNewFile *.proto setfiletype proto
"augroup end
if has("autocmd")
	autocmd BufNewFile,BufRead *.proto setfiletype proto 
endif


" ====================== Ruby ======================================
"  
" endwise.vim : Wisely add "end" in ruby, endfunction/endif/more in vim
" script, etc
" HomePage: http://www.vim.org/scripts/script.php?script_id=2386
"
" rails.vim : Ruby on Rails: easy file navigation, enhanced syntax
" highlighting, and more 
" HomePage: http://www.vim.org/scripts/script.php?script_id=1567
"
" railstab.vim : Retabbing hacks extracted from rails.vim 
" HomePage: http://www.vim.org/scripts/script.php?script_id=2253
let g:rails_tabstop = 4

" rubycomplete.vim : ruby omni-completion 
" HomePage: http://www.vim.org/scripts/script.php?script_id=1662

" ====================== HTML/XML ======================================
" closetag.vim : Functions and mappings to close open HTML/XML tags 
" HomePage: http://www.vim.org/scripts/script.php?script_id=1334
let g:closetag_html_style=1 
"source ~/.vim/scripts/closetag.vim 

" ***************** For json *******************************
au! BufRead,BufNewFile *.json setfiletype json

" haskell
" Configuring vim For Good Haskell Style
" HomePage: http://urchin.earth.li/~ian/style/vim.html
set expandtab
syn cluster hsRegions add=hsImport,hsLineComment,hsBlockComment,hsPragma
syn cluster hsRegions add=cPreCondit,cCppOut,cCppOut2,cCppSkip
syn cluster hsRegions add=cIncluded,cDefine,cPreProc,cComment,cCppString
syn match tab display "\t" containedin=@hsRegions
hi link tab Error
syn match trailingWhite display "[[:space:]]\+$" containedin=@hsRegions
hi link trailingWhite Error
" indent/haskell.vim : Haskell indent file 
" HomePage: http://www.vim.org/scripts/script.php?script_id=1968
let g:haskell_indent_if = 2
" Haskell  mode for Vim
" HomePage: http://projects.haskell.org/haskellmode-vim/
if has("autocmd")
	autocmd Bufenter *.hs compiler ghc
	let g:haddock_browser = "/home/wul/local/opt/firefox/firefox"
endif

" ***************** For GVim ********************************
" font
" you should make should the font is in your system, and you can use it
" format: set guifont=Font FontSize
"set guifont=Vera\ Sans\ YuanTi\ Mono\ 16
set guifont=Monaco\ 11
" set menu's language
" In here, you use zh_CN.UTF8, and you can setup by your locale
set langmenu=zh_CN.UTF-8
" menu's scheme
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" do some for gvim's menu
" hide menu
" set guioptions-=m
" hide tool-bar
" set guioptions-=T
" set guioptions-=l
" set guioptions-=L
" set guioptions-=r
" set guioptions-=R
" highlight current line
if has("gui_running")
	if has("cursorline")
		set cursorline
		" color scheme
		" hi cursorline guibg=#333333
		" hi CursorColumn guibg=#333333
	endif
endif

" ******************IDE*********************
"
" BufExplorer
" ~/.vim/plugin/bufexplorer.vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=42
"source ~/.vim/plugin/bufexplorer.vim
"let g:bufExplorerDefaultHelp=0       " Do not show default help.
"|let g:bufExplorerShowRelativePath=1  " Show relative paths.
"let g:bufExplorerSortBy='mru'        " Sort by most recently used.
"let g:bufExplorerSplitRight=0        " Split left.
"let g:bufExplorerSplitVertical=1     " Split vertically.
"let g:bufExplorerSplitVertSize = 30  " Split width
"let g:bufExplorerUseCurrentWindow=1  " Open in new window.


" lookupfile
" HomePage: http://www.vim.org/scripts/script.php?script_id=1581
" ~/.vim/plugin/lookupfile.vim
" !~/.vim/autoload/lookupfile.vim
"source ~/.vim/plugin/lookupfile.vim
"let g:LookupFile_MinPatLength = 1
"let g:LookupFile_PreserveLastPattern = 0
"let g:LookupFile_PreservePatternHistory = 1
"let g:LookupFile_AlwaysAcceptFirst = 1
"let g:LookupFile_AllowNewFiles = 0
"if filereadable("./tags")
"	let g:LookupFile_TagExpr = '"./tags"'
"endif
"nmap <silent> <leader>lk <Plug>LookupFile<cr>
"nmap <silent> <leader>ll :LUBufs<cr>
"nmap <silent> <leader>lw :LUWalk<cr>
"" lookup file with ignore case
"function! LookupFile_IgnoreCaseFunc(pattern)
"    let _tags = &tags
"    try
"        let &tags = eval(g:LookupFile_TagExpr)
"        let newpattern = '\c' . a:pattern
"        let tags = taglist(newpattern)
"    catch
"        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
"        return ""
"    finally
"        let &tags = _tags
"    endtry
"    " Show the matches for what is typed so far.
"    let files = map(tags, 'v:val["filename"]')
"    return files
"endfunction
"let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'

" matchit.vim
" The matchit.vim script allows you to configure % to match more than just
" single characters.  You can match words and even regular expressions.
" ~/.vim/plugin/matchit.vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=39
"source ~/.vim/plugin/matchit.vim

" NERD_commenter.vim
" comment easily
" ~/.vim/plugin/NERD_commenter.vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=1218
source ~/.vim/plugin/NERD_commenter.vim

" NERD tree
" HomePage:	http://www.vim.org/scripts/script.php?script_id=1658
" ~/.vim/plugin/NERD_tree.vim
source ~/.vim/plugin/NERD_tree.vim
" nmap tree :NERDTree<cr>
nmap ls :NERDTreeToggle<cr>

" TagList
" ~/.vim/plugin/taglist.vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=273
source ~/.vim/plugin/taglist.vim
"let Tlist_Show_One_File=1
" order by
let Tlist_Sort_Type = "name"
" split to the right side of the screen
" let Tlist_Use_Right_Window = 1
" show small meny
let Tlist_Compart_Format = 1
" if you are the last, kill yourself
let Tlist_Exist_OnlyWindow = 1
" Do not close tags for other files
let Tlist_File_Fold_Auto_Close = 0
" Do not show folding tree
let Tlist_Enable_Fold_Column = 0
" open and close Tlist
"map <F7> :Tlist<cr>
let g:ctags_statusline=1

" snipMate : TextMate-style snippets for Vim 
" HomePage: http://www.vim.org/scripts/script.php?script_id=2540
" Ref: http://www.catonmat.net/blog/vim-plugins-snipmate-vim/
"

" surround.vim : Delete/change/add parentheses/quotes/XML-tags/much more with
" ease
" HomePage: http://www.vim.org/scripts/script.php?script_id=1697
" REF: http://www.catonmat.net/blog/vim-plugins-surround-vim/
" REF: http://www.forwind.cn/2008/12/20/vim-plugin-surround/
" Usage:
" Normal mode
" -----------
"  ds  - delete a surrounding
"  cs  - change a surrounding
"  ys  - add a surrounding
"  yS  - add a surrounding and place the surrounded text on a new line +
"  indent it
"  yss - add a surrounding to the whole line
"  ySs - add a surrounding to the whole line, place it on a new line + indent
"  it
"  ySS - same as ySs
"
"  Visual mode
"  -----------
"  s   - in visual mode, add a surrounding
"  S   - in visual mode, add a surrounding but place text on new line + indent
"  it
"
"  Insert mode
"  -----------
"  <CTRL-s> - in insert mode, add a surrounding
"  <CTRL-s><CTRL-s> - in insert mode, add a new line + surrounding + indent
"  <CTRL-g>s - same as <CTRL-s>
"  <CTRL-g>S - same as <CTRL-s><CTRL-s>
"

" repeat.vim
" HomePage: http://www.vim.org/scripts/script.php?script_id=2136
" REF: http://www.catonmat.net/blog/vim-plugins-repeat-vim/
"
" speeddating.vim : Use CTRL-A/X to increment dates, times, and more 
" HomePage: http://www.vim.org/scripts/script.php?script_id=2120
"
"
" Txtfmt (The Vim Highlighter) : Highlight plain text in Vim! (Beautify your
" documents with colors and formats.) 
" HomePage: http://www.vim.org/scripts/script.php?script_id=2208
"au! filetypedetect BufRead,BufNewFile *.txt    setfiletype txtfmt 

"autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
"autocmd FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None

let g:ropevim_loaded = 1

let g:pydiction_location="~/.vim/templates/complete-dict"
"let g:neocomplcache_enable_at_startup = 1
"
let g:pymode = 1
"保存文件时自动删除无用空格
let g:pymode_trim_whitespaces = 0
let g:pymode_lint = 1
let g:pymode_lint_on_write = 0
"let g:pymode_lint_on_fly = 1
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pylint']
let g:pymode_lint_options_pylint = {"rcfile":"~/.pylint.rc"}

let g:pymode_rope = 1
"let g:pymode_rope_goto_definition_bind = '<F1>'
"let g:pymode_rope_goto_definition_cmd = 'new'
autocmd FileType python map <buffer> <F3> :PymodeLint<CR>
"let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime','/home/zhoujb/Algorithm','/home/zhoujb/backends','/home/zhoujb/comm_lib','/home/zhoujb/Webpage']
"let g:pymode_rope_completion = 1
"let g:pymode_rope_complete_on_dot = 1
"let g:pymode_rope_autoimport = 1
"let g:pymode_rope_completion_bind = '<F4>'
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<F2>'
let g:pymode_rope_completion = 1
let g:pymode_options_max_line_length = 1079

" ctags
map <F8> :!cd ~ && ctags -R --languages=python,c++,java --python-kinds=-i .<CR>
set tags+=~/tags
"map <C-j> :tnext <CR> 

autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif

" pyflakes
" python语法检查
"filetype plugin indent on 
"autocmd FileType python nnoremap <buffer> <F7> :w<CR>:!pyflakes % <CR>

"自动补全括号
"autocmd FileType python,c,cpp inoremap ' ''<ESC>i
"autocmd FileType python,c,cpp inoremap " ""<ESC>i
"autocmd FileType python,c,cpp inoremap ( ()<ESC>i
"autocmd FileType python,c,cpp inoremap ) <tab>=ClosePair(')')<CR>
"autocmd FileType python,c,cpp inoremap [ []<ESC>i
"autocmd FileType python,c,cpp inoremap ] <c-r>=ClosePair(']')<CR> 
"autocmd FileType python,c,cpp inoremap { {}<ESC>i
"autocmd FileType python,c,cpp inoremap } <c-r>=ClosePair('}')<CR> 
function! ClosePair(char) 
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
"设置跳出自动补全的括号
func SkipPair()
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
        return "\<ESC>la"
    else
        return "\t"
    endif
endfunc
" 将tab键绑定为跳出括号
inoremap <tab> <c-r>=SkipPair()<CR>

"高亮一列
:hi ColorColumn ctermbg=lightgreen
autocmd FileType python,c,cpp set cc=131

"indentLine
"let g:indentLine_enabled = 1
let g:indentLine_char = '¦'
let g:indentLine_first_char = '¦'
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
""let g:indentLine_color_tty_light = 7
""let g:indentLine_color_dark = 1

"不自动折行
set nowrap

" 删除行尾空格
map <F4> <ESC>:%s/\s\+$//g <CR>

" 插入模式跳出括号
"inoremap <C-9> <ESC><s-a>
