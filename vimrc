syntax enable

set smartindent
set autoindent
filetype on
filetype plugin indent on

set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab
set expandtab

" Turn off auto-comments
autocmd FileType * setlocal fo-=r

" Automatically remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" Automatically :set paste
if &term =~ "xterm.*" || &term =~ "screen*"
  let &t_ti = &t_ti . "\e[?2004h"
  let &t_te = "\e[?2004l" . &t_te
  function! XTermPasteBegin(ret)
    set pastetoggle=<Esc>[201~
    set paste
    return a:ret
  endfunction
  map <expr> <Esc>[200~ XTermPasteBegin("i")
  imap <expr> <Esc>[200~ XTermPasteBegin("")
  cmap <Esc>[200~ <nop>
  cmap <Esc>[201~ <nop>
endif

" Remember last edited line
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" dont use a tempfile for crons
autocmd filetype crontab setlocal nobackup nowritebackup

colorscheme kalisi
"set background=light
" or
set background=dark
" if you don't set the background, the light theme will be used

