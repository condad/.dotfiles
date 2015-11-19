"ViM Startup Configuration File
"Connor Sullivan
"Thu 22 Oct 13:53:12 2015"

"Initialize Pathogen
execute pathogen#infect()
execute pathogen#helptags()

"Configure RVim
set nocompatible
set shiftwidth=4
set tabstop=4
syntax enable
filetype plugin indent on
filetype indent on

"Just a Few General Settings
set number
set numberwidth=1
set modifiable
let mapleader = ";"
let maplocalleader = "-"

filetype off
set autoindent
nnoremap <Esc><Esc> :w<CR>
syntax on

"Quick Registers
nnoremap `1 "A
nnoremap `2 "B
nnoremap `3 "C
nnoremap `4 "D

"Swap Visual Modes
nnoremap <C-v> v
nnoremap v <C-v>

"Time Stamp
:nnoremap time "=strftime("%c")<CR>p 

"Custom Stylez
set fillchars-=vert:\|
colorscheme murphy


"Edit VimRC map
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

"Line Movement Mappings
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

"Editing Maps
nnoremap 11 c$

"Easier Escape
inoremap kj <C-[>
vnoremap kj <C-[>


"remove scroll bars
set guioptions-=R
set guioptions-=L

"explorer settings
let g:netrw_liststyle=3

"initialize nerdtree
nnoremap <leader>n :NERDTreeToggle ~/workspace<cr>
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden = 1
set modifiable


"movement maps
nnoremap 8 4j
nnoremap 9 4k

nnoremap <Right> gt
nnoremap <Left> gT
inoremap <Right> gt
inoremap <Left> gT

"change window
nnoremap <leader>k O<Esc>j
inoremap <leader>k O<Esc>j
nnoremap <leader>j o<Esc>k
inoremap <leader>j o<Esc>k

"window movements
nnoremap ˙ <C-w>h 
nnoremap ∆ <C-w>j 
nnoremap ˚ <C-w>k 
nnoremap ¬ <C-w>l

"python things
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_options_colorcolumn = 0
let g:pymode_rope = 0

abbreviate pypath # !usr/bin/python
abbreviate pycode # -*- coding: utf-8 -*-

if has ('gui_running')
	highlight Pmenu guibg=#cccccc gui=bold    
endif

"configure cursor"
autocmd InsertEnter,InsertLeave * set cul!



