---
title: Download
---

xmonad comes in two parts.

*   The _core_ package includes all you need to get up and running with a minimalist window manager.
*   The _contrib_ package contains hundreds of _extensions_ that can enhance the functionality of xmonad.


## BSD/Linux distributions

xmonad is included in many distributions' package repositories. See if yours is one:

<div class="list-col-4" markdown="1">

*   [OpenBSD](https://www.openbsd.org/cgi-bin/cvsweb/ports/x11/xmonad/)
*   [NetBSD](https://pkgsrc.se/wm/xmonad)
*   [FreeBSD](https://www.freshports.org/x11-wm/hs-xmonad/)
*   [Gentoo](https://packages.gentoo.org/packages/x11-wm/xmonad)
*   [Debian](https://packages.debian.org/xmonad)
*   [Ubuntu](https://packages.ubuntu.com/search?keywords=xmonad)
*   [Arch](https://www.archlinux.org/packages/community/x86_64/xmonad/)
*   [Fedora](https://src.fedoraproject.org/rpms/xmonad)
*   [Gobo](https://github.com/gobolinux/Recipes/tree/master/XMonad)
*   [NixOS](https://search.nixos.org/packages?channel=20.09&from=0&size=30&sort=relevance&query=xmonad)
*   [Source Mage](http://codex.sourcemage.org/stable/windowmanagers/xmonad/)
*   [Slackware](https://slackbuilds.org/result/?search=xmonad&sv=)

</div>
If you think a distribution is missing from this list, [let us know](https://www.haskell.org/mailman/listinfo/xmonad).

## Notes for Debian/Ubuntu users:

On debian, xmonad is split into _three_ packages, and it might not be obvious what they do.

*   <kbd>xmonad</kbd> lets you run xmonad in its _default_ configuration.
*   <kbd>libghc-xmonad-dev</kbd> lets you write a configuration file using _core_ functionality.
*   <kbd>libghc-xmonad-contrib-dev</kbd> includes all of the _contrib_ modules.


## From tarball

If you prefer to build on your own, you can get the official releases from hackage:

*   [core](https://hackage.haskell.org/package/xmonad)
*   [contrib](https://hackage.haskell.org/package/xmonad-contrib)

After you've downloaded, follow the [install instructions](install-instructions.html) and read the [documentation](documentation.html) on how to configure xmonad.

## From git

Keep on the bleeding edge by tracking xmonad development:

```
git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib
```

You will need [git](https://git-scm.com/) to check out the code. From there, follow the [install instructions](install-instructions.html) just as with the tarball.

Alternatively, you can install the latest git revision as follows:

```
cabal install https://github.com/xmonad/xmonad/archive/master.tar.gz
cabal install https://github.com/xmonad/xmonad-contrib/archive/master.tar.gz
```

## Related tools

Here are some tools we've found work well with xmonad:

*   [dmenu](https://tools.suckless.org/dmenu/), a program launcher
*   [dzen](https://robm.github.io/dzen/), an extensible status bar
*   [xmobar](https://hackage.haskell.org/package/xmobar), an extensible status bar
*   [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html), a better terminal
