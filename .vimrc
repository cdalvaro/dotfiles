" VIM Settings

syntax on " Enable syntax highlight

"set mouse=a   " Enable mouse click
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

filetype plugin indent on " Enable file type specific indentation

set expandtab     " Use spaces instead of tabs when indenting
set number        " line number
set shiftwidth=4  " Indent by 4 spaces
set tabstop=4     " Hard tab stop
set softtabstop=4 " Soft tab stop

set magic          " Allow special characters in regex patterns
set smarttab       " Use smart tabulation
filetype indent on " Enable indentation based on filetype

set incsearch  " Incrementally highlight search pattern as it is updated
set hlsearch   " Highlight search matches after entering search pattern

" Unhighlight selected word
nnoremap <C-h> :nohlsearch<CR>

set ignorecase " Use case insensitive search pattern matching by default
set smartcase  " Override 'ignorecase' setting if search pattern contains uppercase characters
set showcmd    " Show status line

" Change swap and backup directories
set backupdir=$HOME/.vim,/tmp,.
set directory=$HOME/.vim,/tmp,.

" TrueColors
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Spaceduck theme
colorscheme spaceduck
let g:airline_theme = 'spaceduck'

" Vim Airline
let g:airline_powerline_fonts=1
set encoding=utf8
set laststatus=2

" Update Git signs every time the text is changed
autocmd User SignifySetup
  \ execute 'autocmd! signify' |
  \ autocmd signify TextChanged,TextChangedI * call sy#start()

" Clipboard settings
if (has("mac"))
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" Solve problems related with backspace and delete keys
" https://vim.fandom.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

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

" Hide scroll bar
set guioptions-=r  "remove right-hand scroll bar

" fzf integration
set rtp+=$HOMEBREW_PREFIX/opt/fzf
map ; :Files<CR>

if !has('nvim')
  set ttymouse=xterm2
endif

" Functions

" ALE Linter - https://github.com/w0rp/ale
" Enable completion where available
let g:ale_completion_enabled=1

" Set this. Airline will handle the rest
let g:airline#extensions#ale#enabled=1

" MuComplete
let g:mucomplete#enable_auto_at_startup=1

set completeopt+=menuone
set completeopt+=noselect
set completeopt+=noinsert
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Put these lines at the very end of your vimrc file

" Load all plugins now
" Plugins need to be added to runtimepath before helptags can be generated
packloadall

" Load all of the helptags now, after plugins have been loaded
" All messages and errors will be ignored
silent! helptags ALL
