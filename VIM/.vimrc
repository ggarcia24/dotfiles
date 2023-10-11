
"" .vimrc
"" Gonzalo Garcia Updated: 2019-02-24 16:01
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
            " set pythonthreedll=/usr/local/Frameworks/Python.framework/Versions/3.7/Python
            " set pythonthreehome=/usr/local/Frameworks/Python.framework/Versions/3.7
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
colorscheme desert
" set macligatures
set guifont=Fira\ Code:h12
let mapleader = ","
set title " Show the filename in the window titlebar
set nocompatible
set noshowmode " Don't show the current mode (lightline.vim takes care of us)
set ttyfast
set relativenumber " Always use relative number
autocmd InsertEnter * :set number " When entering insert mode change to number mode
autocmd InsertLeave * :set relativenumber " When leaving insert mode change back
" Disable autocopy
set guioptions-=e
set guioptions-=a
set guioptions-=A
set guioptions-=aA
if has("clipboard") " Attempt to unify clipboards
    set clipboard=unnamed " copy to the system clipboard
    if has("unnamedplus") " X11 support
        set clipboard+=unnamedplus
    endif
endif
set nowrap
set textwidth=79 " Line length
set formatoptions= " Empty format options
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words
set formatoptions+=j "
set colorcolumn=72,80,96,120
set hidden  " switch to another buffer without having to save it!
"" autocmd FocusLost * :wa " Save on lost focus!
set nobackup
set noswapfile
set scrolloff=3
set cursorline " Highlight current line
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:<,space:␣" Use the same symbols as TextMate for tabstops and EOLs
set lazyredraw " redraw only when we need to.
set magic " Enable extended regexes
set modeline " Allow configuration from a comment line at the beginning or the bottom
set modelines=5
"" }

"" Basic Mappings {
" Disable EX mode
nnoremap Q <Nop>
" Move between windows using CTRL+h,j,k,l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Move between visual lines instead of phisical lines
nnoremap j gj
nnoremap k gk
 " Clear search results
nnoremap <leader><space> :noh<CR>
" Toggle show whistpace chars
nmap <leader>z :set list!<CR>
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
" Move faster between buffers
nnoremap <leader>l :ls<CR>:b<Space>
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

"
Plug 'tpope/vim-sensible'                                           " Sensible standards
" Themes
Plug 'nanotech/jellybeans.vim'
" Tools
Plug 'moll/vim-bbye'                                         " Close buffers without closing the window
Plug 'scrooloose/nerdtree'                                   " Tree
Plug 'inkarkat/vim-localrc'                                  " Per directory .local.vimrc configuration file from directories <- Disable to recursion when using on home file

" # IDE/CODE Utilities #
Plug 'tpope/vim-repeat'                                      " Allow some commands to be repeted via .
Plug 'tpope/vim-surround'                                    " Change surrounding charactes
Plug 'mileszs/ack.vim'                                       " Find code faster!
Plug 'kien/ctrlp.vim'                                        " Fuzzy finder
Plug 'itchyny/lightline.vim'                                 " Cool & Fast status line
" Plug 'mgee/lightline-bufferline'                             " Buffers instead of tabs!
Plug 'scrooloose/nerdcommenter'                              " Comments
Plug 'majutsushi/tagbar'                                     " Class/module browser
Plug 'Townk/vim-autoclose'                                   " Autoclose (,[,etc
Plug 'godlygeek/tabular'                                     " Align assignments and comments
Plug 'itchyny/vim-gitbranch'                                 " Only need that branch
Plug 'airblade/vim-gitgutter'                                " Show git line status on the gutter
Plug 'junegunn/vim-peekaboo'                                 " Show the registers contents
Plug 'tyru/open-browser.vim'
Plug 'Chiel92/vim-autoformat'                                " Autoformat!
Plug 'takac/vim-hardtime'                                    " Self-torture!
" Plug 'Valloric/YouCompleteMe'                                " Autocomplete
Plug 'vim-syntastic/syntastic'                               " Check languages syntax with linter
Plug 'Valloric/MatchTagAlways'                               " Highlights the enclosing html/xml tags
Plug 'sheerun/vim-polyglot'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'michaeljsmith/vim-indent-object'

Plug 'tmux-plugins/vim-tmux'

Plug 'tpope/vim-cucumber'                                    " Cucumber
Plug 'rooprob/vim-behave'                                    " Behave

Plug 'tpope/vim-markdown', { 'for': 'markdown' }             " Markdown
Plug 'jtratner/vim-flavored-markdown', { 'for': 'markdown' } " Github Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }     " Python indent
Plug 'nvie/vim-flake8', { 'for': 'python' }                  " Python syntax

Plug 'hashivim/vim-terraform'                                " Terraform
Plug 'juliosueiras/vim-terraform-completion'                 " Terraform

Plug 'ekalinin/Dockerfile.vim'                               " Docker
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}                     " Sparkup (HTML expansions i.e div#header + <C-e> -> <div id="header"></div>
" Plug 'vim-vdebug/vdebug'                                     " Debugger!
Plug 'moll/vim-node'                                         " Node/Javascript support
Plug 'aklt/plantuml-syntax'                                  " PlantUML syntax
Plug 'weirongxu/plantuml-previewer.vim'                      " Preview PlantUML
call plug#end()
"" }

"" Bbye {
command! -bang -complete=buffer -nargs=? Bclose Bdelete<bang> <args> "  Add an alias to Bclose
nnoremap <leader>q :Bdelete<CR>
"" }

"" Markdown Preview {
let g:mkdp_auto_start = 1
"" }

"" YouCompleteMe {
let g:ycm_filetype_whitelist = {
            \ 'java': 1,
            \ 'php': 1,
            \ 'javascript': 1,
            \ 'python': 1,
            \ 'ruby': 1,
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

"" Lightline Config {
set showtabline=1
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
let g:NERDTreeIgnore=['\.py[co]$', '\~$', 'tags', '.DS_Store'] "ignore files in NERDTree
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
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'
let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_python_pylint_args = '--rcfile=~/.pylintrc'
let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_ruby_rubocop_exec = 'RBENV_VERSION=2.4.0 ~/.rbenv/shims/rubocop'
"" }

"" Command/File Autocomplete {
set path+=** " Search files recursively from CWD
set wildmode=full
set showmode
set showcmd
set completeopt=longest,menuone


" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*ildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

"" }

"" Whitespace/Indenting {
set smartindent
set copyindent
set shiftwidth=4
set softtabstop=4
set expandtab
"" }

"" Searching {
nnoremap / /\v
vnoremap / /\v
set showmatch
set hlsearch
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

" Gherking
au FileType cucumber setl sw=2 sts=2 et
au Bufread,BufNewFile *.feature set filetype=cucumber

" Javascript
au Bufread,BufNewFile *.js set filetype=javascript
" autocmd Filetype javascript setlocal ts=2 sw=2 expandtab

" Jenkinsfile
autocmd BufNewFile,BufRead Jenkinsfile setf groovy

" YAML
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" for python files
" Display tabs at the beginning of a line in Python mode as bad.
autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
autocmd BufRead,BufNewFile *.* match BadWhitespace /\s\+$/

"" }

" vim:foldmethod=marker:foldlevel=0
