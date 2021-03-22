---
title: Install Instructions
---

xmonad is a _tiling window manager_ for X11\. This document describes how to build and install xmonad. For its features and use, see the [guided tour](./tour.html).

### Use a pre-built binary

Your operating system distribution may have binary packages for xmonad already, or perhaps, many of their dependencies. If at all possible, use one of these pre-built packages. See the [main page](index.html) for distributions that distribute xmonad binaries.

Building xmonad from source is simple. It requires a basic Haskell toolchain, only. We'll now walk through the complete list of toolchain dependencies.

### Install GHC

To build xmonad, you need the GHC Haskell compiler installed. All common operating systems provide prebuilt binaries of GHC in their package systems. For example, in Debian you would install GHC with:

```
$ apt-get install ghc
```

If your operating system's package system doesn't provide a binary version of GHC, you can find pre-built binaries at the [GHC home page](http://haskell.org/ghc). It shouldn't be necessary to compile GHC from source -- every common system has a pre-build binary version.

We recommend the latest stable release of GHC.

### X11 libraries

Since you're building an X application, you'll need the C X11 library headers. On many platforms, these come pre-installed. For others, such as Debian, you can get them from your package manager:

```
    $ apt-get install libx11-dev
```

Typically you need the C libraries: libXinerama libXext libX11

<div id="cabal-install">

### Cabal-install

</div>

Recent versions of [Cabal](http://haskell.org/cabal) provide a tool, [cabal-install](http://hackage.haskell.org/package/cabal-install), which automates the building of Haskell libraries, including gathering all dependencies. Your distribution may have a binary package for cabal-install, in which case you should use that. Otherwise the following steps will install it:

*   Download [cabal install](http://hackage.haskell.org/package/cabal-install)
*   Run the bootstrap script to install cabal-install with all of it's dependencies into your home directory.

    ```
    $ tar xzf cabal-install-1.24.0.2.tar.gz
    $ cd cabal-install-1.24.0.2/
    $ ./bootstrap.sh
    ```

*   Add ~/.cabal/bin to your $PATH

```
$ echo "export PATH=$PATH:~/.cabal/bin" >> ~/.profile
```

Once you have a working cabal-install, you can then simply install any Haskell package you find on [hackage.haskell.org](http://hackage.haskell.org), such as xmonad, xmonad-contrib or xmobar:

```
$ cabal install xmonad
```

#### Note

xmonad-contrib requires you to install libxft C headers, unless you install it without xft support:

```
$ cabal install xmonad-contrib --flags="-use_xft"
```

### If things go wrong..

From time to time people have build problems. Almost always this is due to missing dependencies. Sometimes it is due to problems with the tool chain. The most common problems building xmonad are documented in the [FAQ](http://haskell.org/haskellwiki/Xmonad/Frequently_asked_questions):

*   [What build dependencies do I need?](http://haskell.org/haskellwiki/Xmonad/Frequently_asked_questions#What_build_dependencies_does_xmonad_have.3F)
*   [Can I install without root permission?](http://haskell.org/haskellwiki/Xmonad/Frequently_asked_questions#Can_I_install_without_root_permission.3F)
*   [X11 fails to find libX11 or libXinerama](http://haskell.org/haskellwiki/Xmonad/Frequently_asked_questions#X11_fails_to_find_libX11_or_libXinerama)
*   [xmonad does not detect my multi-head setup](http://haskell.org/haskellwiki/Xmonad/Frequently_asked_questions#xmonad_does_not_detect_my_multi-head_setup)
*   [Cabal: Executable stanza starting with field ...](http://haskell.org/haskellwiki/Xmonad/Frequently_asked_questions#Cabal:_Executable_stanza_starting_with_field_.27flag_small_base_description.27)

If this doesn't help, try asking on the IRC channel, #xmonad @ freenode.org, or on the mailing list.

#### Grab dmenu and dzen

Extra programs that make life with xmonad more exciting: dmenu and dzen. dmenu provides a simple popup menu for launching programs, dzen provides customisable status bars. You can get them here:

*   [dzen](http://gotmor.googlepages.com/dzen)
*   [dmenu](https://tools.suckless.org/dmenu/)


#### Starting xmonad


The simplest way to start xmonad is to modify your .xsession or .xinitrc and add the line:

```
exec xmonad
```

as the last line of your file, commenting out any previous window manager. Now, when you log in to X, xmonad will start, (by default in tall tiling mode, with no status bar), and you'll be presented with an empty screen:

[![no windows open]({{site.url}}/images/overview/empty.png)]({{site.url}}/images/overview/large/empty.png)

From here, and assuming you can find the **mod1** modifier key (usually 'alt'), you can launch clients and access the rest of the window manager's features. Refer to the [manual page](./manpage.html), or the [cheatsheet](http://haskell.org/haskellwiki/Image:Xmbindings.png)
