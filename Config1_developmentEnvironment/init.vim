set relativenumber
set number
set nowrap
syntax on
filetype indent on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set scrolloff=5
let g:UltiSnipsExpandTrigger="<F4>"


" nerdtree settings if you want to enable them
let NERDTreeShowHidden=1
colorscheme gruvbox
set background=dark
"
"
call plug#begin()
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
call plug#end()
