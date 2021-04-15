---
title: About
---


Xmonad is a _tiling window manager_ for X. Windows are arranged automatically to tile the screen without gaps or overlap, maximising screen use. All features of the window manager are accessible from the keyboard: a mouse is strictly optional. Xmonad is written and extensible in [Haskell](https://haskell.org). Custom layout algorithms, and other extensions, may be written by the user in config files. Layouts are applied dynamically, and different layouts may be used on each workspace. A guiding principle of the user interface is _predictability_: users should know in advance precisely the window arrangement that will result from any action, leading to an intuitive user interface.

#### Features

*   Very stable, fast, small and simple.
*   Tiny code base (~1000 lines of Haskell)
*   Automatic window tiling and management
*   First class keyboard support: a mouse is unnecessary
*   Full support for tiling windows on multi-head displays
*   Full support for floating, tabbing and decorated windows
*   Full support for [GNOME](https://haskell.org/haskellwiki/Xmonad/Using_xmonad_in_Gnome) and [KDE](https://haskell.org/haskellwiki/Xmonad/Using_xmonad_in_KDE) utilities
*   XRandR support to rotate, add or remove monitors
*   Per-workspace layout algorithms
*   Per-screens custom status bars
*   Compositing support
*   Powerful, stable customisation and on-the-fly reconfiguration
*   Large [extension library](https://hackage.haskell.org/package/xmonad-contrib)
*   Excellent, extensive [documentation](https://hackage.haskell.org/package/xmonad)
*   Large, active development team, support and community
*   Watch some [videos of xmonad](videos.html) and follow us on [twitter](https://twitter.com/xmonad)

#### Tiling the screen

Xmonad provides three tiling algorithms by default: _tall_, _wide_ and _fullscreen_. In tall or wide mode, all windows are visible and tiled to fill the plane without gaps. In fullscreen mode only the focused window is visible, filling the screen. Alternative tiling algorithms (and much more) are provided as [extensions](https://hackage.haskell.org/package/xmonad-contrib). Sets of windows are grouped together on virtual _workspaces_ and each workspace retains its own layout. Multiple physical monitors are supported via Xinerama, allowing simultaneous display of several workspaces.

#### Simple and Flexible

Adhering to a minimalist philosophy of doing one job, and doing it well, the entire code base remains tiny, and is written to be simple to understand and modify. By using Haskell as a configuration language arbitrarily complex extensions may be implemented by the user using a powerful `scripting' language, without needing to modify the window manager directly. For example, users [may write](https://hackage.haskell.org/package/xmonad-contrib) their own tiling algorithms, in Haskell, in their config files.

#### Policies and High Assurance

From the outset correctness and robustness have been a goal of the project. Using a combination of static and dynamic techniques, a wide range of errors are prevented and checkable, leading to better, cleaner code, and a more stable application. In particular, the expressive Haskell type system is used to prevent certain classes of bugs, while type-based automatic testing and [verification tools](https://webspace.science.uu.nl/~swier004/publications/2012-haskell.pdf), are used to ensure the user interface [policies](https://code.haskell.org/xmonad/tests/Properties.hs) are correct (for example, that a layout algorithm never produces gaps or overlapping windows, or that window manager actions never produce an inconsistent internal state).
