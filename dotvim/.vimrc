"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" VUNDLE SETTINGS
set nocompatible
filetype off   
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Vundle Packages
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dracula/vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'let-def/ocp-indent-vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'w0rp/ale'

" End Vundle
call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" GENERAL SETTINGS
filetype plugin indent on
syntax on
colorscheme dracula
set number
set laststatus=2
set autochdir

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
autocmd Filetype ocaml setlocal ts=2 softtabstop=2 sw=2 expandtab
autocmd Filetype python setlocal ts=2 softtabstop=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 softtabstop=2 sw=2 expandtab

" make cocoascript javascript highlighting
augroup filetypedetect
    au BufRead,BufNewFile *.cocoascript setfiletype javascript
augroup END

" map ctrl-s to save
nnoremap <c-s> :w<CR> 
inoremap <c-s> <Esc>:w<CR>l 
vnoremap <c-s> <Esc>:w<CR> 

" use ';' instead of ':" 
nnoremap ; :

" Bindings avoid shift-finger
command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Write     <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file -range=% -bang Wq        <line1>,<line2>wq<bang> <args>
command! -bar                                  -bang Wqall     wqa<bang>
command! -bar -nargs=* -complete=file -range=% -bang We        <line1>,<line2>w<bang> | e <args>
command! -bar -nargs=* -complete=file -count   -bang Wnext     <count>wnext<bang> <args>
command! -bar -nargs=* -complete=file -count   -bang Wprevious <count>wprevious<bang> <args>
command! -bar -nargs=* -complete=file          -bang E         edit<bang> <args>
command! -bar -nargs=* -complete=file          -bang Edit      edit<bang> <args>
command! -bar                                  -bang Q         quit<bang>
command! -bar                                  -bang Quit      quit<bang>
command! -bar                                  -bang Qall      qall<bang>
command! -bar -nargs=? -complete=option              Set       set <args>
command! -bar -nargs=? -complete=help                Help      help <args>
command! -bar -nargs=* -complete=file          -bang Make      make<bang> <args>
command! -bar -nargs=* -complete=buffer        -bang Bdel      bdel<bang> <args>
command! -bar -nargs=* -complete=buffer        -bang Bwipe     bwipe<bang> <args>
command! -bar -nargs=* -complete=file          -bang Mksession mksession<bang> <args>
command! -bar -nargs=* -complete=dir           -bang Cd        cd<bang> <args>
command! -bar                                        Messages  messages
command! -bar -nargs=+ -complete=file          -bang Source    source<bang> <args>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" PLUGIN SETTINGS
" ctrl-p settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|venv)|(\.(swp|ico|git|svn))$'

" incsearch settings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" ocaml config
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" vim-airline settings
" let g:airline_section_c = '%t'

" ale
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_python_pylint_options='--rcfile ~/dotfiles/.pylintrc'
let g:ale_linters = {
\   'python': ['pylint'],
\}

" vim-jsx
let g:jsx_ext_required = 0
