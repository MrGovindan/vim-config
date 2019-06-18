set nocompatible

"""""""""""""""""""
" PLUGGIN MANAGER "
"""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" LOOK AND FEEL
"""""""""""""""
Plug 'cocopon/iceberg.vim'
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'tomasiser/vim-code-dark'

" UTILITIES
"""""""""""
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'embear/vim-localvimrc'
Plug 'ervandew/supertab'
Plug 'raimondi/delimitmate'
Plug 'sbdchd/neoformat'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'vhdirk/vim-cmake'

" AUTOCOMPLETE "
""""""""""""""""
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

" LINTING "
"""""""""""
Plug 'w0rp/ale'

call plug#end()

"""""""""""
" GENERAL "
"""""""""""
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set clipboard+=unnamedplus

""""""""""""
" MAPPINGS "
""""""""""""
" Quick Save
""""""""""""
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Nerdtree
""""""""""
map <C-n> :NERDTreeToggle<CR>

" Tab Navigation
""""""""""""""""
nnoremap <C-h> :tabp<CR>
nnoremap <C-l> :tabn<CR>

" CtrlP
"""""""
let g:ctrlp_map = '<c-p>'

" Neosnippet
""""""""""""
imap <C-l> <Plug>(neosnippet_expand_or_jump)
smap <C-l> <Plug>(neosnippet_expand_or_jump)
xmap <C-l> <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2
  set concealcursor=niv
endif

let g:neosnippet#enable_completed_snippet = 1

"""""""""""""""""
" LOOK AND FEEL "
"""""""""""""""""
syntax on
set termguicolors
colorscheme base16-tomorrow-night

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

set number
set colorcolumn=100

""""""""""""""
" Localvimrc "
""""""""""""""
let g:localvimrc_sandbox=0
let g:localvimrc_whitelist=['.config/nvim/cpp/']

""""""""""""""""
" AUTOCOMPLETE "
""""""""""""""""
" deoplete
""""""""""
let g:deoplete#enable_at_startup = 1

set hidden

let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ }

let g:LanguageClient_loadSettings = 1

nn <silent> <C-]> :call LanguageClient#textDocument_definition()<cr>
nn <silent> <F12> :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<cr>
nn <silent> <C-k><C-i> :call LanguageClient#textDocument_hover()<cr>
nn <silent> <C-k><C-r> :call LanguageClient#textDocument_rename()<cr>

"augroup LanguageClient_config
"  au!
"  au BufEnter * let b:Plugin_LanguageClient_started = 0
"  au User LanguageClientStopped setl signcolumn=auto
"  au User LanguageClientStopped set b:Plugin_LanguageClient_started = 0
"  au User LanguageClientStopped echom "STOPPED"
"  au User LanguageClientStarted setl signcolumn=yes
"  au User LanguageClientStarted set b:Plugin_LanguageClient_started = 1
"  au User LanguageClientStarted echom "STARTED"
"  au CursorMoved * if b:Plugin_LanguageClient_started | sil call LanguageClient#textDocument_documentHighlight() | endif
"augroup END

" nn <silent> xh :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'L'})<cr>
" nn <silent> xj :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'D'})<cr>
" nn <silent> xk :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'U'})<cr>
" nn <silent> xl :call LanguageClient#findLocations({'method':'$ccls/navigate','direction':'R'})<cr>
"
" " bases
" nn <silent> xb :call LanguageClient#findLocations({'method':'$ccls/inheritance'})<cr>
" " bases of up to 3 levels
" nn <silent> xB :call LanguageClient#findLocations({'method':'$ccls/inheritance','levels':3})<cr>
" " derived
" nn <silent> xd :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true})<cr>
" " derived of up to 3 levels
" nn <silent> xD :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true,'levels':3})<cr>
"
" " caller
" nn <silent> xc :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
" " callee
" nn <silent> xC :call LanguageClient#findLocations({'method':'$ccls/call','callee':v:true})<cr>
"
" " $ccls/member
" " nested classes / types in a namespace
" nn <silent> xs :call LanguageClient#findLocations({'method':'$ccls/member','kind':2})<cr>
" " member functions / functions in a namespace
" nn <silent> xf :call LanguageClient#findLocations({'method':'$ccls/member','kind':3})<cr>
" " member variables / variables in a namespace
" nn <silent> xm :call LanguageClient#findLocations({'method':'$ccls/member'})<cr>
"
" nn xx x

fu! C_init()
  setl formatexpr=LanguageClient#textDocument_rangeFormatting()
endf
au FileType c,cpp,cuda,objc :call C_init()

"""""""""""""
" Neoformat "
"""""""""""""
augroup format
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

"""""""""""""
" vim-cmake "
"""""""""""""
let g:cmake_export_compile_commands=1
let g:cmake_ycm_symlinks=1
