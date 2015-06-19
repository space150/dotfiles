"=========================================================="
"                    space150's  .vimrc                    "
" -------------------------------------------------------- "
" This is a shared .vimrc and is meant to serve as a base. "
" You can add customizations in a file named .vimrc.local. "
"=========================================================="

" Use UTF-8.
set encoding=utf-8

" Use syntax highlighting.
syntax on

" Enable filetype detections.
filetype plugin indent on

if has('gui_running')
  set titlestring=
  set titlestring+=%f\       " file name
  set titlestring+=%h%m%r%w  " flags

  set guioptions=gmtc
  set antialias

  if has('mac')
    set macmeta
    set fuoptions=maxvert,maxhorz
  endif
endif

" Prevent Vim from clobbering the scrollback buffer.
" http://www.shallowsky.com/linux/noaltscreen.html
" via Gary Bernhardt
set t_ti= t_te=


"=========================================================="
" Settings
"=========================================================="

" Keep a really long command/search history.
set history=1000

" More words.
set dictionary=/usr/share/dict/words

" Make command line 1 line tall.
set cmdheight=1

" Turn on auto-indentation.
set autoindent
set smartindent
set cindent

" Disable modelines.
set modelines=0

" Stop littering .swp files everywhere.
set noswapfile

" Reload a file that is modified from the outside.
set autoread

" Make tab completion a lot smarter (mostly works like zsh).
set wildmode=list:longest,list:full
set wildmenu
set wildignore=*.dll,*.exe,*.pyc,*.pyo,*.egg
set wildignore+=*.jpg,*.gif,*.png,*.o,*.obj,*.bak,*.rbc
set wildignore+=Icon*,\.DS_Store,*.out,*.scssc,*.sassc
set wildignore+=.git/*,.hg/*,.svn/*,*/swp/*,*/undo/*,Gemfile.lock

" Don't redraw while executing macros.
set lazyredraw

" Backspace over things.
set backspace=indent,eol,start

" Stop littering .swp files everywhere.
set noswapfile

" Highlight the line the cursor is on.
set cursorline

" Softtabs, 2 spaces.
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Mark the 81st column to make it obvious where 80 characters is.
set colorcolumn=81

" Don't drop buffers when no longer shown in a window.
set hidden

" Don't wrap text.
set nowrap
" Mark wrapped lines.
set showbreak=\ »\ 

" Show extra lines for context.
set scrolloff=5
set sidescroll=1
set sidescrolloff=1

" Show line numbers.
set number
" Don't take up more space than necessary.
set numberwidth=1

" Open new split panes to right and bottom, which feels more natural.
set splitbelow
set splitright

" Searches should be case insensitive unless there's a capital letter.
set ignorecase
set smartcase

" Start searching instantly.
set incsearch
set showmatch

" Highlight all matches for the last used search pattern.
set hlsearch

" Enable mouse support in terminals that can handle it.
set mouse=a

" Please don't beep.
set visualbell

" Show the cursor position in the status line.
set ruler

" Show info about current command in bottom right.
set showcmd

" Display the current mode in the status line.
set showmode

" Always display the status line.
set laststatus=2

" Don't show the startup message.
set shortmess=I

" Improve session saving.
set sessionoptions=blank,curdir,folds,help,tabpages,winpos


"" The Silver Searcher
"
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in Ack.vim.
  let g:ackprg = 'ag --nogroup --nocolor --column'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache.
  let g:ctrlp_use_caching = 0
endif


"=========================================================="
" Functions
"=========================================================="

augroup SpaceVim

  autocmd!

  " Resize splits on window resize.
  autocmd VimResized * exe "normal! \<c-w>="

  " Jump to last position in buffer when opening.
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                            \ exe "normal g'\"" | endif

  " For man pages:
  "   - don't show listchars
  "   - exit with q
  autocmd FileType man set nolist | nnoremap q :q!<cr>

  " This makes editing crontab possible.
  autocmd BufNewFile,BufRead crontab.* set nobackup | set nowritebackup

  " Don't show listchars in git commit view or gitconfig, it's annoying.
  autocmd FileType gitcommit set nolist
  autocmd FileType gitconfig set nolist

  " Format json.
  autocmd FileType json command! Format %!python -m json.tool

augroup END

augroup Markdown
  autocmd!

  " Treat all text files as markdown.
  autocmd BufNewFile,BufRead *.{txt,text} set filetype=markdown

  " Wrap text for txt/markdown.
  autocmd FileType markdown set wrap linebreak textwidth=80
  autocmd FileType txt set wrap linebreak textwidth=80

  " Don't showbreak for txt/markdown.
  autocmd FileType markdown set showbreak=
  autocmd FileType txt set showbreak=

  " Enable spellcheck in Markdown.
  autocmd FileType markdown set spell
augroup END

augroup Wax
  autocmd!
  autocmd BufNewFile,BufRead Waxfile set filetype=yaml
augroup END



"=========================================================="
" Functions
"=========================================================="

" Use <tab> for indent if on a blank/whitespace line,
" or completion if there is text entered.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" Rename current file (from Gary Bernhardt).
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction


"=========================================================="
" Commands
"=========================================================="

" Concealerator.
command! ConcealToggle let &conceallevel=&conceallevel==0?2:0

" Search for todos with Ack.
command! Todos Ack TODO


"=========================================================="
" Mappings
"=========================================================="

" Use comma as leader.
let mapleader = ","
let g:mapleader = ","

" Easier split navigation.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Scroll up/down scroll faster.
noremap <c-e> 5<c-e>
noremap <c-y> 5<c-y>

" Keep the selection when indenting.
vnoremap < <gv
vnoremap > >gv

" Navigate wrapped lines.
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Inspect highlight under cursor.
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
\ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" Remove trailing whitespace (except when escaped).
nnoremap <leader>rw :%s/[^\\]\zs\s\+\ze$//e<cr>:noh<cr>

" Repeat the last :! command.
" *maybe
nnoremap <c-c> :!!<cr>

" InsertTabWrapper (autocomplete).
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Clear highlighted search.
nnoremap <cr> :nohlsearch<cr>


"=========================================================="
" Local config
"=========================================================="

if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
