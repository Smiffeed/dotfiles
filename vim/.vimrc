syntax on             " Enable syntax highlighting
set nocompatible      " Disable backward compatibility with older vi
filetype plugin on    " Load filetype-specific plugins

" --- Indentation ---
set tabstop=4         " Number of visual spaces per TAB
set shiftwidth=4      " Number of spaces used for autoindentation
set expandtab         " Convert tabs to spaces
set smartindent       " Make indentation smart

" --- Search ---
set incsearch         " Highlight search results as you type
set hlsearch          " Highlight all matches
set ignorecase        " Case-insensitive search
set smartcase         " Become case-sensitive if you type uppercase

" --- User Interface ---
set number            " Show line numbers
set relativenumber    " Show relative line numbers for quick jumping
set showcmd           " Show command in bottom bar
set hidden            " Allow hiding buffers with unsaved changes

" --- System ---
set nobackup          " Do not keep a backup file
set noswapfile        " Do not create swap files
set wildmenu
