if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufNewFile,BufRead Rexfile set filetype=perl
  au! BufNewFile,BufRead *sls set filetype=yaml
augroup END
