	"__ViM_Startup_Configuration_File__"
		"Tue Jan  5 14:36:22 2016"
		
	"__Initialize_Pathogen__"

execute pathogen#infect()
execute pathogen#helptags()

	"__Install_Plugins__"

call plug#begin('~/.vim/bundle')
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'dkprice/vim-easygrep'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'klen/python-mode'
Plug 'SirVer/ultisnips'
Plug 'isRuslan/vim-es6'
call plug#end()

	"__General_Settings__"

set timeoutlen=250
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
nnoremap <f1> :tabclose<cr>
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
	"Additional Window Maps
	nnoremap <d-j> 4j
	nnoremap <d-k> 4k
	vnoremap <d-j> 4j
	vnoremap <d-k> 4k
	nnoremap <d-8> 10j
	nnoremap <d-9> 10k
	vnoremap <d-8> 10j
	vnoremap <d-9> 10k
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
nnoremap v <c-v>
nnoremap <c-v> v

"Time Stamp"
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>
"Custom Stylez"
set fillchars-=vert:\|
colorscheme jellybeans
"Edit VimRC map"
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
"Editing Maps"
nnoremap 11 I# <esc>
"Easier Escape"
inoremap kj <C-[>
vnoremap kj <C-[>
"Close all tabs
nnoremap <c-=> <esc>:tabclose
inoremap <c-=> <esc>:tabclose
vnoremap <c-=> <esc>:tabclose


	"__Nerd_Tree__"

map <leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup=0
let g:NERDTreeWinPos = "left"


	"__Movement_&_Window_Maps__"
	
nnoremap 8 7j
nnoremap 9 7k
vnoremap 8 7j
vnoremap 9 7k
"Tab Movements
nnoremap <Right> gt
nnoremap <Left> gT
inoremap <Right> gt
inoremap <Left> gT
nnoremap <c-l> gt
nnoremap <c-h> gT
inoremap <c-l> gt
inoremap <c-h> gT
"Indent Movements
nnoremap > >>
vnoremap > >><esc>gv
nnoremap < <<
vnoremap < <<<esc>gv
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
"Virtual Env
let g:virtualenv_directory="~/.virtualenvs/"
"Python File Headers
abbreviate pypath # !usr/bin/python
abbreviate pycode # -*- coding: utf-8 -*-

if has ('gui_running')
	highlight Pmenu guibg=#cccccc gui=bold    
else
	let g:pymode_rope = 0
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
