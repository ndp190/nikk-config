# Nikk config

Install

```bash
make
```

Clean: this will *remove all* current configuration, use with cautious

```bash
make clean
```

# Edit

To add more package for brew, update it in `install-brew.sh
To add more package for node, update it in `install-node.sh

# Custom script

## Colorized output

Ex:

```bash
echo-colorized '[0;31mConflictError[0m:'
```

## Auto generate `__init__.py`

Ex:

```bash
autogen-pyinit <directory-to-generate>
```
