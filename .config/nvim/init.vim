" NeoVim settings

" NeoVim specific settings
if (has('nvim'))

endif

" Clipboard settings
if (has("mac"))
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" TrueColors
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Python provider
if (has("nvim"))
  let g:loaded_python_provider=0
  let g:python3_host_prog="$HOMEBREW_PREFIX/bin/python3"
endif

" General settings
syntax on           " Enable syntax highlight
set expandtab       " Use spaces instead of tabs when indenting
set number          " line number

filetype plugin indent on " Enable file type specific indentation
filetype indent on        " Enable file type specific indentation
set shiftwidth=2          " Indent by 4 spaces
set tabstop=2             " Hard tab stop
set softtabstop=2         " Soft tab stop

set magic           " Allow special characters in regex patterns
set smarttab        " Use smart tabulation

set incsearch       " Incrementally highlight search pattern as it is updated
set hlsearch        " Highlight search matches after entering search pattern
set ignorecase      " Use case insensitive search pattern matching by default
set smartcase       " Override 'ignorecase' setting if search pattern contains uppercase characters
set showcmd         " Show status line

nnoremap <C-h> :nohlsearch<CR> " Unhighlight selected word

" Change swap and backup directories
set backupdir=$HOME/.vim,/tmp,.
set directory=$HOME/.vim,/tmp,.

" Solve problems related with backspace and delete keys
" https://vim.fandom.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

"set mouse=a   " Enable mouse click
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

" Hide scroll bar
set guioptions-=r  "remove right-hand scroll bar

" Restore terminal cursor with vertical line
autocmd VimLeave * set guicursor=a:ver25

" Theme settings
let g:github_theme_style = 'dimmed'
colorscheme github_dimmed

" Lualine settings
lua << EOF
require('lualine').setup {
  options = {
    theme = 'github'
  }
}
EOF

set encoding=utf8
set laststatus=2

" Update Git signs every time the text is changed
autocmd User SignifySetup
  \ execute 'autocmd! signify' |
  \ autocmd signify TextChanged,TextChangedI * call sy#start()

" Navegacion de ventanas
set swb=usetab
nnoremap <C-e> <C-u>:tab sbuf <C-d>
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
nnoremap <C-w>     <Esc>:tabclose<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt

" fzf integration
set rtp+=$HOMEBREW_PREFIX/opt/fzf
map ; :Files<CR>

" Clang-format
map <silent> <C-S-f> :py3f $HOMEBREW_PREFIX/opt/clang-format/share/clang/clang-format.py<cr>
imap <silent> <C-S-f> <c-o>:py3f $HOMEBREW_PREFIX/opt/clang-format/share/clang/clang-format.py<cr>

function! ClangFormat()
  let l:formatdiff=1
  py3f $HOMEBREW_PREFIX/opt/clang-format/share/clang/clang-format.py
endfunction
autocmd BufWritePre *.h,*.hpp,*.c,*.cc,*.cpp call ClangFormat()

" ALE linter - https://github.com/w0rp/ale
" Enable completion where available
let g:ale_completion_enabled=1
let g:ale_completion_autoimport=1

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1

let g:ale_linters = {
\   'ruby': ['rubocop'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop']
\}

" Show errors or warnings in my statusline
let g:airline#extensions#ale#enabled=1

" Navigate between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" Put these lines at the very end of your vimrc file

" Load all plugins now
" Plugins need to be added to runtimepath before helptags can be generated
packloadall

" Load all of the helptags now, after plugins have been loaded
" All messages and errors will be ignored
silent! helptags ALL
