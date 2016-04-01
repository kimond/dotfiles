" --------
" Vim plug
" --------
call plug#begin('~/.vim/plugged')
" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fholgado/minibufexpl.vim'

" Ui
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'nanotech/jellybeans.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline-themes'
Plug 'kshenoy/vim-signature'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-airline-colornum'

" Command
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'terryma/vim-multiple-cursors'
Plug 'Lokaltog/vim-easymotion'
Plug 'garbas/vim-snipmate'
Plug 'sjl/gundo.vim'
Plug 'honza/vim-snippets'
Plug 'scrooloose/syntastic'
Plug 'xolox/vim-session'

" Lib dependencies
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'xolox/vim-misc'

" Language Additions
Plug 'klen/python-mode'
" Plug 'Valloric/YouCompleteMe'
call plug#end()

" ---------------------------------------------
" Regular Vim Configuration (No Plugins Needed)
" ---------------------------------------------

" ---------------
" Color
" ---------------
set background=dark
try
  colorscheme jellybeans
catch
endtry

" ---------------------------------
" Force 256 color mode if available
" ---------------------------------
if $TERM =~ "-256color"
   set t_Co=256
endif

" ------------
" Set GUI font
" ------------
if has("gui_running")
    set guifont=Hack\ 12
endif

" -----------------------------
" File Locations
" -----------------------------
set directory=~/.vim/tmp
set spellfile=~/.vim/spell/custom.en.utf-8.add
" Persistent Undo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/.undo
endif

" ---------------
" UI
" ---------------
set cursorline
set ruler          " Ruler on
set number         " Line numbers on
set nowrap         " Line wrapping off
set cmdheight=1    " Make the command area one lines high
set noshowmode     " Don't show the mode since Powerline shows it
set title          " Set the title of the window in the terminal to the file
" Disable tooltips for hovering keywords in Vim
if exists('+ballooneval')
  " This doesn't seem to stop tooltips for Ruby files
  set noballooneval
  " 100 second delay seems to be the only way to disable the tooltips
  set balloondelay=100000"
endif

" ---------------
" Behaviors
" ---------------
set nobackup           " Turn off backups
set noswapfile         " Turn off swapfiles
set hidden             " Change buffer - without saving
set cf                 " Enable error files & error jumping.
" Yanks go on clipboard instead.
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif
set autowrite          " Writes on make/shell commands
set timeoutlen=450     " Time to wait for a command (after leader for example).
set nofoldenable       " Disable folding entirely.
set foldlevelstart=99  " I really don't like folds.
set formatoptions=crql
set iskeyword+=\$,-   " Add extra characters that are valid parts of variables
set nostartofline      " Don't go to the start of the line after some commands
set scrolloff=3        " Keep three lines below the last line when scrolling
set gdefault           " this makes search/replace global by default
set switchbuf=useopen  " Switch to an existing buffer if one exists

" ---------------
" Text Format
" ---------------
set tabstop=4
set shiftwidth=4 " Tabs under smart indent
set cindent
set expandtab " use spaces, not tabs

