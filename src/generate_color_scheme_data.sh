# vim-polyglot
mkdir -p ~/.vim/pack/vim-polyglot/start/vim-polyglot/
git clone https://github.com/sheerun/vim-polyglot ~/.vim/pack/vim-polyglot/start/vim-polyglot

owner_name="$1"
name="$2"
color_scheme_name="$3"
if [ -z $color_scheme_name ]; then
  color_scheme_name=$name
fi

# creating the vim plugin directory
mkdir -p ~/.vim/pack/$name/start/$name

git clone --depth 1 \
  https://github.com/$owner_name/$name \
  ~/.vim/pack/$name/start/$name

cat set_termguicolors.vim > ~/.vimrc

echo "colorscheme $color_scheme_name" >> ~/.vimrc

cat vcspg.vim >> ~/.vimrc

vim -c ':call WriteColorValues()' code_sample.js -c ':q'
