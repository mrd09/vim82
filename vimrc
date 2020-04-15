"""""""""""""""""""""""""""""""""""""
" Basic config
"""""""""""""""""""""""""""""""""""""
" Copy and paste visual mode in vim
set mouse=a

" color
":color elflord

" Indentation & Tabs
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Display number, status
set number
set laststatus=2
set statusline+=%F

" Search
set hlsearch
set incsearch

" Clear search
nnoremap <F3> :noh<CR>

" Enable persistence undo, mkdir -p ~/.vim/undodir/
set undofile
set undodir=~/.vim/undodir

" Paste Toggle with shortkey:
set pastetoggle=<F2>

" Auto map key

" Pairing braces
inoremap " ""<left>
inoremap ' ''<left>
inoremap < <><left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {{ {{}}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Esc outside braces
inoremap <C-a> <ESC><right>a

" Switch tab in vim -p
noremap <S-PageUp> gT
noremap <S-PageDown> gt

" Switch window in vim -O
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Swap line in vim
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

" Copy to PRIMARY or CLIPBOARD
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

"""""""""""""""""""""""""""""""""""""
" Dat's Modify
"""""""""""""""""""""""""""""""""""""
"""" General Configuration
" status line at the bottom: line number, the column number ..
set ruler

" Enable highlighting of the current line
set cursorline

" OSX stupid backspace fix
set backspace=indent,eol,start

" Set clipboard
" set clipboard=unnamed

" color syntax highlighting turn on
syntax on

" Not use line breaking
set nowrap

" UTF-8 Support
set encoding=utf-8

"""""""""""""""""""""""""""""""""""""
" vim foldcode
" Usage _Onelvl: zc(close), zo(open), za(toggle), zr(reduce) _AllLvl: zC, zO, zA, zR are similar but for all
"""""""""""""""""""""""""""""""""""""
set foldmethod=indent
" Keep all folds open when a file is opened
augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
augroup END

"""""""""""""""""""""""""""""""""""""
" nerdtree config
"""""""""""""""""""""""""""""""""""""
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git', '\.swp']
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'V'
map <C-S-a> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""
" color theme gruvbox config
"""""""""""""""""""""""""""""""""""""
set t_Co=256
set background=dark
colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""
" vim-gitgutter
"""""""""""""""""""""""""""""""""""""
set updatetime=100
let g:gitgutter_highlight_lines = 1
let g:gitgutter_highlight_linenrs = 1
hi clear SignColumn

"""""""""""""""""""""""""""""""""""""
" vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"""""""""""""""""""""""""""""""""""""
" fzf
"""""""""""""""""""""""""""""""""""""
if !empty(glob("~/.fzf/"))
    set rtp+=~/.fzf
    map <S-f> :FZF<CR>
endif

if !empty(glob("/usr/bin/ag"))
    map <S-a> :Ag<CR>
endif
