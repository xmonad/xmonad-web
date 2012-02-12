import Text.RSS
import Network.URI
import System.Time
import System.Time.Parse
import System.Locale
import System.IO

Just homepage = parseURI "http://xmonad.org"
Just logo     = parseURI "http://xmonad.org/images/logo.png"
Just newspage = parseURI "http://xmonad.org/news.html"

main = do
   time <- getClockTime >>= toCalendarTime
   putStrLn . showXML . rssToXML $
    RSS "xmonad: a tiling window manager"
        homepage
        "News about the xmonad window manager"

        [Language "en"
        ,Copyright "(c) Don Stewart 2007-2008"
        ,ManagingEditor "xmonad@haskell.org (Don Stewart)"
        ,WebMaster "xmonad@haskell.org (Don Stewart)"
        ,ChannelPubDate time
        ,LastBuildDate  time
        ,Generator "Haskell rss-3000.0.1"
        ,TTL (60*24)
        ,Image logo
               "xmonad: a tiling window manager"
               homepage
               Nothing Nothing Nothing
        ]

        (articles (mkItem time))

mkItem realtime n timestr title text =
        [ Title title
        , let Just link = parseURI ("http://xmonad.org/news.html#" ++ show n)
          in Link link

        , PubDate (case parseCalendarTime defaultTimeLocale "%a %b %e %H:%M:%S %Z %Y" timestr of
                        Nothing -> realtime
                        Just t  -> t
                )
        , Guid True ("http://xmonad.org/news.html#" ++ show n)
        , Description text
        , Author "xmonad@haskell.org (Don Stewart)" ]

