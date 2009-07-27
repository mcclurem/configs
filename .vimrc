set ruler
set nu
set tabstop=8
set tags=tags;~/
colorscheme peachpuff
augroup filetype
	au! BufRead,BufNewFile *.bash*		set filetype=sh
	au! BufRead,BufNewFile *.thtml		set filetype=php
	au! BufRead,BufNewFile *.jobdesc	set filetype=php
	au! BufRead,BufNewFile *.verilog	set filetype=verilog
augroup END
syntax on
filetype plugin on
filetype indent on 