" ---------------
" Searching
" ---------------
set ignorecase " Case insensitive search
set smartcase  " Non-case sensitive search
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc,*/node_modules/*,
  \rake-pipeline-*

" ---------------
" Visual
" ---------------
set showmatch   " Show matching brackets.
set matchtime=2 " How many tenths of a second to blink
set list " Show invisible characters

" Show trailing spaces as dots and carrots for extended lines.
" Reset the listchars
set listchars=""
" make tabs visible
set listchars=tab:▸▸
" show trailing spaces as dots
set listchars+=trail:.
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=extends:>
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=precedes:<

" ---------------
" Mouse
" ---------------
set mousehide  " Hide mouse after chars typed

" Better complete options to speed it up
set complete=.,w,b,u,U

" ----------------------------------------
" Mappings
" ----------------------------------------

" Set leader to ,
" Note: This line MUST come before any <leader> mappings
let mapleader=","
let maplocalleader = "\\"

" ---------------
" Regular Mappings
" ---------------

" Select entire buffer
nnoremap vy ggVG

" Make Y behave like other capital commands.
nnoremap Y y$

" Just to beginning and end of lines easier. From http://vimbits.com/bits/16
noremap H ^
noremap L $

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" ---------------
" Window Movement
" ---------------
nnoremap <silent> gh :wincmd h<CR>
nnoremap <silent> gj :wincmd j<CR>
nnoremap <silent> gk :wincmd k<CR>
nnoremap <silent> gl :wincmd l<CR>

"   4 Window Splits
"   -----------------
"   g1 | g2 | g3 | g4
"   -----------------
nnoremap <silent> g1 :wincmd t<CR>
nnoremap <silent> g2 :wincmd t<bar>:wincmd l<CR>
nnoremap <silent> g3 :wincmd t<bar>:wincmd l<bar>:wincmd l<CR>
nnoremap <silent> g4 :wincmd b<CR>

" Previous Window
nnoremap <silent> gp :wincmd p<CR>
" Equal Size Windows
nnoremap <silent> g= :wincmd =<CR>
" Swap Windows
nnoremap <silent> gx :wincmd x<CR>

" ---------------
" Modifer Mappings
" ---------------

" Make line completion easier.
inoremap <C-l> <C-x><C-l>

" Easier Scrolling (think j/k with left hand)
" All variations are mapped for now until I get used to one
" C/M/D + d (page up)
" C/M/D + f (page down)
nnoremap <C-j> 15gjzz
nnoremap <C-k> 15gkzz
vnoremap <C-j> 15gjzz
vnoremap <C-k> 15gkzz

" ---------------
" Leader Mappings
" ---------------

" Clear search
noremap <silent><leader>/ :nohls<CR>

" Highlight search word under cursor without jumping to next
nnoremap <leader>h *<C-O>

" Toggle spelling mode with ,s
nnoremap <silent> <leader>s :set spell!<CR>

" Underline the current line with '-'
nnoremap <silent> <leader>ul :t.\|s/./-/\|:nohls<cr>

" Underline the current line with '='
nnoremap <silent> <leader>uul :t.\|s/./=/\|:nohls<cr>

" Surround the commented line with lines.
nnoremap <silent> <leader>cul :normal "lyy"lpwv$r-^"lyyk"lP<cr>

" Format the entire file
nnoremap <leader>fef mx=ggG='x

" Split window vertically or horizontally *and* switch to the new split!
nnoremap <silent> <leader>hs :split<Bar>:wincmd j<CR>
nnoremap <silent> <leader>vs :vsplit<Bar>:wincmd l<CR>

" Close the current window
nnoremap <silent> <leader>sc :close<CR>
"
" Typo Fixes
noremap <F1> <Esc>
inoremap <F1> <Esc>
cnoremap w' w<CR>

" Disable the ever-annoying Ex mode shortcut key. Type visual my ass. Instead,
" make Q repeat the last macro instead. *hat tip* http://vimbits.com/bits/263
nnoremap Q @@

" Removes doc lookup mapping because it's easy to fat finger and never useful.
nnoremap K k
vnoremap K k

" Toggle paste mode with F5
nnoremap <silent> <F5> :set paste!<CR>

"Sudo write"
cmap w!! w !sudo tee % >/dev/null

" ----------------------------------------
" Plugin Configuration
" ----------------------------------------

" ---------------
" Syntastic
" ---------------
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }
let g:syntastic_html_checkers = ['handlebars']

" Hat tip http://git.io/SPIBfg
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_full_redraws = 1

" ---------------
" NERDTree
" ---------------
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeChDirMode = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.pyc$']
" Close Vim if NERDTree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
  \&& b:NERDTreeType == "primary") | q | endif

" -----------
" Ident guide
" -----------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" -----------
" Vim session
" -----------
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options
let g:session_autosave = 'yes'
let g:session_autoload = 'no'

" ---------------
" Fugitive
" ---------------
nnoremap <Leader>gd :Gdiff<CR>
" Exit a diff by closing the diff window
nnoremap <Leader>gx :wincmd h<CR>:q<CR>
" Start git command
nnoremap <leader>gi :Git<space>
" Run a git status
nnoremap <leader>gst :Git status<CR>
" Undo the last commit
command! Gcundo :Git reset HEAD~1

"----------
"GitGutter
"----------
let g:gitgutter_map_keys = 0

" ---------------
" ctrlp.vim
" ---------------
" Ensure max height isn't too large. (for performance)
let g:ctrlp_max_height = 10
" Fix fix new windows opening in split from startify
let g:ctrlp_mruf_max = 350
let g:ctrlp_mruf_default_order = 0

" ---------------
" airline
" ---------------
let g:airline_theme = 'jellybeans'
let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#hunks#enabled = 0
"let g:airline#extensions#tabline#enabled = 1
let g:airline_mode_map = {
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'v'  : 'V',
      \ 'V'  : 'VL',
      \ 'c'  : 'CMD',
      \ '' : 'VB',
      \ }
" Show the current working directory folder name
let g:airline_section_b = '%{substitute(getcwd(), ".*\/", "", "g")} '
" Just show the file name
let g:airline_section_c = '%t'
let g:airline_section_y = ''
let g:airline_section_z = '%3p%% %#__accent_bold#%4l%#__restore__#:%3'
let g:airline_section_z = '%3p%% %{substitute(line("."), "\\v(\\d)((\\d\\d\\d)+\\d@!)@=", "\\1,", "g")}|%{substitute(line("$"), "\\v(\\d)((\\d\\d\\d)+\\d@!)@=", "\\1,", "g")}'

" ---------------
" jellybeans.vim colorscheme tweaks
" ---------------
" Make cssAttrs (center, block, etc.) the same color as units
hi! link cssAttr Constant

" ---------------
" surround.vim
" ---------------
" Use # to get a variable interpolation (inside of a string)}
" ysiw#   Wrap the token under the cursor in #{}
" Thanks to http://git.io/_XqKzQ
let g:surround_35  = "#{\r}"

" ---------------
" YouCompleteMe
" ---------------
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'ruby' : 1,
    \ 'javascript' : 1,
    \}

" ---------------
" tcomment_vim
" ---------------
let g:tcommentMaps = 0
nnoremap <silent><leader>cc :TComment<CR>
vnoremap <silent><leader>cc :TComment<CR>
nnoremap <silent><leader>cb :TCommentBlock<CR>
vnoremap <silent><leader>cb :TCommentBlock<CR>

" -----------
" Python Mode
" -----------
let g:pymode_rope = 0
let g:pymode_lint_on_write = 0

" ----------
" MiniBufExpl
" ----------
map <leader>bc :MBEbd<CR>
map <leader>bn :MBEbn<CR>
map <leader>bp :MBEbp<CR>
nnoremap <silent> <F4> :MBEbd<CR>
nnoremap <silent> <F3> :MBEbn<CR>
nnoremap <silent> <F2> :MBEbp<CR>
