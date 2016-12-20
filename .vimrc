  "**********************************"
  "**********************************"
	"__ViM_Startup_Configuration_File__"
      "Tue Jan  5 14:36:22 2016"
      "************************"
       "**********************"
        "********************"
         "******************"
          "****************"
           "**************"
            "************"
             "**********"
              "********"
               "******"
                "****"
                 "**"
		

	"__Initialize_Pathogen__"


execute pathogen#infect()
execute pathogen#helptags()


	"__Install_Plugins__"


call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
Plug 'elixir-lang/vim-elixir'
Plug 'pangloss/vim-javascript'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'dkprice/vim-easygrep'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'jmcantrell/vim-virtualenv'
Plug 'klen/python-mode'
Plug 'janko-m/vim-test'

" Snippets
Plug 'valloric/youcompleteme'
Plug 'SirVer/ultisnips' " snippet engine
Plug 'honza/vim-snippets'
Plug 'isRuslan/vim-es6'
Plug 'bentayloruk/vim-react-es6-snippets'

" Syntax
Plug 'lambdatoast/elm.vim'
Plug 'lepture/vim-jinja'
Plug 'elzr/vim-json'

" Colours
Plug 'roosta/srcery'
Plug 'aereal/vim-colors-japanesque'
Plug 'nanotech/jellybeans.vim'

call plug#end()


	"__General_Settings__"


syntax on
set timeoutlen=250
set encoding=utf-8
scriptencoding utf-8
set number
set numberwidth=1
set modifiable
set autoindent
set tabstop=2 shiftwidth=2 expandtab
filetype off
filetype plugin indent on
filetype indent on

let mapleader = ";"
let maplocalleader = "-"
nnoremap <Esc><Esc> :w<CR>
nnoremap <f1> :tabclose<cr>

" default colour scheme
colorscheme srcery
" colorscheme industry

" ???? TODO: figure out why i need this
let g:netrw_liststyle=3 "?"

"Quick Registers"
nnoremap `1 "A
nnoremap `2 "B
nnoremap `3 "C
nnoremap `4 "D

"Swap Visual Modes"
nnoremap v <c-v>
nnoremap <c-v> v

"Repeat Previous Command
nnoremap - @:

"Time Stamp"
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

"Status Bar Styling"
set fillchars-=vert:\|

"Edit VimRC map"
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

"Editing Maps"
nnoremap 11 I# <esc>

"Easier Escape"
inoremap kj <C-[>
vnoremap kj <C-[>
inoremap KJ <C-[>
vnoremap KJ <C-[>

"Close all tabs
nnoremap <c-=> <esc>:tabclose
inoremap <c-=> <esc>:tabclose
vnoremap <c-=> <esc>:tabclose
"
"Leaping
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


	"__Python_Settings__"


autocmd FileType python setlocal shiftwidth=4 tabstop=4

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


	"__FrontEnd_Settings__"


set foldmethod=syntax
let g:javascript_plugin_jsdoc = 1
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2

	"__Nerd_Tree_Settings_"


map <leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup=0
let g:NERDTreeWinPos = "left"
let g:NERDTreeIgnore = ['\.pyc$']


	"__LightLine_Settings__"


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


	"__Snippet_Settings__"


let g:SuperTabDefaultCompletionType    = '<c-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<c-j>', '<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-k>', '<c-p>', '<Up>']


	"__Testing_Mappings__"


let test#strategy = "iterm"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>


	"*******"
	"__END__"
	"*******"
