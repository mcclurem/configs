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
	au! BufRead,BufNewFile *.c,*.h,*.cpp	set foldmethod=syntax
augroup END
syntax on
filetype plugin on
filetype indent on
function ToggleHLSearch()
	if &hls
		set nohls
	else
		set hls
	endif
endfunction

nmap <silent> <C-n> <Esc>:call ToggleHLSearch()<CR>. 
