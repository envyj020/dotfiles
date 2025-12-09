let g:mapleader = " "
let g:maplocalleader = " "

let s:undo_history_on = v:true

set clipboard^=unnamed,unnamedplus

set nocompatible               " Forget about vi and set it first as it modifies future behaviour
set updatetime=250             " Delay in ms for background tasks such as CursorHold events
set timeoutlen=300             " Time in ms between key press events in a mapping sequence

"--- Indentation
set tabstop=4                  " The number of spaces a tab is
set shiftwidth=4               " Number of spaces to use in auto(indent)
set softtabstop=4              " Just to be clear
set expandtab                  " Insert tabs as spaces

"--- Search
set wrapscan                   " Wrap searches
set ignorecase                 " Ignore search term case...
set smartcase                  " ... unless term contains an uppercase character
set hlsearch                   " Highlight as you type
set incsearch                  " Jump to the first ocurrence

"--- Wrapping
set nowrap                     " Don't wrap long lines - good for vsplits

"--- General
syntax on                      " Turn on syntax highlighting
set noexrc                     " Risky, loads per project vim settings
set confirm                    " Ask in case failure because of unsaved changes
set encoding=UTF-8
set fileencoding=UTF-8
set shortmess+=Wc              " Don't show up written and completion messages
set iskeyword+=-               " Characters that must be part of a word
set termguicolors              " Display 24-bit RGB colors
set backspace=indent,eol,start " Allow backspace over the specified options
set lcs=tab:»\ ,trail:.,nbsp:␣ " How some characters will display in the editor
set so=10                      " Min number lines to keep below and above cursor
set ruler                      " Show line and row numbers over mouse position
set number                     " Display line number
set bri                        " Preserve indentation in wrapped text
set showcmd                    " Show partial command
set noswapfile                 " Don't generate a swap file
set autoread                   " Regenerate file as it changed outside of vim
set noerrorbells               " Disable error notifications
set nofixeol                   " Turn off appending new line in EOF
set nojoinspaces               " Insert only one space when joining lines
set cursorline                 " Hightlight cursor selected text area
set backupcopy=yes             " Make a copy of the file and overwrite the original one
set relativenumber             " Show the line number relative to the line with the cursor
set signcolumn=yes             " When and how to draw the signcolumn
set scrolloff=8                " Min number of screen lines to keep above and below the cursor
set hidden                     " The buffer becomes hidden when it is abandoned
set splitright                 " Vsplit right
set splitbelow                 " Split down
set modifiable                 " Makes any vim buffer modifiable
set mouse+=a                   " Turns on mouse buffer interaction
set inccommand=split           " Preview substitutions
set foldmethod=manual          " Manual Fold method za/zb
set sessionoptions-=blank      " Do not save empty windows
set laststatus=3               " Global statusline

set viminfo=!,'150,<100,s20,h                            " State persistence
set guicursor=n:block-blink,v-i-c-ci:ver25-blink,r:hor20 " Cursor shape by mode
set completeopt=menu,menuone,noselect                    " Autocompletion mode
set wildmode=list:longest                                " CMD autocompletion
set wildmenu
set wildignore=*.o,*.obj,*~
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

filetype plugin indent on                  " Smart buffer ft rules and indentation
hi LinrNr term=NONE                        " Resets abs line numbers colorscheme
au CursorHold * checktime                  " Prompt to reload buffers
au FileType * setlocal formatoptions-=cro  " Disables automatic comment formatting and wrapping

if s:undo_history_on && has('persistent_undo')
    let s:undodir = expand('~/.vim/undo')
    if !isdirectory(s:undodir)
        call system('mkdir -p ' . s:undodir)
    endif
    execute 'set undodir=' . s:undodir
    set undofile
endif
