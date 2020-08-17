owner_name="$1"
name="$2"

# creating the vim plugin directory
mkdir -p ~/.vim/pack/$owner_name/$name/start/

git clone --depth 1 \
  https://github.com/$owner_name/$name.git \
  ~/.vim/pack/$name/start/$name

cat set_termguicolors.vim > ~/.vimrc

echo "colorscheme $name" >> ~/.vimrc

cat vcspg.vim >> ~/.vimrc

vim -c ':call WriteColorValues()' code_sample.js -c ':q'
