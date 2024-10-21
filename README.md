# How to manage dotfiles
* Install files with [dotbot](https://github.com/anishathalye/dotbot):
```bash
pip install dotbot
dotbot -c install.conf.yaml
```

### To use YouCompleteMe code completion in vim
* Requires at least vim 8.2.3995 and python 3.8
* If building vim from source, `export LDFLAGS="-rdynamic"`, then `/.configure --enable-python3interp`, followed by the usual `make` and `sudo make install`
* If installing python with pyenv, run `export PYTHON_CONFIGURE_OPTS="--enable-shared"` before `pyenv install <version>`
* Run `:PluginInstall` in vim, then go to `~/.vim/bundles/YouCompleteMe` and run `python install.py` to install the YCM server

### To use Minimap
See dependencies before installing: [wfxr/minimap.vim](https://github.com/wfxr/minimap.vim?tab=readme-ov-file#-installation)
