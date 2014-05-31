" note: a lot of defaults come from sensible.vim
" it's good, install it!

" to install pathogen:
" mkdir -p ~/.vim/autoload ~/.vim/bundle && \
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
execute pathogen#infect()

" map spacebar as the leader key
let mapleader = "\<Space>"

" use :help 'option' to see the documentation for the given option

set ruler
set number
set backspace=2
"set tabstop=4
set tags=tags;~/
augroup filetype
  au! BufRead,BufNewFile *.bash*        set filetype=sh
  au! BufRead,BufNewFile *.c,*.h,*.cpp  set foldmethod=syntax
  au! BufRead,BufNewFile *.py           set foldmethod=indent
augroup END
"au VimEnter * highlight clear SignColumn

syntax on
filetype plugin on
filetype indent on

function! Stab(value)
  let &shiftwidth  = a:value
  let &softtabstop = a:value
  let &tabstop     = a:value
endfunc

call Stab(4)

" disable that stupid window
map q: :q

" automatically jump to end of text you pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"CTRL-N for nerdtree
map <C-n> :NERDTreeToggle<CR>
" close vim if nerdtree is only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" auto-open nerdtree
"autocmd vimenter * NERDTree

" open a NERDTree automatically when vim starts up if no files were specified
autocmd vimenter * if !argc() | NERDTree | endif

" airline settings
let g:airline#extensions#tabline#enabled = 1

" splitjoin
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>

" buffers
noremap <leader>bl :ls<CR>      " List buffers.
noremap <leader>bn :bn<CR>      " Next buffer.
noremap <leader>bp :bp<CR>      " Previous buffer.
noremap <leader>bt :b#<CR>      " Toggle to most recently used buffer.
" these require butane.vim
noremap <leader>bd :Bclose<CR>  " Close the buffer.
noremap <leader>bx :Bclose!<CR> " Close the buffer & discard changes.

" railscasts color scheme
set background=dark
colorscheme base16-railscasts

highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
" highlight LineNr       ctermbg=236 ctermfg=240 " old
highlight LineNr       ctermbg=240 ctermfg=12
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=12
highlight IncSearch    ctermbg=0   ctermfg=3
highlight Search       ctermbg=0   ctermfg=9
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=0   ctermfg=3
highlight SpellBad     ctermbg=0   ctermfg=1
" end railscasts color scheme

" bind decrement number to ctrl-shift-a
"FIXME: doesn't work
"nnoremap <C-S-a> <C-x>

