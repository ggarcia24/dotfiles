 
"" .vimrc
"" Gonzalo Garcia Updated: 2017-08-26 16:57
""

"" Fixes to common problems {

"" On Windows, also use '.vim' 
if has('win32')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

if has('unix')
    if has('mac')
	" Fix python problem 
	if has('python3')
	    command! -nargs=1 Py py3 <args>
	    "" set pythonthreedll=/usr/local/Frameworks/Python.framework/Versions/3.7/Python
	    "" set pythonthreehome=/usr/local/Frameworks/Python.framework/Versions/3.7
	endif

	if has('python')
	    command! -nargs=1 Py py <args>
	    "" set pythondll=/usr/local/Frameworks/Python.framework/Versions/2.7/Python
	    "" set pythonhome=/usr/local/Frameworks/Python.framework/Versions/2.7
	endif
    endif
endif

"" }

"" Basic vim {
set nocompatible
filetype off
filetype plugin on
filetype indent plugin on
syntax on
set encoding=utf-8
set ttyfast
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
let mapleader = ","
" Disable autocopy
set guioptions-=e
set guioptions-=a
set guioptions-=A
set guioptions-=aA
" Attempt to unify clipboards
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif
" Line length
set nowrap
set textwidth=120
set formatoptions-=t
set formatoptions+=n
set formatoptions+=j
set formatoptions+=1
set formatoptions+=c
set colorcolumn=+1
"" Save on lost focus!
au FocusLost * :wa
set nobackup
set noswapfile
set scrolloff=3
set hidden  " switch to another buffer without having to save it!
colorscheme desert
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
" Disable EX mode
nnoremap Q <Nop>
" redraw only when we need to.
set lazyredraw
set modeline
set modelines=5
"" }

"" Basic Mappings {
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Move between visual lines instead of phisical lines
nnoremap j gj
nnoremap k gk
nnoremap <leader><space> :noh<CR> " Clear search results
" Toggle whistpace
nmap <leader>l :set list!<CR>
" space open/closes folds
nnoremap <space> za
" open ack.vim
nnoremap <leader>a :Ack
" Autoformat by pressing CTRL+ALT+l
noremap <C-A-l> :Autoformat<CR>
inoremap <C-A-l> <Esc>:Autoformat<CR>i
" comment 
nnoremap <C-7> <leader>cc<CR>
nnoremap <C-/> <leader>cu<CR>
inoremap <C-7> <Esc><leader>cc<CR>
inoremap <C-/> <Esc><leader>cu<CR>
"" }

"" Self-torture {
" Only move using jklh
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" Disable moving in insert mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" Disable ESC key to use jk
inoremap jk <Esc>
inoremap <Esc> <nop>
"" }

"" Commands {
" TAG JUMPING
command! MakeTags !ctags -R --exclude=.git --exclude=node_modules --exclude=test .
"" }

"" Functions {
"" }

"" Folding config {
set foldmethod=indent
set foldmarker={,}
set foldlevel=0
set foldlevelstart=10   " open most folds by default
set foldnestmax=10
"" }

