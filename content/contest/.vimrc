" Line numbers
set nu
set rnu
" Tab and indentation settings
set ts=2
set sts=2
set sw=2
set et
set si
" Text display
set nowrap
" Search
set nohlsearch
set incsearch
" Scrolling and UI
set so=8
set scl=yes
set isf+=@-@
" Leader key
let mapleader=" "
" Key mappings
nnoremap <leader>pv :Ex<CR>
" Move selected lines up and down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Improved join and navigation
nnoremap J mzJ`z
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
" Greatest remap ever
xnoremap <leader>p "_dP
" Next greatest remap ever
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
" Pane navigation using Ctrl + hjkl
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

function! CARQ()
  " Save the current file
  w
  " Get the full path of the current file
  let filename = expand('%:p')
  " Compile the current file with g++
  let compile_cmd = 'g++ -Wshadow -DKRAKAR -o a.out ' . filename . ' 2>&1 | tee /tmp/quickfix.log'
  " Run the compile command and send output to quickfix
  silent execute '!' . compile_cmd
  cfile /tmp/quickfix.log
  " Open the Quickfix window if there are any entries
  if getqflist({'size': 0}).size > 0
    copen
  else
    " If compilation succeeds without errors, run the output executable
    " Redirect stderr (cerr) to debug.txt
    execute '!./a.out 2> debug.txt'
  endif
endfunction

function! SPL()
  " Open task1.cpp in the left pane
  vsplit task1.cpp
  " Move to the right pane
  wincmd l
  " Split the right pane into 3 rows and open input.txt, output.txt, and debug.txt
  split input.txt
  w
  wincmd j
  split output.txt
  w
  wincmd j
  edit debug.txt
  w
  wincmd j
  " Move back to the topmost pane (input.txt)
  wincmd k
  wincmd k
  " Move to the left pane
  wincmd h
endfunction
nnoremap <F5> :call CARQ()<CR>
nnoremap <F6> :call SPL()<CR>

