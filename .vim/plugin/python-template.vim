"
" The script will add python header template
" Shortcuts:
" - pyclass : add docstring for class
" - pyfunc  : add docstring for function/method


" *************** Template *******************************
"
" Header Template
if has("autocmd")
	" autoload pyheader.template
	autocmd BufNewFile *.py 0r ~/.vim/templates/pyheader.template
endif

" Basic info for header template
let s:python_author = ""
let s:python_contact = ""
let s:python_license = ""
let s:python_copyright = ""
" author
" PyAuthor()
function! PyAuthor()
	let row = search('@author:', 'n')
	if (row != 0)
		call setline (row, '@author: ' . g:python_author)
	endif
endfunction
"  contact
"  PyContact()
function! PyContact()
	let row = search('@contact:', 'n')
	if (row != 0)
		call setline (row, '@contact: '.  g:python_contact)
	endif
endfunction
" date
" PyDate()
" current date
function! PyDate()
    let row = search('@date:', 'n')
    if (row != 0)
        call setline (row, '@date: ' .  strftime('%Y-%m-%d %H:%M'))
	endif
endfunction
" license
" PyLicense()
function! PyLicense()
	let row = search('@license:', 'n')
	if (row != 0)
		call setline(row, '@license: ' . g:python_license)
	endif
endfunction
" copyright
" PyCopyright
function! PyCopyright()
	let row = search('@copyright:', 'n')
	if (row != 0)
		call setline(row, '@copyright: ' . g:python_copyright)
	endif
endfunction

" do insert basic info
if has("autocmd")
	autocmd BufNewFile *.py call PyAuthor()
	autocmd BufNewFile *.py call PyContact()
	autocmd BufNewFile *.py call PyDate()
	autocmd BufNewFile *.py call PyLicense()
	autocmd BufNewFile *.py call PyCopyright()
endif

let s:py_template_path = ".vim/templates/"
let s:py_template_tmp_path = ".vim/templates/tmp"
let s:pyclass_docstring_template = "pyclass.docstring.template"
let s:pyfunction_docstring_template = "pyfunction.docstring.template"

" add doctring after class/funtion
" Bug:
" - How to detect current line and column?
" - How to detect python type (filetype python is invalid)

function! g:InsertPyDocString(pydocstring_template)
python << EOF
import os
import shutil
import vim
def GetRowCol():
	current_window = vim.current.window
	(current_row, current_col) = current_window.cursor
	current_row += 1
	vim.current.window.cursor = (current_row, current_col)
	current_window = vim.current.window
	(current_row, current_col) = current_window.cursor
	current_line = vim.current.line
	current_col = len(str(current_line)) - len(str(current_line).lstrip(" "))
	current_row -= 1
	vim.current.window.cursor = (current_row, current_col)
	current_window = vim.current.window
	(current_row, current_col) = current_window.cursor
	return (current_row, current_col)

(current_row, current_col) = GetRowCol() 
user_home_path = os.getenv("HOME")
vim_template_tmp_dir = os.path.join(user_home_path, vim.eval('s:py_template_tmp_path'))
# clean vim_template_tmp_dir
if os.path.exists(vim_template_tmp_dir):
	shutil.rmtree(vim_template_tmp_dir)
os.makedirs(vim_template_tmp_dir)
# ~/.vim/templates/pyfunction.docstring.template
pydocstring_template_path = os.path.join(user_home_path, os.path.join(vim.eval('s:py_template_path'), vim.eval('a:pydocstring_template')))
# ~/.vim/templates/tmp/pyfunction.docstring.template
pydocstring_template_tmp_path = os.path.join(user_home_path, os.path.join(vim.eval('s:py_template_tmp_path'), vim.eval('a:pydocstring_template')))
# read file to a list
template_filelines= [_template_file_line.rstrip(os.linesep) for _template_file_line in list(open(pydocstring_template_path))]
pydocstring_template_tmp_file_instance = open(pydocstring_template_tmp_path, "w")
for _template_file_line in template_filelines:
	new_template_file_line = ""
	for x in range(0, current_col):
		new_template_file_line += " "
	new_template_file_line += _template_file_line
	pydocstring_template_tmp_file_instance.write(new_template_file_line.__add__(os.linesep))
pydocstring_template_tmp_file_instance.close()
vim.command("r " + pydocstring_template_tmp_path)
EOF
endfunction

" Class
function! g:InsertPyClassDocString()
	call g:InsertPyDocString(s:pyclass_docstring_template)
endfunction

" Function
function! g:InsertPyFunctionDocString()
	call g:InsertPyDocString(s:pyfunction_docstring_template)
endfunction

" map some shortcuts for above functions
if has("autocmd")
	autocmd filetype python nmap <leader>pyc :call g:InsertPyClassDocString()<CR>
	autocmd filetype python nmap <leader>pyf :call g:InsertPyFunctionDocString()<cr>
endif
