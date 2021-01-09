
call plug#begin('~/.config/nvim/plugged')
Plug 'kevinhwang91/rnvimr'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'OmniSharp/omnisharp-vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'NLKNguyen/papercolor-theme'
call plug#end()

let g:coc_global_extensions = ['coc-prettier', 'coc-json', 'coc-html', 'coc-tsserver', 'coc-yaml', 'coc-phpls']
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_z = airline#section#create(['%l', '/', '%L'])
let g:airline_theme='minimal'
let mapleader = "\ "

syntax on
set encoding=utf-8
set laststatus=2
set number relativenumber
set termguicolors
set hidden
set showmatch
set sw=4
set clipboard=unnamedplus
colorscheme PaperColor
"set tabstop=4

set foldmethod=manual
"set foldmethod=indent
set foldnestmax=2
set nofoldenable
set foldlevel=2

"No backups
set nobackup
set nowritebackup
set nowb
set noswapfile

nnoremap <silent> <leader>d :bd <CR>
nmap <silent> <C-Right> :bnext <CR>
nmap <silent> <C-Left> :bprevious <CR>
nnoremap <silent> <leader>q :q <CR>
nnoremap <silent> <leader>w :w <CR>

nnoremap <silent> <leader>p :CocCommand prettier.formatFile <CR>
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)

nnoremap <silent> <leader>e :RnvimrToggle<CR>
let g:rnvimr_enable_ex = 1
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
let g:rnvimr_enable_picker = 1
let g:rnvimr_border_attr = {'fg': 10, 'bg': -1}
let g:rnvimr_ranger_views = [
            \ {'minwidth': 90, 'ratio': []},
            \ {'minwidth': 50, 'maxwidth': 89, 'ratio': [1,1]},
            \ {'maxwidth': 49, 'ratio': [1]}
            \ ]
