" Load configs
exe 'source ~/.config/nvim/autoload/plug.vim'
for f in split(glob('~/.config/nvim/configs/*.vim'), '\n')
   exe 'source' f
endfor

" Enable hidden file search for Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
