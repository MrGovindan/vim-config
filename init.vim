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

" AUTOCOMPLETE "
""""""""""""""""
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

" LINTING "
"""""""""""
Plug 'w0rp/ale'

" C++ Development
"""""""""""""""""
" Plug 'bfrg/vim-cpp-modern'
" Plug 'zchee/deoplete-clang'
" Plug 'lyuts/vim-rtags'
" Plug 'ericcurtin/CurtineIncSw.vim'
" Plug 'Shougo/neoinclude.vim'

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
      \ 'colorscheme': 'iceberg',
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
let g:localvimrc_whitelist=['/home/jesse/Documents/cpp/template/']

""""""""""""""""
" AUTOCOMPLETE "
""""""""""""""""
" deoplete
""""""""""
let g:deoplete#enable_at_startup = 1

set hidden

let g:LanguageClient_serverCommands = {
    \ 'c': ['/home/jesse/Documents/cpp/ccls/Release/ccls', '--log-file=/tmp/cc.log'],
    \ 'cpp': ['/home/jesse/Documents/cpp/ccls/Release/ccls', '--log-file=/tmp/cc.log'],
    \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
    \ }

let g:LanguageClient_loadSettings = 1

nn <silent> <C-]> :call LanguageClient#textDocument_definition()<cr>
nn <silent> <F12> :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<cr>
nn <silent> <C-k><C-i> :call LanguageClient#textDocument_hover()<cr>
nn <silent> <C-k><C-r> :call LanguageClient#textDocument_rename()<cr>

augroup LanguageClient_config
  au!
  au BufEnter * let b:Plugin_LanguageClient_started = 0
  au User LanguageClientStopped setl signcolumn=auto
  au User LanguageClientStopped set b:Plugin_LanguageClient_started = 0
  au User LanguageClientStopped echom "STOPPED"
  au User LanguageClientStarted setl signcolumn=yes
  au User LanguageClientStarted set b:Plugin_LanguageClient_started = 1
  au User LanguageClientStarted echom "STARTED"
  au CursorMoved * if b:Plugin_LanguageClient_started | sil call LanguageClient#textDocument_documentHighlight() | endif
augroup END

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


"""""""""""""""""""
" C++ Development "
"""""""""""""""""""
" let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-7/lib/libclang.so'
" let g:deoplete#sources#clang#clang_header = '/usr/include/clang'
" 
" augroup cpp_navigation_mappings
"   autocmd!
"   autocmd FileType cpp,cxx,h,hpp noremap <C-k><C-i> :call rtags#SymbolInfo()<CR>
"   autocmd FileType cpp,cxx,h,hpp noremap <buffer> <C-]> :call rtags#JumpTo(g:SAME_WINDOW, {'--declaration-only' : ''})<CR>
"   autocmd FileType cpp,cxx,h,hpp noremap <C-k><C-o> :call CurtineIncSw()<CR>
"   autocmd BufEnter *.cpp,*.cxx,*.h,*.hpp :call GetIncludePaths()
" augroup END
" 
" function! GetIncludePaths()
"   if exists('g:cpp_development_configuration_folder')
"     let s:filename = expand('%:t:r')
"     let g:neoinclude#paths = get(g:, 'neoinclude#paths', {})
"     call neoinclude#util#set_default_dictionary('g:neoinclude#paths', 'cpp', '')
"     let g:neoinclude#paths.cpp = '/usr/include/c++/8,/usr/local/include,/usr/include'
" 
"     let g:compile_command = ''
"     let g:ale_cpp_clangtidy_options = join(['-p=' . g:cpp_development_configuration_folder . '/build', '-x c++', '-I/usr/include/c++/8'], ' ')
" 
"     if match(g:neoinclude#paths.cpp, expand('%:p:h')) < 0
"       let g:neoinclude#paths.cpp .= ',' . expand('%:p:h')
"     endif
" 
"     let s:lines = readfile(getcwd() . '/build/compile_commands.json')
"     let s:line_number = 1
" 
"     for s:line in s:lines
"       let s:command_match = match(s:line, 'command')
"       if s:command_match >= 0
"         " if the line contains our filename
"         let s:filename_match = match(s:line, s:filename)
"         if s:filename_match >= 0
" 
"           " Extract the compile command
"           let s:compile_options_match = match(s:line, '  -')
"           if s:compile_options_match >= 0
"             let s:compile_command = strpart(s:line, s:compile_options_match, match(s:line, '-o ') - s:compile_options_match)
"           endif
" 
"           let g:ale_cpp_gcc_options = s:compile_command
" 
"           " Search compile command for include paths
"           let s:include_match = match(s:compile_command, '-I')
"           while s:include_match >= 0
"             " Extract just the path from include option 
"             " i.e -I/usr/local -> /usr/local
"             let s:include_path = strpart(s:compile_command, s:include_match + 2)
"             let s:end = match(s:include_path, ' ')
"             let s:include_path = strpart(s:include_path, 0, s:end)
" 
"             let g:ale_cpp_clangtidy_options .= ' -I' . s:include_path
"             let g:neoinclude#paths.cpp .= ',' . s:include_path
" 
"             let s:compile_command = strpart(s:compile_command, s:end + s:include_match + 2)
"             let s:include_match = match(s:compile_command, '-I')
"           endwhile
" 
"         endif
"       endif
"       let s:line_number += 1
"     endfor
"   endif
" 
"   "echom 'gcc_options:       ' . g:ale_cpp_gcc_options
"   "echom 'clangtidy_options: ' . g:ale_cpp_clangtidy_options
"   "echom 'neoinclude_paths:  ' . g:neoinclude#paths.cpp
" endfunction

"""""""""""""
" Neoformat "
"""""""""""""
augroup format
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
