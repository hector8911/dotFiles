if !exists('g:vscode')

call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'sickill/vim-monokai'
call plug#end()

let g:coc_global_extensions = ['coc-prettier', 'coc-explorer', 'coc-json', 'coc-html', 'coc-tsserver', 'coc-yaml', 'coc-phpls']
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_z = airline#section#create(['%l', '/', '%L'])
let g:airline_theme='minimal'
let mapleader = "\ "

syntax on
set encoding=utf-8
set laststatus=2
set number relativenumber
set noshowmode
set termguicolors
set hidden
set showmatch
set sw=4
set clipboard=unnamedplus
colorscheme monokai

"indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set foldmethod=indent
set nofoldenable
set foldlevel=1

"No backups
set nobackup
set nowritebackup
set nowb
set noswapfile

nnoremap <silent> <leader>d :bd <CR>
nmap <silent> <M-l> :bnext <CR>
nmap <silent> <M-h> :bprevious <CR>
nnoremap <silent> <leader>q :q <CR>
nnoremap <silent> <leader>w :w <CR>

nnoremap <silent> <leader>e :CocCommand explorer<CR>
nnoremap <silent> <leader>p :CocCommand prettier.formatFile <CR>
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

endif
