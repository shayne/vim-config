
" ==========================================================
" Vundler setup
" ==========================================================

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" ==========================================================
" Bundles
" ==========================================================

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-surround'
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'mileszs/ack.vim'
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'YankRing.vim'

""" Git
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'

""" Python
Bundle 'fs111/pydoc.vim'
Bundle 'vim-scripts/pep8'
Bundle 'kevinw/pyflakes-vim'
Bundle 'sontek/rope-vim'
" Bundle 'alfredodeza/pytest.vim'
" Bundle 'reinh/vim-makegreen'

""" Command-T
" Don't forget to compile C extension
"  $ cd ~/.vim/bundle/command-t/ruby/command-t
"  $ ruby extconf.h
"  $ make
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     " required!


" ==========================================================
" Shortcuts
" ==========================================================

" Change the leader to be a comma vs slash
let mapleader=","

" Switch to last buffer
nnoremap <leader><leader> <c-^>

" Bind :W to :w
command! W :w

" sudo write this
cmap W! w !sudo tee % >/dev/null

" Reload Vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
" and lets make these all work in insert mode too ( <C-O> makes next cmd
"  happen as if in command mode )
imap <C-W> <C-O><C-W>

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%

" Toggle the tasklist$
map <leader>td <Plug>TaskList

" python pep8 violations in quickfix window
let g:pep8_map='<leader>8'

" Python Rope
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

""" Command-T
" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

nnoremap <silent> <leader>f :CommandTFlush<cr>\|:CommandT<cr>
nnoremap <silent> <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>
let g:CommandTAcceptSelectionSplitMap='<C-g>'

" ACK plugin
nmap <leader>a <Esc>:Ack!<space>

" Load the Gundo window
map <leader>g :GundoToggle<CR>

" Visual YankRing
nnoremap <silent> <C-y> :YRShow<CR>

" Use jj instead of ESC since it's pretty much
" of a stretch with the hand.
imap jj <Esc>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Fold using <space>
nnoremap <space> za

" don't outdent hashes
inoremap # X#

" Paste from clipboard
map <leader>p "+p

" Quit window on <leader>q
nnoremap <leader>q :q<CR>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Select the item in the list with enter
inoremap <expr> <silent> <Cr> <SID>CrInInsertModeBetterWay()

function! s:CrInInsertModeBetterWay()
  return pumvisible() ? neocomplcache#close_popup()."\<Cr>" : "\<Cr>"
endfunction

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Toggle QuickFix window
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

nmap <silent> <leader>` :QFix<CR>

""" PyFlakes
let g:pyflakes_use_quickfix = 0

" Show PyFlakes window
function! ShowPyFlakes()
     :PyflakesUpdate
      if !exists("s:pyflakes_qf")
         :botright cwindow
      endif
endfunction

map <Leader>p :call ShowPyFlakes()<CR>


" ==========================================================
" Plugin Settings
" ==========================================================

" SuperTab lets us use tab for autocompletion in
" insert mode
let g:SuperTabDefaultCompletionType = 'context'

" YankRing history
let g:yankring_history_dir = '~/.vim'


" ==========================================================
" General VIM Settings
" ==========================================================
syntax on                     " syntax highlighing
filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype
" set number                    " Display line numbers
" set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
set colorcolumn=79

" don't bell or blink
set noerrorbells
set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set grepprg=ack         " replace the default grep program with ack

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

""" Moving Around/Editing
set cursorline                  " have a line indicate the cursor location
set ruler                       " show the cursor position all the time
set nostartofline               " Avoid moving cursor to BOL when jumping around
set virtualedit=block           " Let cursor move past the last char in <C-v> mode
set scrolloff=5                 " Keep 3 context lines above and below the cursor
set backspace=indent,eol,start  " backspace through everything in insert mode
set showmatch                   " Briefly jump to a paren once it's balanced
set nowrap                      " don't wrap text
set linebreak                   " don't wrap textin the middle of a word
set autoindent                  " always set autoindenting on
set smartindent                 " use smart indent if there is no indent file
set tabstop=4                   " <tab> inserts 4 spaces
set shiftwidth=4                " but an indent level is 2 spaces wide.
set softtabstop=4               " <BS> over an autoindent deletes both spaces.
set expandtab                   " Use spaces, not tabs, for autoindent/tab key.
set shiftround                  " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>             " show matching <> (html mainly) as well
set foldmethod=indent           " allow us to fold on indents
set foldlevel=99                " don't fold by default

"""" Reading/Writing
set encoding=utf-8
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
" set list

" Highlight inconsistencies mixing tabs and spaces
highlight BadSpacing term=standout ctermbg=cyan
augroup Spacing
    autocmd!
    " Highlight tabulators and trailing spaces (nasty bastards)
    autocmd BufNewFile,BufReadPre * match BadSpacing /\(\t\|  *$\)/
    " Only highlight trailing space in tab-filled formats
    autocmd FileType help,make match BadSpacing /  *$/
augroup END

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
set t_Co=256
colorscheme ir_black
if has("gui_running")
    " Remove menu bar
    set guioptions-=m
    " Remove toolbar
    set guioptions-=T
endif

" set the backup dir to declutter working directory.
" two ending slashes means, full path to the actual filename
" -- thanks to indygemma
silent! !mkdir -p ~/.vim/backup
silent! !mkdir -p ~/.vim/swap
silent! !mkdir -p ~/.vim/undo
set backup
set backupdir=~/.vim/backup/
set directory=~/.vim/swap/
" Persistent undos (vim 7.3+)
set undofile
set undodir=~/.vim/undo/


" ===========================================================
" FileType specific changes
" ============================================================

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

" In Makefiles, use real tabs, not tabs expanded to spaces
au FileType make set noexpandtab

" Make sure all mardown files have the correct filetype set and setup wrapping
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

" Treat JSON files like JavaScript
au BufNewFile,BufRead *.json set ft=javascript

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

""" Mako/HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

""" Python
"au BufRead *.py compiler nose
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 textwidth=79 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Omni Completion
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType python set omnifunc=pythoncomplete#Complete
au FileType php set omnifunc=phpcomplete#CompletePHP

" robhudson's django snipmate bundle includes lots of
" snippets. If you are not working a lot with django
" and django/jinja templates, comment the following
" lines
au FileType python set ft=python.django
au FileType html set ft=htmldjango.html

" Use indent as foldmethod in python.
" THX to
" http://stackoverflow.com/questions/357785/what-is-the-recommended-way-to-use-vim-folding-for-python-coding
au FileType python set foldmethod=indent
" Do not fold internal statements.
au FileType python set foldnestmax=2

""" PyEnv - Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

