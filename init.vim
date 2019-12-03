set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGGIN MANAGER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" LOOK AND FEEL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'

" UTILITIES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
Plug 'skywind3000/asyncrun.vim'
Plug 'sheerun/vim-polyglot'

" AUTOCOMPLETE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" LINTING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'w0rp/ale'

" LANGUAGES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TYPESCRIPT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set clipboard+=unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LOOK AND FEEL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set termguicolors
colorscheme onedark

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

set number
set colorcolumn=100

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Localvimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:localvimrc_file_directory_only=1
let g:localvimrc_sandbox=0
let g:localvimrc_ask=0

" deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

set hidden

" ale
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
      \ 'java':[],
      \}

let g:ale_linters_explicit = 1

" coc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

call SetupCommandAbbrs('C', 'CocConfig')

" Neoformat
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup format
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" asyncrun
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:asyncrun_open=8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quick Save
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>

" Tab Navigation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-h> :tabp<CR>
nnoremap <C-l> :tabn<CR>

" CtrlP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'

" Neosnippet
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" coc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> <F12> <Plug>(coc-references)
nmap <C-k><C-r> <Plug>(coc-rename)
nmap <silent> <C-k><C-i> :call <SID>show_documentation()<CR>
nmap [a <Plug>(coc-diagnostic-prev)
nmap ]a <Plug>(coc-diagnostic-prev)
nmap <C-k><C-h> <Plug>(coc-diagnostic-info)

inoremap <silent><expr> <c-space> coc#refresh()

" asyncrun "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <F9> :call asyncrun#quickfix_toggle(30)<cr>

" C++ comment out word
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap gcw ysw/lysw*
