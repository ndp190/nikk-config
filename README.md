# Nikk config

Install

```bash
make
```

Clean: this will *remove all* current configuration, use with cautious

```bash
make clean
```

# Add package

To add more package for brew, update it in `install-brew.sh`
To add more package for node, update it in `install-node.sh`

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

# Notes

* Midnight commander: configuration is put in `/mc` folder, not included in install script

# FAQ

### Q: Error when ssh to another server in kitty and try to run tmux?

Run this command

	runkitty +kitten ssh nikk@192.168.1.202
