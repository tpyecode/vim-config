" --- BASIC SETTINGS ---
set nocompatible
set number            " show line numbers
set tabstop=4        " show tabs as 4 spaces wide
set shiftwidth=4      " use 4 spaces when indenting
set expandtab         " convert tabs to spaces
set autoindent        " keep indent from previous line
set smartindent       " auto-indent new line
set cindent           " C/C++ aware indentation rules
set cinoptions=:0,g0,(0,w1 " indentation rules for braces/labels
set cinoptions+=h1
set cinoptions+=N
set indentkeys+=0{               " trigger indent on '{'
set autoread
set shellcmdflag=-lc
set shellcmdflag=-lc


autocmd FocusGained,BufEnter,CursorHold * checktime
" Use 4 spaces for C and C++ files
autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType java setlocal tabstop=4 shiftwidth=4 expandtab


vnoremap <C-c> :w !wl-copy<CR><CR>
nnoremap <C-p> :r !wl-paste<CR><CR>

vnoremap <C-c> :w !xclip -selection clipboard<CR><CR>
nnoremap <C-p> :r !xclip -selection clipboard -o<CR><CR>


nnoremap <leader>m :w<CR>:!g++ -std=c++17 % -o %:r && ./%:r<CR>
autocmd BufWritePre *.cpp,*.h,*.hpp,*.cc :silent! execute '!clang-format -i %'
autocmd BufNewFile,BufRead *.cpp,*.hpp,*.cc setlocal filetype=cpp

let g:coc_diagnostic_virtual_text = 0
let g:ale_virtualtext = 0
let g:ale_enabled = 0

" --- FILETYPE-SPECIFIC INDENTATION ---
filetype plugin indent on
syntax on

 
" --- BRACE BLOCK MAPPING ---
" Type { then Enter → auto insert closing brace and indent cursor inside
" If cursor is between {} then expand into block, else normal Enter
augroup MyEnterMapping
  autocmd!
  autocmd VimEnter * inoremap <expr> <CR> (col('.') > 1 && getline('.')[col('.')-2] == '{' && getline('.')[col('.')-1] == '}')
        \ ? "\<CR>\<Esc>O"
        \ : (coc#pum#visible() ? coc#pum#confirm() : "\<CR>")
augroup END
" --- CURSOR SHAPE ---
let &t_SI = "\e[6 q"   " Insert mode: steady vertical bar
let &t_EI = "\e[2 q"   " Normal mode: steady block

" --- CLIPBOARD YANKS ---
nnoremap Y "+yy
vnoremap y "+y
nnoremap y "+y
nnoremap <leader>r :w<CR>:!cargo run<CR>
nnoremap <leader>b :w<CR>:!cargo build<CR>


" --- COC POPUP BEHAVIOR ---
" Enter confirms completion if popup visible, otherwise newline
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" --- PLUGIN MANAGER (vim-plug) ---
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-java'
Plug 'landersson/vim-blueberry' " Optional: class/function outline
Plug 'ghifarit53/tokyonight-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'

call plug#end()

nnoremap <leader>e :NERDTreeToggle<CR>


set laststatus=2
set noshowmode

let g:lightline = {
  \ 'colorscheme': 'default',
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ }
  \ }

" Disable Lightline in NERDTree
autocmd FileType nerdtree let g:lightline = { 'active': { 'left': [ [] ] } }



" --- RUST ANALYZER CONFIG ---
let g:coc_global_extensions = [
  \ 'coc-java'
  \ ]

let g:NERDTreeWinPos = "right"

" --- THEME ---
set termguicolors
"colorscheme blueberry
colorscheme tokyonight
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

" --- COMPLETION UX ---
set completeopt=menu,menuone,noselect
set shortmess+=c
