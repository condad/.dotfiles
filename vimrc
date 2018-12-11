  "*******"
  "__VIM__"
  "*******"

"initialize pathogen

execute pathogen#infect()
execute pathogen#helptags()


"dependencies

call plug#begin('~/.vim/bundle')
"funtionality
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'dkprice/vim-easygrep'
Plug 'jiangmiao/auto-pairs'
"syntax
Plug 'dag/vim-fish'
Plug 'mattn/emmet-vim'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-liquid'
Plug 'pangloss/vim-javascript'
Plug 'elixir-lang/vim-elixir'
Plug 'lepture/vim-jinja'
Plug 'elzr/vim-json'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
"completion
Plug 'SirVer/ultisnips'
Plug 'valloric/youcompleteme'
Plug 'slashmili/alchemist.vim'
Plug 'isRuslan/vim-es6'
Plug 'bentayloruk/vim-react-es6-snippets'
Plug 'honza/vim-snippets'
Plug 'mxw/vim-jsx'
" formatters
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tell-k/vim-autopep8'
"colour schemes
Plug 'roosta/srcery'
Plug 'aereal/vim-colors-japanesque'
Plug 'nanotech/jellybeans.vim'
call plug#end()


"global settings

scriptencoding utf-8

set mouse=a

set timeoutlen=250
set textwidth=120

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent

"folding
set foldmethod=indent
set foldnestmax=2

filetype off
filetype plugin indent on
filetype indent on

let mapleader = ";"
let maplocalleader = "-"

"default colour scheme
colorscheme srcery "default colour scheme

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
nnoremap <c-i> :m .-2<CR>==
nnoremap <c-u> :m .+1<CR>==
inoremap <c-u> <Esc>:m .+1<CR>==gi
inoremap <c-i> <Esc>:m .-2<CR>==gi
vnoremap <c-u> :m '>+1<CR>gv=gv
vnoremap <c-i> :m '<-2<CR>gv=gv


"GUI settings
  
set guioptions-=r "Remove Right scroll bar"
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h13
set guioptions-=R "?"
set guioptions-=L

if has('gui_running')
  "status bar w/ gui
  set fillchars+=stl:\ ,stlnc:\ "
  let spr="\ue0b0"
  let sbspr="\ue0b1"
  highlight Pmenu guibg=#cccccc gui=bold    

  "window maps for with
  nnoremap <d-j> 4j
  nnoremap <d-k> 4k
  vnoremap <d-j> 4j
  vnoremap <d-k> 4k
  nnoremap <d-8> 10j
  nnoremap <d-9> 10k
  vnoremap <d-8> 10j
  vnoremap <d-9> 10k
else
  "status bar wo/ gui
  set fillchars-=vert:\|
  set fillchars+=stl:\ ,stlnc:\
  let spr=""
  let sbspr="|"
endif


"plugin settings


"virtual env settings
let g:virtualenv_directory="~/.virtualenvs/"


"syntastic settings

let g:syntastic_error_symbol = "EE"
let g:syntastic_style_error_symbol = "ee"
let g:syntastic_warning_symbol = "WW"
let g:syntastic_style_warning_symbol = "ww"


" formatter settings
" prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
" autopep8
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff = 1

"nerd tree settings 

map <leader>n :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "left"
let g:NERDTreeIgnore = ['\.pyc$']


"nerd commenter settings
let NERDSpaceDelims=1


"lightline settings

set laststatus=2
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'filename' ] ]
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

let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'


  "*******"
  "__END__"
  "*******"
