# Nikk config

* Install

```bash
make
```

* [Optional] Update custom configurations located at `~/.zsh_custom.zsh`, use cases:
    * git gpg sign
    * specific host's shell configurations

* Manual steps

    * tmux: in order to install tmux plugins you need to go into a tmux session and input `<leader> I`

* (*)Clean: this will *remove all* current configuration, use with cautious

```bash
make clean
```

## Brew & node package

To add more package for brew, update it in `install-brew.sh`
To add more package for node, update it in `install-node.sh`

## Custom scripts

### Colorized output

Ex:

```bash
echo-colorized '[0;31mConflictError[0m:'
```

### Auto generate `__init__.py`

Ex:

```bash
autogen-pyinit <directory-to-generate>
```

## Other notes

* Midnight commander: configuration is put in `/mc` folder, not included in install script

# FAQ

### Q: Error when ssh to another server in kitty and try to run tmux?

Run this command

	runkitty +kitten ssh nikk@192.168.1.202
