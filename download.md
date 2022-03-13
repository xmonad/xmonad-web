---
---

# Download

xmonad comes in two parts.

* The _core_ package includes all you need to get up and running with a minimalist window manager.
* The _contrib_ package contains hundreds of _extensions_ that can enhance the functionality of xmonad.

## BSD/Linux distributions

xmonad is included in many distributions' package repositories. See if yours is one:

<div class="list-col-4" markdown="1">
* [OpenBSD](https://cvsweb.openbsd.org/ports/x11/xmonad/)
* [NetBSD](https://pkgsrc.se/wm/xmonad)
* [FreeBSD](https://www.freshports.org/x11-wm/hs-xmonad/)
* [Gentoo](https://packages.gentoo.org/packages/x11-wm/xmonad)
* [Debian](https://packages.debian.org/xmonad)
* [Ubuntu](https://packages.ubuntu.com/search?keywords=xmonad)
* [Arch](https://www.archlinux.org/packages/community/x86_64/xmonad/)
* [Fedora](https://src.fedoraproject.org/rpms/xmonad)
* [Gobo](https://github.com/gobolinux/Recipes/tree/master/XMonad)
* [NixOS](https://search.nixos.org/packages?channel=20.09&from=0&size=30&sort=relevance&query=xmonad)
* [Source Mage](http://codex.sourcemage.org/stable/windowmanagers/xmonad/)
* [Slackware](https://slackbuilds.org/result/?search=xmonad&sv=)
</div>

If you think a distribution is missing from this list, [let us know](https://github.com/xmonad/xmonad-web/issues).

## Notes for Debian/Ubuntu users:

On debian, xmonad is split into _three_ packages, and it might not be obvious what they do.

* `xmonad` lets you run xmonad in its _default_ configuration.
* `libghc-xmonad-dev` lets you write a configuration file using _core_ functionality.
* `libghc-xmonad-contrib-dev` includes all of the _contrib_ modules.

## From git

Keep on the bleeding edge by tracking xmonad development:

```
git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib
```

You will need [git](https://git-scm.com/) to check out the code.
Follow the [install instructions](INSTALL.md) and
[documentation](documentation.md) to build, set up and configure xmonad.

## Related tools

Here are some tools we've found work well with xmonad:

* program launchers:
  * [dmenu](https://tools.suckless.org/dmenu/)
  * [rofi](https://github.com/davatorium/rofi)
* status bars:
  * [dzen](https://robm.github.io/dzen/)
  * [xmobar](https://github.com/jaor/xmobar)
  * [taffybar](https://github.com/taffybar/taffybar)
  * [polybar](https://github.com/polybar/polybar)
  * [cnx](https://github.com/mjkillough/cnx)
* systrays:
  * [trayer](https://github.com/sargon/trayer-srg)
  * [stalonetray](https://kolbusa.github.io/stalonetray/)
  * [gtk-sni-tray](https://github.com/taffybar/gtk-sni-tray)
* terminals:
  * [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html)
  * [alacritty](https://github.com/alacritty/alacritty)
