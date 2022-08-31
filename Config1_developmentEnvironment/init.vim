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
Plug 'OmniSharp/omnisharp-vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/async.vim'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
call plug#end()

let g:OmniSharp_server_use_net6 = 1
" use to OmniSharpInstall to install omnisharp servers
