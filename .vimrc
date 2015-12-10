	"__ViM_Startup_Configuration_File__"
		"Thu Dec 10 11:09:05 2015"
		

	"__Initialize_Pathogen__"

execute pathogen#infect()
execute pathogen#helptags()


	"__General_Settings__"

set encoding=utf-8
scriptencoding utf-8
set number
set numberwidth=1
set modifiable
let mapleader = ";"
let maplocalleader = "-"
filetype off
set autoindent
nnoremap <Esc><Esc> :w<CR>
syntax on
set shiftwidth=4
set tabstop=4
filetype plugin indent on
filetype indent on


	"__GUI_Settings__"
	
set guioptions-=r "Remove Right scroll bar"
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h13
set guioptions-=R "?"
set guioptions-=L

if has('gui_running')
	set fillchars+=stl:\ ,stlnc:\ "
	let spr="\ue0b0"
	let sbspr="\ue0b1"
else
	set fillchars+=stl:\ ,stlnc:\
	let spr=""
	let sbspr="|"
endif


	"__Misc_Settings__"

let g:netrw_liststyle=3 "?"
"Quick Registers"
nnoremap `1 "A
nnoremap `2 "B
nnoremap `3 "C
nnoremap `4 "D
"Swap Visual Modes"
nnoremap <C-v> v
nnoremap v <C-v>
"Time Stamp"
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>"
"Custom Stylez"
set fillchars-=vert:\|
colorscheme murphy
"Edit VimRC map"
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
"Editing Maps"
nnoremap 11 c$
"Easier Escape"
inoremap kj <C-[>
vnoremap kj <C-[>


	"__Nerd_Tree__"

map <leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup=0
let g:NERDTreeWinPos = "left"


	"__Movement_&_Window_Maps__"
	
nnoremap 8 6j
nnoremap 9 6k
"Tab Movements
nnoremap <Right> gt
nnoremap <Left> gT
inoremap <Right> gt
inoremap <Left> gT
"Line Spaces
nnoremap <leader>k O<Esc>j
inoremap <leader>k O<Esc>j
nnoremap <leader>j o<Esc>k
inoremap <leader>j o<Esc>k
"Window Movement Mappings
nnoremap ˙ <C-w>h 
nnoremap ∆ <C-w>j 
nnoremap ˚ <C-w>k 
nnoremap ¬ <C-w>l
"Line Movement Mappings"
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


	"__Python_Settings__"

let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_options_colorcolumn = 0
let g:pymode_rope = 0
"Virtual Env
let g:virtualenv_directory="~/workspace"
abbreviate pypath # !usr/bin/python
abbreviate pycode # -*- coding: utf-8 -*-

if has ('gui_running')
	highlight Pmenu guibg=#cccccc gui=bold    
endif


	"__LightLine_Things__"

set laststatus=2
let g:lightline = {
	\ 'active': {
	\ 	'left': [ [ 'mode', 'paste' ],
	\  		        [ 'fugitive', 'filename' ] ]
	\ },
	\ 'component_function': {
	\   'fugitive': 'LightLineFugitive',
	\   'readonly': 'LightLineReadonly',
	\   'modified': 'LightLineModified',
	\   'filename': 'LightLineFilename'
	\ },
	\ 'separator': { 'left': spr, 'right': ""  },
	\ 'subseparator': { 'left': sbspr, 'right': "|"  },
	\ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "\ue0a2"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? "\ue0a0 "._ : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

	"__END__"