articles item =
    [

      (item 6 "Tue Apr  1 10:36:17 PDT 2008"
             "GNOME 3.0 to support tiling window management out of the box!"
             "<p> The <a href=\"http://xmonad.org/\">xmonad</a> project, the world's most popular purely functional window manager, is pleased to announce an exciting new collaboration with The Free Software Desktop Project, creators of the well-known <A href=\"http://www.gnome.org/\">GNOME</a> desktop suite, to enhance and improve the core GNOME system with a focus on the upcoming GNOME 3.0 release.  </p> <p> Addressing the concerns of GNOME users seeking better space utilisation for window clients and less dependence on the mouse than existing GNOME-compliant window managers provide, the new GNOME 3.0 release will include a modified Metacity window manager based on xmonad's \"<a href=\"http://xmonad.org/xmonad-docs/xmonad/XMonad-StackSet.html#1\">StackSet</a>\" framework for window tiling. Founded on a theory of <a href=\"http://en.wikipedia.org/wiki/Zipper_(data_structure)\">generalised derivatives</a> of datatypes, the tiling window management model is expected to produce obvious improvements in productivity, scalability and ease of use for GNOME users.  </p> <p> This transition to a \"tiling-by-default\" approach marks a turning point in the history of the open source user interfaces, as the desktop metaphor for user interaction is replaced by a more efficient \"Rubik's cube\" model of window/workspace arrangment.  </p> <p> The xmonad developers, along with Tuomo \"tuomov\" Valkonen of related Ion window manager project, will also be working closely with the GNOME team helping transition GNOME to new core components written in Haskell, upon which a more robust, maintainable GNOME core will rely. This is expected to greatly enhance the long term stability, performance and ease of development of GNOME as GNOME developers are able to take advantage of powerful user interface tools based on reactive programming, lazy evaluation, co-monadic effects and delimited continuations, previously unavailable to people who's name wasn't \"Oleg\".  </p> <p> The resulting combined GNOME/xmonad code base will also, of course, benefit the xmonad project too, with new Perl, Python and C# components from GNOME finding their way back into the xmonad codebase, greatly increasing the feature range of xmonad, even for those users not using GNOME components. By integrating Python and Perl support directly into xmonad's core, developers will be able to smoothly script and extend the standalone xmonad system without worrying about complicated type errors slowing down development and preventing the impossible from happening.  </p> <p> We hope our users are as excited as the dev team about this new collaboration, and expect to see lots of cool new features appearing in the GNOME and xmonad codebases soon!  </p> "
      ),

      (item 5 "Sat Mar 29 14:29:07 PDT 2008"
             "xmonad 0.7 released!"
             "<p>The xmonad dev team is pleased to announce <a href=\"http://xmonad.org\">xmonad 0.7</a>!</p> <p> The 0.7 release of xmonad provides several improvements over 0.6, including improved <a href=\"http://haskell.org/haskellwiki/Xmonad/Using_xmonad_in_Gnome\">integration with GNOME</a>, more flexible \"rules\", various stability fixes, and of course, many new and interesting extensions in the extension library (general support for window decorations, utf8 support, scratch pad terminals, pointer control) and <a href=\"http://www.haskell.org/haskellwiki/Xmonad/Notable_changes_since_0.6\">more</a>!  </p> <p> In the past year, the xmonad development team received contributions from over 60 developers, making xmonad one of the largest window manager development teams around, and dwarfing other tiling window manager projects. Yet, at the same time, the core code base remains at around 1000 lines of code, with another 7000 lines in the extension library -- a significant achievment! Thank you all.  </p> <p> And some recent xmonad articles and video worth a look: </p> <ul> <li><a href=\"http://byorgey.wordpress.com/2008/03/27/fringedc-talk/\">xmonad at FringeDC :: Video</a></li> <li><a href=\"http://www.dougalstanton.net/blog/index.php/2008/03/28/interesting-aspects-of-xmonad\">Interesting aspects of xmonad</a></li> <li><a href=\"http://dev.compiz-fusion.org/~wfarr/viewpost?id=5\">Leaving wmii for xmonad</a></li> <li><a href=\"http://gnuvince.wordpress.com/2008/03/10/trying-xmonad/\">A review of xmonad</a></li> </ul> "
      ),

      (item 4 "Sun Jan 27 14:50:21 PST 2008"
             "xmonad 0.6 released!"
             "<p>The xmonad dev team is pleased to announce the 0.6 release of <a href=\"http://xmonad.org\">xmonad</a>! This is an incremental release of xmonad, with some new features, and important bug fixes, so we recommend upgrading to 0.6 if you're an xmonad 0.5 user. New features include: focus-follows-mouse is configurable, cloned screens are supported, and better support for docked apps.  Many new extension modules have been written, as usual.  The release can be found at <a href=\"http://xmonad.org\">xmonad.org</a>, with full documentation on installation, configuration and extension of your favourite tiling window manager. There are also changelogs for the <a href=\"http://xmonad.org/changelog-0.6.txt\">core</a> and <a href=\"http://xmonad.org/changelog-xmc-0.6.txt\">extension library</a>.</p>" 
      ),


      (item 3 "Sat Dec 15 16:15:12 PST 2007"
              "xmonad 0.5 packages"
              "<p> The package maintainers have been hard at work this week, packaging up the new xmonad 0.5 for various distros. Packages are very important, as they make it a lot easier to get a Haskell toolchain into place. So far the following agile distros ;) have packaged xmonad 0.5: </p> <ul> <li> <a href=\"http://aur.archlinux.org/packages.php?do_Details=1&ID=10593\">Arch</a> </li> <li> <a href=\"http://packages.gentoo.org/package/xmonad\">Gentoo</a> </li> <li> <a href=\"http://pkgsrc.se/wip/xmonad\">NetBSD</a> </li> </ul> <p> While the following have xmonad 0.4 or earlier: </p> <ul> <li> <a href=\"http://ports.openbsd.nu/x11/xmonad\">OpenBSD</a> </li> <li> <a href=\"http://www.freshports.org/x11-wm/xmonad/\">FreeBSD</a> </li> <li> <a href=\"http://packages.debian.org/sid/xmonad\">Debian</a> </li> <li> <a href=\"http://packages.ubuntu.com/hardy/source/xmonad\">Ubuntu</a> </li> <li> <a href=\"http://recipes.gobolinux.org/r/?list=XMonad\">GoboLinux</a> </li> <li> <a href=\"http://distro.ibiblio.org/pub/linux/distributions/sourcemage/grimoire/codex/stable/windowmanagers/xmonad/\">Source Mage</a> </li> </ul> <p> Other well known distributions appear not to have xmonad at all - for shame!  xmonad's success relies much on the ability for users to install from their package system, so if you're able to package xmonad for your platform, please do so!  </p>"),

      (item 2 "Sun Dec  9 15:56:46 PST 2007"
             "xmonad 0.5 released!"
             "<p>The xmonad dev team is pleased to announce the 0.5 release of <a href=\"http://xmonad.org\">xmonad</a>! xmonad 0.5 is a major release of xmonad, allowing, for the first time, dynamic extension in Haskell without requiring recompilation. Extension and configuration of xmonad is now faster, simpler, and more flexible. All configuration is done via the ~/.xmonad/xmonad.hs file. Example config files and screenshots are available on <a href=\"http://haskell.org/haskellwiki/Xmonad/Config_archive\">the wiki</a>. This release marks the final break from its dwm origins. As a result, xmonad is now also much easier to package, distribute and extend, as recompilation of xmonad is not required to extend it.</p><p>As usual with xmonad, the new release comes with <a href=\"http://hackage.haskell.org/cgi-bin/hackage-scripts/package/xmonad-contrib-0.5\">a large library</a> of extensions you can use in your config files.  Highlights include status bars, shell prompts, emulation of dwm, wmii and ion behaviour, and alternative window layout algorithms.  Check out <a href=\"http://xmonad.org/xmonad-docs/xmonad-contrib/\">the extension documentation</a> for more info. </p><p> More information, screenshots, documentation, tutorials and community resources are available from the <a href=\"http://xmonad.org\">xmonad home page</a>. The 0.5 release, extensions and dependencies, are available from <a href=\"http://hackage.haskell.org/cgi-bin/hackage-scripts/package/xmonad\">hackage.haskell.org</a>.</p><p>  Enjoy, and happy tiling!</p>"),

      (item 1 "Thu Dec  6 15:22:50 PST 2007"
             "Arch Linux xmonad community"
             "The Arch Linux guys have created <a href=\"http://bbs.archlinux.org/viewtopic.php?pid=305112\">a forum</a> for discussing and using xmonad on Arch. A good place to toss around hints and tips for xmonad on that platform."),

      (item 0 "Wed Dec  5 18:20:51 PST 2007"
             "xmonad 0.5 release candidates"
            "xmonad 0.5 release candidates are now available for those into beta testing.  Download <a href=\"http://xmonad.org/xmonad-0.4.20071204.tar.gz\">xmonad</a> and <a href=\"http://xmonad.org/xmonad-contrib-0.4.20071204.tar.gz\">xmonad-contrib</a> here.  You'll need X11 1.4 from hackage.haskell.org. These bundles should work fine with ghc 6.6 or ghc 6.8, and they use the new ~/.xmonad/ configuration system.  Documentation isn't up yet, so drop by the IRC channel if you get stuck.  The more testing, the better the release!")

    ]
