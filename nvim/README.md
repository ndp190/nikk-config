## How to reload new plugin
run `:so %` to reload and `:PlugInstall` to install plugins

## Fix

* For error 'requires Vim compiled with Python'

```
python3 -m pip install --user --upgrade pynvim
```
