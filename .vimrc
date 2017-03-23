	"*******"
	"__VIM__"
	"*******"

"initialize pathogen

execute pathogen#infect()
execute pathogen#helptags()


"dependencies

call plug#begin('~/.vim/bundle')
"general
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'dkprice/vim-easygrep'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
"syntax
Plug 'pangloss/vim-javascript'
Plug 'elixir-lang/vim-elixir'
Plug 'jmcantrell/vim-virtualenv'
Plug 'klen/python-mode'
"snippets
Plug 'slashmili/alchemist.vim'
Plug 'valloric/youcompleteme'
Plug 'SirVer/ultisnips' " snippet engine
Plug 'honza/vim-snippets'
Plug 'isRuslan/vim-es6'
Plug 'bentayloruk/vim-react-es6-snippets'
"syntax
Plug 'lepture/vim-jinja'
Plug 'elzr/vim-json'
"colours
Plug 'roosta/srcery'
Plug 'aereal/vim-colors-japanesque'
Plug 'nanotech/jellybeans.vim'
call plug#end()


"global settings

set number
set timeoutlen=250
scriptencoding utf-8
set shiftwidth=2
set tabstop=2
filetype off
filetype plugin indent on
filetype indent on

let mapleader = ";"
let maplocalleader = "-"

autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

"default colour scheme
colorscheme srcery "default colour scheme

"quick buffers
nnoremap `1 "A
nnoremap `2 "B
nnoremap `3 "C
nnoremap `4 "D

"swap visual modes
nnoremap v <c-v>
nnoremap <c-v> v

"time stamp
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

"status bar styling
set fillchars-=vert:\|

"edit vimrc map
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

"editing map
nnoremap 11 I# <esc>

"easier escape
inoremap kj <C-[>
vnoremap kj <C-[>
inoremap KJ <C-[>
vnoremap KJ <C-[>

"Tab Movements
nnoremap <Right> gt
nnoremap <Left> gT
inoremap <Right> gt
inoremap <Left> gT

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


"GUI settings
	
set guioptions-=r "Remove Right scroll bar"
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h13
set guioptions-=R "?"
set guioptions-=L

if has('gui_running')
	set fillchars+=stl:\ ,stlnc:\ "
	let spr="\ue0b0"
	let sbspr="\ue0b1"
	highlight Pmenu guibg=#cccccc gui=bold    
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
  "Status Bar Styling"
  set fillchars-=vert:\|
	set fillchars+=stl:\ ,stlnc:\
	let spr=""
	let sbspr="|"
endif


"python settings

autocmd FileType python setlocal shiftwidth=4 tabstop=4
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_options_colorcolumn = 0
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0


"virtual env settings
let g:virtualenv_directory="~/.virtualenvs/"


"web dev settings

autocmd FileType javascript setlocal foldmethod=syntax
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2


"nerd tree settings 

map <leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup=0
let g:NERDTreeWinPos = "left"
let g:NERDTreeIgnore = ['\.pyc$']


"lightline settings

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


"snippet settings

let g:SuperTabDefaultCompletionType    = '<c-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<c-j>', '<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-k>', '<c-p>', '<Up>']


	"*******"
	"__END__"
	"*******"
