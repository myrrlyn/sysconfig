# This is the first file every zsh reads

# Arch Linux doesn't even *have* /bin, /sbin, /lib, or /lib64
# Also, PATH can be set as an array of uniques, and zsh will handle adding
# to it and exporting it as the :-string when ready.
typeset -U path
typeset -U PATH
path=(/usr/local/sbin /usr/local/bin /usr/bin)
# If this is installed on a system that *does* have /sbin and /bin, add them too
for DIR in /sbin /bin ; do
	[[ ! -h $DIR ]] && path+=$DIR
done
