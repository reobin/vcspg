owner_name="$1"
name="$2"

# creating the vim plugin directory
mkdir -p ~/.vim/pack/$owner_name/$name/start/

git clone --depth 1 \
  https://github.com/$owner_name/$name.git \
  ~/.vim/pack/$owner_name/start/$name

cat set_termguicolors.vim > ~/.vimrc

echo "colorscheme $name\n" >> ~/.vimrc

cat get_color_values.vim >> ~/.vimrc

vim -c ':call GetColorValues()' code_sample.js -c ':q'
