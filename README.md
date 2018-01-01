## help-deprecate-net-tools

[![Build Status](https://travis-ci.org/solarkennedy/help-deprecate-net-tools.svg?branch=master)](https://travis-ci.org/solarkennedy/help-deprecate-net-tools)

This is a set of bash functions to help users transition from the deprecated
`net-tools` package to more modern utilities. Simply source this file in a
shell to use them:

    source help-deprecate-net-tools.sh

Or put them in /etc/profile to get them installed for all users globally:

    sudo cp help-deprecate-net-tools.sh /etc/profile.d/

**Note:** `help-deprecate-net-tools.sh` should only ever be used on interactive
shells (`profile.d`, `.bash_profile`, etc) so that it does not interfere
(break) with non-interactive shell scripts.

### Background

Did you know that the `net-tools` commands (`ifconfig`, `route`, `arp`, etc)
have been officially deprecated since
[March 2009](https://lists.debian.org/debian-devel/2009/03/msg00780.html)?

While they may be technically deprecated, I personally still (currently) use
those commands often. But I would like to learn the modern equivalents!

But there is the issue of "muscle memory". I think the best way to learn to
these new tools is to literally type them. To that end,
`help-deprecate-net-tools` doesn't run the replacement command, but it does
tell you what it is, and expects you to manually type in the replacement
command.

However, sometimes you don't have time to muck around with things and you need
to run the right `netstat` command *now*. For that, this package will also give
you the full path to the real (deprecated) command so you can get your job
done.

### Acknowledgements

This work is heavily based on the research of Doug Vitale on
[this blog post](https://dougvitale.wordpress.com/2011/12/21/deprecated-linux-networking-commands-and-their-replacements/).

### On wireless-tools (iwconfig, etc) deprecation

Although iwconfig is not part of `net-tools` (it is part of `wireless-tools`),
I still consider it part of this effort. I can't find the official notice of
deprecation though. Here are some hints:

* [RedHat notice of deprecation](https://access.redhat.com/solutions/1194553)
* [Linux docs for replacement iw commands](https://wireless.wiki.kernel.org/en/users/documentation/iw/replace-iwconfig)


### Example

```
ifconfig eth0 -arp
The 'ifconfig' command has been deprecated, try typing:

    ip link set arp off dev eth0

If you need to run the command exactly, you can use the full path:

    /sbin/ifconfig eth0 -arp
```

### Tool Support

Where "support" means that `help-deprecate-net-tools` provides reasonably good
replacement command suggestions:

- [X] `arp`
- [X] `ifconfig`
- [X] `iptunnel`
- [X] `iwconfig`
- [X] `nameif`
- [X] `netstat`
- [X] `route`
- [X] `ipmaddr`
- [X] `mii-tool`

### Improvements

These helpers are not complete and contain inaccuracies and bugs. Please make a pull request!
