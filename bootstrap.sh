FILE=~/.local/share/nvim/site/autoload/plug.vim

echo Checking plug.vim installation...

if [ ! -f "$FILE" ]; then
  echo Downloading plug.vim...
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo plug.vim installed.

echo creating symlinks for tmux configuration

ln -s ~/.config/nvim/tmux-config/.tmux ~/
ln -s ~/.config/nvim/tmux-config/.tmux.conf ~/

echo symlinks created for tmux configuration

if command -v clangd 2>/dev/null; then
  echo "clangd executable found"
else
  echo "trying to install clangd"
  apt install clang-tools
  apt install clangd
fi

# clangformat
if command -v clang-format 2>/dev/null; then
  echo "clang-format executable found"
else
  apt install clang-format
fi

# clangtidy
if command -v clang-tidy 2>/dev/null; then
  echo "clang-tidy executable found"
else
  apt install clang-tidy
fi

# nodejs
if command -v nodejs 2>/dev/null; then
  echo "nodejs executable found"
else
  apt install nodejs
fi

# npm
if command -v npm 2>/dev/null; then
  echo "npm executable found"
else
  apt install npm
fi

# pip3
if command -v pip3 2>/dev/null; then
  echo "pip3 executable found"
else
  apt install pip3
fi

# compdb
if [[ -x "${HOME}/.local/bin/compdb" ]]
then
  echo "compdb executable found"
else
  echo "compdb not installed"
  pip3 install compdb
fi
