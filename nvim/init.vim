" Load configs
exe 'source ~/.config/nvim/autoload/plug.vim'
for f in split(glob('~/.config/nvim/configs/*.vim'), '\n')
   exe 'source' f
endfor
