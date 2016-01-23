# sysconfig

Dotfiles, amirite?

Dotfiles and the management thereof are the programmer's version of home
decoration, in that a) the task is never, ever done, and b) no two people do it
the same way, and c) everyone insists that they're right.

I'm going to put c) to rest -- there's no way in hell mine is the right answer.
But it's **my** answer, dammit, so here it is.

Also, I'm tired of having to perpetually rewrite configuration files as I break
and rebuild machines and systems.

## Target Systems

Translation: Systems I use and of which I can feign knowledge.

- Arch Linux
- OSX
- Cygwin

## Target Software

Translation: same as above

- `tmux`
- `git`
- `zsh`
- ugh, fine, `bash`, kinda
- `ssh`

## Usage instructions

If you're not me, think good and hard before you use this. Seriously. If you're
more experienced than me, this is a caveman's stone axe. If you're less
experienced than me, get out of Jung's Cave and do it yourself for a while.
Then either write your own version of this or use one by someone who's actually
good.

### Layout

```
.
└── <component>
    ├── info.toml
    ├── [configuration files]
    ├── [shell scripts]
    └── [systemd units]
```

Each component has its own directory containing a required `info.toml` file and


## Goals

- Idempotent. Seriously.
- Modular as hell
- SAFE. No clobbering existing files.
- Tweakable. Different machines need different values. Don't be the Borg.
- Runnable out of the box. Might not be guaranteed right now, because I'm using
    Ruby (and a Gem too, even), but who doesn't have Ruby these days?
