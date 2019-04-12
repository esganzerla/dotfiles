"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader
let mapleader = ","

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <Leader>/ :nohls<CR>

" Visual Settings
syntax on
set ruler
set number
set noshowmode
set laststatus=2
set showtabline=2
set t_Co=256
set background=dark
highlight LineNr term=bold cterm=bold ctermfg=241 ctermbg=235

" Indentation
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround
set smartindent
set list
set listchars=tab:>·,trail:·

" Performance
set nocursorcolumn
set nocursorline
set ttyfast
set lazyredraw
syntax sync minlines=206

" Disable swap files
set nobackup
set noswapfile
set nohidden

" Use TAB to complete when typing words, else inserts TABs as usual.
" Uses dictionary and source files to find matching words to complete.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" Column limit
highlight ColorColumn ctermbg=241
set colorcolumn=80

" Panes resizing
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2) . " \n vertical resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3) . " \n vertical resize " . (winheight(0) * 2/3)<CR>

" Panes Splitting
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Stay vmode on indent
vnoremap < <gv
vnoremap > >gv

" Increment/Decrement shortcuts
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" Copy/Paste/Cut
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>
if has('macunix')
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Personal shortcuts
noremap <Leader>l :exec "set number! list! \n GitGutterToggle \n IndentLinesToggle"<CR>
noremap <Leader>z :set foldmethod=syntax<CR>
noremap <space> zx
noremap <Leader>f :fold<CR>
noremap <Leader>t :tabe<CR>
noremap <Leader>= :set tabstop=4 shiftwidth=4 expandtab<CR>

" WBSO commit message macro
map <Leader>w 0ggveyo<CR>WBSO-Time-Spent: 1h<CR>WBSO-Topic: genius-dynamic-pricing<ESC>gg0Igenius-dynamic-pricing: <ESC>

" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev X x
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Syntax for .comp files
autocmd BufNewFile,BufRead *.comp set syntax=html
autocmd BufNewFile,BufRead *.html set syntax=perl

" Reload files automagically and move cursors when needed
:set autoread | au CursorHold * checktime | call feedkeys("lh")

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc so %

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

  " Syntax
  Plug 'pangloss/vim-javascript', {'for': ['javascript', 'js', 'jsx', 'jstmpl']}
  Plug 'plasticboy/vim-markdown', {'for': ['markdown']}

  " Linting and Helpers
  Plug 'w0rp/ale'
  Plug 'tpope/vim-commentary'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'Raimondi/delimitMate'

  " Colors and styles
  Plug 'itchyny/lightline.vim'
  Plug 'altercation/vim-colors-solarized'

  " Keeping the code clean
  Plug 'vim-scripts/indentLine.vim'

  " Files structure
  Plug 'junegunn/fzf', { 'dir': '~/dotfiles/.fzf', 'do': './install --all' }

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  " Booking Stuff
  Plug 'ssh://git.booking.com/gitroot/devtools/vim-booking.git'

call plug#end()

" Solarized
let g:rehash256=1
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" Ale
let g:ale_open_list = 1
let g:ale_list_window_size = 5
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linter_aliases = {
\   'jstmpl': 'javascript',
\   'csstmpl': 'css',
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jstmpl': ['eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\}

" Lightline
let g:lightline = {
\ 'colorscheme': 'one',
\   'active': {
\     'left': [
\       [ 'mode', 'paste' ],
\       [ 'readonly', 'filename', 'modified', 'helloworld' ]
\     ]
\   },
\ }

" FZF
map <c-p> :FZF<Enter>

" Indentline
let g:indentLine_color_term = 239

" Vim Gutter
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=235
highlight GitGutterAdd ctermfg=yellow ctermbg=232
highlight GitGutterDelete ctermfg=red ctermbg=232
highlight GitGutterChange ctermfg=33 ctermbg=232
highlight GitGutterChangeDeleteLine ctermfg=33 ctermbg=232

" Vim Fugitive (git)
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