"" Plugins {
if empty(glob("~/.vim/autoload/plug.vim"))
execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/bundle')

" Tools
Plug 'moll/vim-bbye'  " Close buffers without closing the window
" Plug 'tpope/vim-obsession' " Session management
"" Plug 'editorconfig/editorconfig-vim' " EditorConfig support <- Disabled due to python error
Plug 'scrooloose/nerdtree'    " Tree
Plug 'itchyny/lightline.vim'  " Cool & Fast status line
Plug 'mgee/lightline-bufferline'  " Buffers instead of tabs!
Plug 'tpope/vim-surround'     " Surround things
Plug 'tpope/vim-repeat'       " Allow some commands to be repeted via .
Plug 'mileszs/ack.vim'        " Find code faster!
Plug 'scrooloose/nerdcommenter'  " Comments
Plug 'tpope/vim-dispatch'     " ??
Plug 'kien/ctrlp.vim'    " Fuzzy finder
Plug 'Townk/vim-autoclose'    " Autocloe (,[,etc
Plug 'godlygeek/tabular'      " Align Test
Plug 'itchyny/vim-gitbranch'  " Only need that branch
Plug 'airblade/vim-gitgutter' " Show git line status on the gutter
Plug 'junegunn/vim-peekaboo'  " Show the registers contents
Plug 'Chiel92/vim-autoformat' " Autoformat!
""" Plug 'inkarkat/vim-localrc'   " Per directory .local.vimrc configuration file from directories <- Disable to recursion when using on home file
Plug 'takac/vim-hardtime'     " Self-torture!

" Completition
Plug 'Valloric/YouCompleteMe'

" Languages
Plug 'vim-syntastic/syntastic'    " Check with linter
Plug 'tpope/vim-cucumber'         " Cucumber
Plug 'rooprob/vim-behave'         " Behave
Plug 'tpope/vim-markdown'         " Markdown
Plug 'jtratner/vim-flavored-markdown'  " Github Markdown
" Python
Plug 'vim-scripts/indentpython.vim' " Python indent
Plug 'nvie/vim-flake8'
" Sparkup (HTML expansions i.e div#header + <C-e> -> <div id="header"></div>
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'vim-vdebug/vdebug' " Debugger!
call plug#end()

runtime macros/matchit.vim
"" }

"" Bbye {
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args> "  Add an alias to Bclose
nnoremap <Leader>q :Bdelete<CR>
"" }

"" YouCompleteMe {
let g:ycm_filetype_whitelist = {
    \ 'java': 1,
    \ 'javascript': 1,
    \ 'python': 1,
    \ 'html' : 1,
    \ }
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
"" }

"" Hardtime {
let g:hardtime_default_on = 1
let g:hardtime_showmsg = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2
"" }

"" AutoSave/Load Session information from current directory {
" autocmd VimLeave * call SaveSess()
" autocmd VimEnter * nested call RestoreSess()
"" }

"" Lightline Config {
set ruler
set showtabline=2
set laststatus=2
set confirm
set visualbell
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline = {
\   'colorscheme': 'jellybeans',
\   'tabline': {'left': [['buffers']], 'right': [['close']]},
\   'active': {
\     'left':[ [ 'mode', 'paste' ],
\              [ 'gitbranch', 'readonly', 'filename' ]
\     ]
\   },
    \   'component': {
    \     'lineinfo': ' %3l:%-2v',
    \   },
\   'component_expand': {'buffers': 'lightline#bufferline#buffers'},
\   'component_type':{'buffers': 'tabsel'},
\   'component_function': {
\     'gitbranch': 'gitbranch#name',
\   }
\ }
"" }

"" NERDTree {
let g:NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore=['\.pyc$', '\~$', 'tags'] "ignore files in NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"" }

"" Syntastic config {
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_python_pylint_args = '--rcfile=~/.pylintrc'
let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_ruby_rubocop_exec = 'RBENV_VERSION=2.4.0 ~/.rbenv/shims/rubocop'
"" }

"" Command/File Autocomplete {
set path+=** " Search files recursively from CWD
set wildmenu " Show a menu with matches
set wildmode=full
set showmode
set showcmd
set completeopt=longest,menuone


" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

"" }

"" Whitespace/Indenting {
set smartindent
set autoindent
set copyindent
set smarttab
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start
"" }

"" Searching {
nnoremap / /\v
vnoremap / /\v
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
hi Search ctermbg=LightYellow
hi Search ctermfg=Red
"" }

"" Ack.vim {
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
"" }

"" NERDCommenter {
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
"" }

"" ctrlP {
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|\.yardoc|node_modules|log|tmp$',
  \ 'file': '\v\.(exe|so|dll|dat|DS_Store)$'
  \ }
"" }

"" Lang {
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"" }

"" Watch for changes in the .*vimrc files {
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    if has("gui_running")
        autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
    endif
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
  augroup END
endif " has autocmd
"" }

"" Markdown Support {
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown wrap
augroup END
"" }

"" Filetypes modifications {
highlight BadWhitespace ctermbg=red guibg=red

" Jenkinsfile
autocmd BufNewFile,BufRead Jenkinsfile setf groovy
" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" for python files
" Display tabs at the beginning of a line in Python mode as bad.
autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"" }

" vim:foldmethod=marker:foldlevel=0
