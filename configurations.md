---
---

# User Configuration Files

<div class="row">
<div class="col-lg" markdown="1">

## Developer Configurations

Below are the configurations of a few of xmonad's maintainers.  Just
keep in mind that these setups are very customized and perhaps a little
bit hard to replicate (some may rely on features only available in
personal forks or git), may or may not be documented, and most aren't
very pretty either :)

<div class="list-col-4" markdown="1">
  - [byorgey](https://github.com/byorgey/dotfiles)
  - [geekosaur](https://github.com/geekosaur/xmonad.hs/tree/pyanfar)
  - [liskin](https://github.com/liskin/dotfiles/tree/home/.xmonad)
  - [psibi](https://github.com/psibi/dotfiles/tree/master/xmonad)
  - [slotThe](https://gitlab.com/slotThe/dotfiles/-/tree/master/xmonad/.config/xmonad)
  - [TheMC47](https://github.com/TheMC47/dotfiles/tree/master/xmonad/.xmonad)
</div>

## Legacy Configurations

These are currently part of the `xmonad-contrib` package but will be
removed at some point in the future.  People importing them should copy
the relevant functions into their own configurations.

### XMonad.Config.Arossato

<details markdown=1>
  <summary>xmonad.hs</summary>

``` haskell
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  XMonad.Config.Arossato
-- Description :  Andrea Rossato's xmonad configuration.
-- Copyright   :  (c) Andrea Rossato 2007
-- License     :  BSD3-style (see LICENSE)
--
-- Maintainer  :  andrea.rossato@unibz.it
-- Stability   :  stable
-- Portability :  portable
--
-- This module specifies my xmonad defaults.
--
------------------------------------------------------------------------

module XMonad.Config.Arossato
    ( -- * Usage
      -- $usage
      arossatoConfig
    ) where

import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W

import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog hiding (xmobar)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ServerMode
import XMonad.Layout.Accordion
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowArranger
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.Theme
import XMonad.Prompt.Window
import XMonad.Prompt.XMonad
import XMonad.Util.Run
import XMonad.Util.Themes

-- $usage
-- The simplest way to use this configuration module is to use an
-- @~\/.xmonad\/xmonad.hs@ like this:
--
-- > module Main (main) where
-- >
-- > import XMonad
-- > import XMonad.Config.Arossato (arossatoConfig)
-- >
-- > main :: IO ()
-- > main = xmonad =<< arossatoConfig
--
-- NOTE: that I'm using xmobar and, if you don't have xmobar in your
-- PATH, this configuration will produce an error and xmonad will not
-- start. If you don't want to install xmobar get rid of this line at
-- the beginning of 'arossatoConfig'.
--
-- You can use this module also as a starting point for writing your
-- own configuration module from scratch. Save it as your
-- @~\/.xmonad\/xmonad.hs@ and:
--
-- 1. Change the module name from
--
-- > module XMonad.Config.Arossato
-- >     ( -- * Usage
-- >       -- $usage
-- >       arossatoConfig
-- >     ) where
--
-- to
--
-- > module Main where
--
-- 2. Add a line like:
--
-- > main = xmonad =<< arossatoConfig
--
-- 3. Start playing with the configuration options...;)

arossatoConfig = do
    xmobar <- spawnPipe "xmobar" -- REMOVE this line if you do not have xmobar installed!
    return $ def
         { workspaces         = ["home","var","dev","mail","web","doc"] ++
                                map show [7 .. 9 :: Int]
         , logHook            = myDynLog xmobar -- REMOVE this line if you do not have xmobar installed!
         , manageHook         = newManageHook
         , layoutHook         = avoidStruts $
                                decorated        |||
                                noBorders mytabs |||
                                otherLays
         , terminal           = "urxvt +sb"
         , normalBorderColor  = "white"
         , focusedBorderColor = "black"
         , keys               = newKeys
         , handleEventHook    = serverModeEventHook
         , focusFollowsMouse  = False
         }
    where
      -- layouts
      mytabs    =       tabbed shrinkText (theme smallClean)
      decorated = simpleFloat' shrinkText (theme smallClean)
      tiled     = Tall 1 (3/100) (1/2)
      otherLays = windowArrange   $
                  magnifier tiled |||
                  noBorders Full  |||
                  Mirror tiled    |||
                  Accordion

      -- manageHook
      myManageHook  = composeAll [ resource =? "win"          --> doF (W.shift "doc") -- xpdf
                                 , resource =? "firefox-bin"  --> doF (W.shift "web")
                                 ]
      newManageHook = myManageHook

      -- xmobar
      myDynLog    h = dynamicLogWithPP def
                      { ppCurrent = xmobarColor "yellow" "" . wrap "[" "]"
                      , ppTitle   = xmobarColor "green"  "" . shorten 40
                      , ppVisible = wrap "(" ")"
                      , ppOutput  = hPutStrLn h
                      }

      -- key bindings stuff
      defKeys    = keys def
      delKeys x  = foldr M.delete           (defKeys x) (toRemove x)
      newKeys x  = foldr (uncurry M.insert) (delKeys x) (toAdd    x)
      -- remove some of the default key bindings
      toRemove x =
          [ (modMask x              , xK_j)
          , (modMask x              , xK_k)
          , (modMask x              , xK_p)
          , (modMask x .|. shiftMask, xK_p)
          , (modMask x .|. shiftMask, xK_q)
          , (modMask x              , xK_q)
          ] ++
          -- I want modMask .|. shiftMask 1-9 to be free!
          [(shiftMask .|. modMask x, k) | k <- [xK_1 .. xK_9]]
      -- These are my personal key bindings
      toAdd x   =
          [ ((modMask x              , xK_F12   ), xmonadPrompt      def                 )
          , ((modMask x              , xK_F3    ), shellPrompt       def                 )
          , ((modMask x              , xK_F4    ), sshPrompt         def                 )
          , ((modMask x              , xK_F5    ), themePrompt       def                 )
          , ((modMask x              , xK_F6    ), windowPrompt def Goto  allWindows     )
          , ((modMask x              , xK_F7    ), windowPrompt def Bring allWindows     )
          , ((modMask x              , xK_comma ), prevWS                                )
          , ((modMask x              , xK_period), nextWS                                )
          , ((modMask x              , xK_Right ), windows W.focusDown                   )
          , ((modMask x              , xK_Left  ), windows W.focusUp                     )
          -- other stuff: launch some useful utilities
          , ((modMask x              , xK_F2    ), spawn "urxvt -fg white -bg black +sb" )
          , ((modMask x .|. shiftMask, xK_F4    ), spawn "~/bin/dict.sh"                 )
          , ((modMask x .|. shiftMask, xK_F5    ), spawn "~/bin/urlOpen.sh"              )
          , ((modMask x .|. shiftMask, xK_t     ), spawn "~/bin/teaTime.sh"              )
          , ((modMask x              , xK_c     ), kill                                  )
          , ((modMask x .|. shiftMask, xK_comma ), sendMessage (IncMasterN   1 )         )
          , ((modMask x .|. shiftMask, xK_period), sendMessage (IncMasterN (-1))         )
          -- commands fo the Magnifier layout
          , ((modMask x .|. controlMask              , xK_plus ), sendMessage MagnifyMore)
          , ((modMask x .|. controlMask              , xK_minus), sendMessage MagnifyLess)
          , ((modMask x .|. controlMask              , xK_o    ), sendMessage ToggleOff  )
          , ((modMask x .|. controlMask .|. shiftMask, xK_o    ), sendMessage ToggleOn   )
          -- windowArranger
          , ((modMask x .|. controlMask              , xK_a    ), sendMessage  Arrange           )
          , ((modMask x .|. controlMask .|. shiftMask, xK_a    ), sendMessage  DeArrange         )
          , ((modMask x .|. controlMask              , xK_Left ), sendMessage (DecreaseLeft   10))
          , ((modMask x .|. controlMask              , xK_Up   ), sendMessage (DecreaseUp     10))
          , ((modMask x .|. controlMask              , xK_Right), sendMessage (IncreaseRight  10))
          , ((modMask x .|. controlMask              , xK_Down ), sendMessage (IncreaseDown   10))
          , ((modMask x .|. shiftMask                , xK_Left ), sendMessage (MoveLeft       10))
          , ((modMask x .|. shiftMask                , xK_Right), sendMessage (MoveRight      10))
          , ((modMask x .|. shiftMask                , xK_Down ), sendMessage (MoveDown       10))
          , ((modMask x .|. shiftMask                , xK_Up   ), sendMessage (MoveUp         10))
          -- gaps
          , ((modMask x                              , xK_b    ), sendMessage  ToggleStruts      )

          ] ++
          -- Use modMask .|. shiftMask .|. controlMask 1-9 instead
          [( (m .|. modMask x, k), windows $ f i)
           | (i, k) <- zip (workspaces x) [xK_1 .. xK_9]
          ,  (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask .|. controlMask)]
          ]
```

</details>

### XMonad.Config.Dmwit

<details markdown=1>
  <summary>xmnad.hs</summary>

{% raw %}

``` haskell
-- boilerplate {{{
{-# LANGUAGE ExistentialQuantification, NoMonomorphismRestriction, TypeSynonymInstances, ViewPatterns, LambdaCase #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-type-defaults #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  XMonad.Config.Dmwit
-- Description :  Daniel Wagner's xmonad configuration.
--
------------------------------------------------------------------------
module XMonad.Config.Dmwit where

-- system imports
import Control.Monad.Trans
import Data.Map (Map, fromList)
import Data.Ratio
import Data.Word
import GHC.Real
import System.Environment
import System.Exit
import System.IO
import System.Process

-- xmonad core
import XMonad
import XMonad.StackSet hiding (workspaces)

-- xmonad contrib
import XMonad.Actions.SpawnOn
import XMonad.Actions.Warp
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Grid
import XMonad.Layout.IndependentScreens hiding (withScreen)
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Prelude
import XMonad.Util.Dzen hiding (x, y)
import XMonad.Util.SpawnOnce
-- }}}
-- volume {{{
outputOf :: String -> IO String
outputOf s = do
    uninstallSignalHandlers
    (hIn, hOut, hErr, p) <- runInteractiveCommand s
    mapM_ hClose [hIn, hErr]
    hGetContents hOut <* waitForProcess p <* installSignalHandlers

geomMean :: Floating a => [a] -> a
geomMean xs = product xs ** (recip . fromIntegral . length $ xs)

arithMean :: Floating a => [a] -> a
arithMean xs = sum xs / fromIntegral (length xs)

namedNumbers n s = do
    l <- lines s
    guard (sentinel `isPrefixOf` l)
    return (drop (length sentinel) l)
    where sentinel = n ++ " #"

-- Data.List.Split.splitOn ":", but without involving an extra dependency
splitColon xs = case break (==':') xs of
    (a, ':':b) -> a : splitColon b
    (a, _)     -> [a]

parse s = arithMean $ do
    l <- lines s
    guard ("\tVolume: " `isPrefixOf` l)
    part <- splitColon l
    (n,'%':_) <- reads part
    return n

modVolume :: String -> Integer -> IO Double
modVolume kind n = do
    is <- namedNumbers parseKind <$> outputOf listCommand
    forM_ is (outputOf . setCommand)
    parse <$> outputOf listCommand
    where
    sign | n > 0 = "+" | otherwise = "-"
    ctlKind      = map (\c -> if c == ' ' then '-' else c) kind
    parseKind    = unwords . map (\(notEmpty -> c :| cs) -> toUpper c : cs) . words $ kind
    setCommand i = "pactl set-" ++ ctlKind ++ "-volume " ++ i ++ " -- " ++ sign ++ show (abs n) ++ "%"
    listCommand  = "pactl list " ++ ctlKind ++ "s"
-- }}}
-- convenient actions {{{
centerMouse = warpToWindow (1/2) (1/2)
statusBarMouse = warpToScreen 0 (5/1600) (5/1200)
withScreen s f = screenWorkspace s >>= flip whenJust (windows . f)

makeLauncher yargs run exec close = concat
    ["exe=`yeganesh ", yargs, "` && ", run, " ", exec, "$exe", close]
launcher     = makeLauncher "" "eval" "\"exec " "\""
termLauncher = makeLauncher "-p withterm" "exec urxvt -e" "" ""
viewShift  i = view i . shift i
floatAll     = composeAll . map (\s -> className =? s --> doFloat)
sinkFocus    = peek >>= maybe id sink
showMod  k n = liftIO (modVolume k n) >>= volumeDzen . show . round
volumeDzen   = dzenConfig $ onCurr (center 170 66) >=> font "-*-helvetica-*-r-*-*-64-*-*-*-*-*-*-*,-*-terminus-*-*-*-*-64-*-*-*-*-*-*-*"
-- }}}
altMask = mod1Mask
bright  = "#80c0ff"
dark    = "#13294e"
-- manage hooks for mplayer {{{
fullscreen43on169 = expand $ RationalRect 0 (-1/6) 1 (4/3) where
    expand (RationalRect x y w h) = RationalRect (x - bwx) (y - bwy) (w + 2 * bwx) (h + 2 * bwy)
    bwx = 2 / 1920 -- borderwidth
    bwy = 2 / 1080

fullscreenMPlayer = className =? "MPlayer" --> do
    dpy   <- liftX $ asks display
    win   <- ask
    hints <- liftIO $ getWMNormalHints dpy win
    case fmap (approx . fst) (sh_aspect hints) of
        Just ( 4 :% 3)  -> viewFullOn 0 "5" win
        Just (16 :% 9)  -> viewFullOn 1 "5" win
        _               -> doFloat
    where
    approx (n, d)    = approxRational (fi n / fi d) (1/100)

operationOn f s n w = do
    let ws = marshall s n
    currws <- liftX $ screenWorkspace s
    doF $ view ws . maybe id view currws . shiftWin ws w . f w

viewFullOn = operationOn sink
centerWineOn = operationOn (`XMonad.StackSet.float` RationalRect (79/960) (-1/540) (401/480) (271/270))
-- }}}
-- debugging {{{
class Show a => PPrint a where
    pprint :: Int -> a -> String
    pprint _ = show

data PPrintable = forall a. PPrint a => P a
instance Show   PPrintable where show     (P x) = show x
instance PPrint PPrintable where pprint n (P x) = pprint n x

record :: String -> Int -> [(String, PPrintable)] -> String
record s n xs = preamble ++ intercalate newline fields ++ postlude where
    indentation = '\n' : replicate n '\t'
    preamble    = s ++ " {" ++ indentation
    postlude    = indentation ++ "}"
    newline     = ',' : indentation
    fields      = map (\(name, value) -> name ++ " = " ++ pprint (n+1) value) xs

instance PPrint a => PPrint (Maybe a) where
    pprint n (Just x) = "Just (" ++ pprint n x ++ ")"
    pprint _ x        = show x

instance PPrint a => PPrint [a] where
    pprint _ [] = "[]"
    pprint n xs = preamble ++ intercalate newline allLines ++ postlude where
        indentation = '\n' : replicate n '\t'
        preamble    = "[" ++ indentation
        allLines    = map (pprint (n+1)) xs
        newline     = ',' : indentation
        postlude    = indentation ++ "]"

instance PPrint Rectangle where
    pprint n x = record "Rectangle" n [
        ("rect_x", P (rect_x x)),
        ("rect_y", P (rect_y x)),
        ("rect_width", P (rect_width x)),
        ("rect_height", P (rect_height x))
        ]

instance PPrint a => PPrint (Stack a) where
    pprint n x = record "Stack" n [
        ("focus", P (XMonad.StackSet.focus x)),
        ("up", P (up x)),
        ("down", P (down x))
        ]

instance (PPrint i, PPrint l, PPrint a) => PPrint (Workspace i l a) where
    pprint n x = record "Workspace" n [
        ("tag", P (tag x)),
        ("layout", P (layout x)),
        ("stack", P (stack x))
        ]

instance PPrint ScreenDetail where
    pprint n x = record "SD" n [("screenRect", P (screenRect x))]

instance (PPrint i, PPrint l, PPrint a, PPrint sid, PPrint sd) => PPrint (XMonad.StackSet.Screen i l a sid sd) where
    pprint n x = record "Screen" n [
        ("workspace", P (workspace x)),
        ("screen", P (screen x)),
        ("screenDetail", P (screenDetail x))
        ]

instance (PPrint i, PPrint l, PPrint a, PPrint sid, PPrint sd) => PPrint (StackSet i l a sid sd) where
    pprint n x = record "StackSet" n [
        ("current", P (current x)),
        ("visible", P (visible x)),
        ("hidden", P (hidden x)),
        ("floating", P (floating x))
        ]

instance PPrint (Layout a)
instance PPrint Int
instance PPrint XMonad.Screen
instance PPrint Integer
instance PPrint Position
instance PPrint Dimension
instance PPrint Char
instance PPrint Word64
instance PPrint ScreenId
instance (Show a, Show b) => PPrint (Map a b)
-- }}}
-- main {{{
dmwitConfig nScreens = docks $ def {
    borderWidth             = 2,
    workspaces              = withScreens nScreens (map show [1..5]),
    terminal                = "urxvt",
    normalBorderColor       = dark,
    focusedBorderColor      = bright,
    modMask                 = mod4Mask,
    keys                    = keyBindings,
    layoutHook              = magnifierOff $ avoidStruts (GridRatio 0.9) ||| noBorders Full,
    manageHook              =     (title =? "CGoban: Main Window" --> doF sinkFocus)
                              <+> (className =? "Wine" <&&> (appName =? "hl2.exe" <||> appName =? "portal2.exe") --> ask >>= viewFullOn {-centerWineOn-} 1 "5")
                              <+> (className =? "VirtualBox" --> ask >>= viewFullOn 1 "5")
                              <+> (isFullscreen --> doFullFloat) -- TF2 matches the "isFullscreen" criteria, so its manage hook should appear after (e.g., to the left of a <+> compared to) this one
                              <+> (appName =? "huludesktop" --> doRectFloat fullscreen43on169)
                              <+> fullscreenMPlayer
                              <+> floatAll ["Gimp", "Wine"]
                              <+> manageSpawn,
    logHook                 = allPPs nScreens,
    startupHook             = refresh
                           >> mapM_ (spawnOnce . xmobarCommand) [0 .. nScreens-1]
    }

main = countScreens >>= xmonad . dmwitConfig
-- }}}
-- keybindings {{{
keyBindings conf = let m = modMask conf in fromList . anyMask $ [
    ((m                , xK_BackSpace  ), spawnHere "urxvt"),
    ((m                , xK_p          ), spawnHere launcher),
    ((m .|. shiftMask  , xK_p          ), spawnHere termLauncher),
    ((m .|. shiftMask  , xK_c          ), kill),
    ((m                , xK_q          ), restart "xmonad" True),
    ((m .|. shiftMask  , xK_q          ), io exitSuccess),
    ((m                , xK_grave      ), sendMessage NextLayout),
    ((m .|. shiftMask  , xK_grave      ), setLayout $ layoutHook conf),
    ((m                , xK_o          ), sendMessage Toggle),
    ((m                , xK_x          ), withFocused (windows . sink)),
    ((m                , xK_Home       ), windows focusUp),
    ((m .|. shiftMask  , xK_Home       ), windows swapUp),
    ((m                , xK_End        ), windows focusDown),
    ((m .|. shiftMask  , xK_End        ), windows swapDown),
    ((m                , xK_a          ), windows focusMaster),
    ((m .|. shiftMask  , xK_a          ), windows swapMaster),
    ((m                , xK_Control_L  ), withScreen 0 view),
    ((m .|. shiftMask  , xK_Control_L  ), withScreen 0 viewShift),
    ((m                , xK_Alt_L      ), withScreen 1 view),
    ((m .|. shiftMask  , xK_Alt_L      ), withScreen 1 viewShift),
    ((m                , xK_u          ), centerMouse),
    ((m .|. shiftMask  , xK_u          ), statusBarMouse),
    ((m                , xK_s          ), spawnHere "chromium --password-store=gnome"),
    ((m                , xK_n          ), spawnHere "gvim todo"),
    ((m                , xK_t          ), spawnHere "mpc toggle"),
    ((m                , xK_h          ), spawnHere "urxvt -e alsamixer"),
    ((m                , xK_d          ), spawnHere "wyvern"),
    ((m                , xK_l          ), spawnHere "urxvt -e sup"),
    ((m                , xK_r          ), spawnHere "urxvt -e ncmpcpp"),
    ((m                , xK_c          ), spawnHere "urxvt -e ghci"),
    ((m                , xK_g          ), spawnHere "slock" >> spawnHere "xscreensaver-command -lock"),
    ((m                , xK_f          ), spawnHere "gvim ~/.xmonad/xmonad.hs"),
    ((      noModMask  , xK_F8         ), showMod "sink input" (-4)),
    ((      noModMask  , xK_F9         ), showMod "sink input"   4 ),
    ((      shiftMask  , xK_F8         ), showMod "sink"       (-4)),
    ((      shiftMask  , xK_F9         ), showMod "sink"         4 ),
    ((      noModMask  , xK_Super_L    ), return ()) -- make VirtualBox ignore stray hits of the Windows key
    ] ++ [
    ((m .|. e          , key           ), windows (onCurrentScreen f ws))
    | (key, ws) <- zip [xK_1..xK_9] (workspaces' conf)
    , (e, f)    <- [(0, view), (shiftMask, viewShift)]
    ]

atSchool school home = do
    host <- liftIO (getEnv "HOST")
    return $ case host of
        "sorghum"   -> home
        "buckwheat" -> home
        _           -> school

anyMask xs = do
    ((mask, key), action) <- xs
    extraMask             <- [0, controlMask, altMask, controlMask .|. altMask]
    return ((mask .|. extraMask, key), action)
-- }}}
-- logHook {{{
pipeName n s = "/home/dmwit/.xmonad/pipe-" ++ n ++ "-" ++ show s

xmobarCommand (S s) = unwords ["xmobar",
    "-x", show s,
    "-t", template s,
    "-C", pipeReader
    ]
    where
    template 0 = "}%focus%{%workspaces%"
    template _ = "%date%}%focus%{%workspaces%"
    pipeReader = "'[\
        \Run PipeReader \"" ++ pipeName "focus"      s ++ "\" \"focus\",\
        \Run PipeReader \"" ++ pipeName "workspaces" s ++ "\" \"workspaces\"\
        \]'"

allPPs nScreens = sequence_ [dynamicLogWithPP (pp s) | s <- [0..nScreens-1], pp <- [ppFocus, ppWorkspaces]]
color c = xmobarColor c ""

ppFocus s@(S s_) = whenCurrentOn s def {
    ppOrder  = \case{ _:_:windowTitle:_ -> [windowTitle]; _ -> [] },
    ppOutput = appendFile (pipeName "focus" s_) . (++ "\n")
    }

ppWorkspaces s@(S s_) = marshallPP s def {
    ppCurrent           = color "white",
    ppVisible           = color "white",
    ppHiddenNoWindows   = color dark,
    ppUrgent            = color "red",
    ppSep               = "",
    ppOrder             = \case{ wss:_layout:_title:_ -> [wss]; _ -> [] },
    ppOutput            = appendFile (pipeName "workspaces" s_) . (++"\n")
    }
-- }}}
```

{% endraw %}

</details>

### XMonad.Config.Droundy

<details markdown=1>
  <summary>xmonad.hs</summary>

``` haskell
{-# LANGUAGE PatternGuards #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-orphans #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  XMonad.Config.Droundy
-- Description :  David Roundy's xmonad config.
-- Copyright   :  (c) Spencer Janssen 2007
-- License     :  BSD3-style (see LICENSE)
--
------------------------------------------------------------------------
module XMonad.Config.Droundy ( config, mytab ) where

import XMonad hiding (keys, config)
import qualified XMonad (keys)

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit ( exitSuccess )

import XMonad.Layout.Tabbed ( tabbed,
                              shrinkText, Shrinker, shrinkIt, CustomShrink(CustomShrink) )
import XMonad.Layout.Combo ( combineTwo )
import XMonad.Layout.Named ( named )
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Square ( Square(Square) )
import XMonad.Layout.WindowNavigation ( Navigate(Move,Swap,Go), Direction2D(U,D,R,L),
                                        windowNavigation )
import XMonad.Layout.BoringWindows ( boringWindows, markBoring, clearBoring,
                                     focusUp, focusDown )
import XMonad.Layout.NoBorders ( smartBorders )
import XMonad.Layout.WorkspaceDir ( changeDir, workspaceDir )
import XMonad.Layout.ToggleLayouts ( toggleLayouts, ToggleLayout(ToggleLayout) )
import XMonad.Layout.ShowWName ( showWName )
import XMonad.Layout.Magnifier ( maximizeVertical, MagnifyMsg(Toggle) )

import XMonad.Prompt ( font, height, XPConfig )
import XMonad.Prompt.Layout ( layoutPrompt )
import XMonad.Prompt.Shell ( shellPrompt )

import XMonad.Actions.CopyWindow ( kill1, copy )
import XMonad.Actions.DynamicWorkspaces ( withNthWorkspace, withWorkspace,
                                          selectWorkspace, renameWorkspace, removeWorkspace )
import XMonad.Actions.CycleWS ( moveTo, hiddenWS, emptyWS,
                                Direction1D( Prev, Next), WSType ((:&:), Not) )

import XMonad.Hooks.ManageDocks ( avoidStruts, docks )
import XMonad.Hooks.EwmhDesktops ( ewmh )

myXPConfig :: XPConfig
myXPConfig = def {font="-*-lucida-medium-r-*-*-14-*-*-*-*-*-*-*"
                 ,height=22}


------------------------------------------------------------------------
-- Key bindings:

-- | The xmonad key bindings. Add, modify or remove key bindings here.
--
-- (The comment formatting character is used when generating the manpage)
--
keys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys x = M.fromList $
    -- launching and killing programs
    [ ((modMask x .|. shiftMask, xK_c     ), kill1) -- %! Close the focused window

    , ((modMask x .|. shiftMask, xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask x .|. controlMask .|. shiftMask, xK_L ), setLayout $ layoutHook x) -- %!  Reset the layouts on the current workspace to default

    -- move focus up or down the window stack
    , ((modMask x,               xK_Tab   ), focusDown) -- %! Move focus to the next window
    , ((modMask x,               xK_j     ), focusDown) -- %! Move focus to the next window
    , ((modMask x,               xK_k     ), focusUp  ) -- %! Move focus to the previous window

    , ((modMask x .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask x .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- floating layer support
    , ((modMask x,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- quit, or restart
    , ((modMask x .|. shiftMask, xK_Escape), io exitSuccess) -- %! Quit xmonad
    , ((modMask x              , xK_Escape), restart "xmonad" True) -- %! Restart xmonad

    , ((modMask x .|. shiftMask, xK_Right), moveTo Next $ hiddenWS :&: Not emptyWS)
    , ((modMask x .|. shiftMask, xK_Left), moveTo Prev $ hiddenWS :&: Not emptyWS)
    , ((modMask x, xK_Right), sendMessage $ Go R)
    , ((modMask x, xK_Left), sendMessage $ Go L)
    , ((modMask x, xK_Up), sendMessage $ Go U)
    , ((modMask x, xK_Down), sendMessage $ Go D)
    , ((modMask x .|. controlMask, xK_Right), sendMessage $ Swap R)
    , ((modMask x .|. controlMask, xK_Left), sendMessage $ Swap L)
    , ((modMask x .|. controlMask, xK_Up), sendMessage $ Swap U)
    , ((modMask x .|. controlMask, xK_Down), sendMessage $ Swap D)
    , ((modMask x .|. controlMask .|. shiftMask, xK_Right), sendMessage $ Move R)
    , ((modMask x .|. controlMask .|. shiftMask, xK_Left), sendMessage $ Move L)
    , ((modMask x .|. controlMask .|. shiftMask, xK_Up), sendMessage $ Move U)
    , ((modMask x .|. controlMask .|. shiftMask, xK_Down), sendMessage $ Move D)

    , ((0, xK_F2  ), spawn "gnome-terminal") -- %! Launch gnome-terminal
    , ((0, xK_F3  ), shellPrompt myXPConfig) -- %! Launch program
    , ((0, xK_F11   ), spawn "ksnapshot") -- %! Take snapshot
    , ((modMask x .|. shiftMask, xK_b     ), markBoring)
    , ((controlMask .|. modMask x .|. shiftMask, xK_b     ), clearBoring)
    , ((modMask x .|. shiftMask, xK_x     ), changeDir myXPConfig)
    , ((modMask x .|. shiftMask, xK_BackSpace), removeWorkspace)
    , ((modMask x .|. shiftMask, xK_v     ), selectWorkspace myXPConfig)
    , ((modMask x, xK_m     ), withWorkspace myXPConfig (windows . W.shift))
    , ((modMask x .|. shiftMask, xK_m     ), withWorkspace myXPConfig (windows . copy))
    , ((modMask x .|. shiftMask, xK_r), renameWorkspace myXPConfig)
    , ((modMask x, xK_l ), layoutPrompt myXPConfig)
    , ((modMask x .|. controlMask, xK_space), sendMessage ToggleLayout)
    , ((modMask x, xK_space), sendMessage Toggle)

    ]

    ++
    zip (zip (repeat $ modMask x) [xK_F1..xK_F12]) (map (withNthWorkspace W.greedyView) [0..])
    ++
    zip (zip (repeat (modMask x .|. shiftMask)) [xK_F1..xK_F12]) (map (withNthWorkspace copy) [0..])

config = docks $ ewmh def
         { borderWidth = 1 -- Width of the window border in pixels.
         , XMonad.workspaces = ["mutt","iceweasel"]
         , layoutHook = showWName $ workspaceDir "~" $
                        boringWindows $ smartBorders $ windowNavigation $
                        maximizeVertical $ toggleLayouts Full $ avoidStruts $
                        named "tabbed" mytab |||
                        named "xclock" (mytab ****//* combineTwo Square mytab mytab) |||
                        named "three" (mytab **//* mytab *//* combineTwo Square mytab mytab) |||
                        named "widescreen" ((mytab *||* mytab)
                                                ****//* combineTwo Square mytab mytab) --   |||
                        --mosaic 0.25 0.5
         , terminal = "xterm" -- The preferred terminal program.
         , normalBorderColor = "#222222" -- Border color for unfocused windows.
         , focusedBorderColor = "#00ff00" -- Border color for focused windows.
         , XMonad.modMask = mod1Mask
         , XMonad.keys = keys
         }

mytab = tabbed CustomShrink def

instance Shrinker CustomShrink where
    shrinkIt shr s | Just s' <- dropFromHead " " s = shrinkIt shr s'
    shrinkIt shr s | Just s' <- dropFromTail " " s = shrinkIt shr s'
    shrinkIt shr s | Just s' <- dropFromTail "- Iceweasel" s = shrinkIt shr s'
    shrinkIt shr s | Just s' <- dropFromTail "- KPDF" s = shrinkIt shr s'
    shrinkIt shr s | Just s' <- dropFromHead "file://" s = shrinkIt shr s'
    shrinkIt shr s | Just s' <- dropFromHead "http://" s = shrinkIt shr s'
    shrinkIt _ s | n > 9 = s : map cut [2..(halfn-3)] ++ shrinkIt shrinkText s
                 where n = length s
                       halfn = n `div` 2
                       rs = reverse s
                       cut x = take (halfn - x) s ++ "..." ++ reverse (take (halfn-x) rs)
    shrinkIt _ s = shrinkIt shrinkText s

dropFromTail :: String -> String -> Maybe String
dropFromTail "" _ = Nothing
dropFromTail t s | drop (length s - length t) s == t = Just $ take (length s - length t) s
                 | otherwise = Nothing

dropFromHead :: String -> String -> Maybe String
dropFromHead "" _ = Nothing
dropFromHead h s | take (length h) s == h = Just $ drop (length h) s
                 | otherwise = Nothing

{-
data FocusUrgencyHook = FocusUrgencyHook deriving (Read, Show)

instance UrgencyHook FocusUrgencyHook Window where
    urgencyHook _ w = modify copyAndFocus
        where copyAndFocus s
                  | Just w == W.peek (windowset s) = s
                  | has w $ W.stack $ W.workspace $ W.current $ windowset s =
                      s { windowset = until ((Just w ==) . W.peek)
                                      W.focusUp $ windowset s }
                  | otherwise =
                      let t = W.currentTag $ windowset s
                      in s { windowset = until ((Just w ==) . W.peek)
                             W.focusUp $ copyWindow w t $ windowset s }
              has _ Nothing         = False
              has x (Just (W.Stack t l rr)) = x `elem` (t : l ++ rr)

-}
```

</details>

### XMonad.Config.Saegesser

<details markdown=1>
  <summary>xmonad.hs</summary>

``` haskell
{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-orphans #-}
{-# LANGUAGE OverloadedStrings #-}

---------------------------------------------------------------------
-- |
-- A mostly striped down configuration that demonstrates spawnOnOnce
--
---------------------------------------------------------------------
import System.IO

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive

import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Mosaic

import XMonad.Util.Run
import XMonad.Util.Cursor
import XMonad.Util.NamedScratchpad
import XMonad.Util.Scratchpad
import XMonad.Util.SpawnOnce

import XMonad.Actions.CopyWindow
import XMonad.Actions.SpawnOn

import qualified XMonad.StackSet as W

main = do
  myStatusBarPipe <- spawnPipe "xmobar"
  xmonad $ docks $ withUrgencyHook NoUrgencyHook $ def
    { terminal          = "xterm"
    , workspaces        = myWorkspaces
    , layoutHook        = myLayoutHook
    , manageHook        = myManageHook <+> manageSpawn
    , startupHook       = myStartupHook
    , logHook           = myLogHook myStatusBarPipe
    , focusFollowsMouse = False
    }

myManageHook = composeOne
  [ isDialog                     -?> doFloat
  , className =? "trayer"        -?> doIgnore
  , className =? "Skype"         -?> doShift "chat"
  , appName   =? "libreoffice"   -?> doShift "office"
  , return True                  -?> doF W.swapDown
  ]

myWorkspaces = [ "web", "emacs", "chat", "vm", "office", "media", "xterms", "8", "9", "0"]

myStartupHook = do
  setDefaultCursor xC_left_ptr
  spawnOnOnce "emacs" "emacs"
  spawnNOnOnce 4 "xterms" "xterm"

myLayoutHook = smartBorders $ avoidStruts standardLayouts
  where standardLayouts = tiled ||| mosaic 2 [3,2]  ||| Mirror tiled ||| Full
        tiled = ResizableTall nmaster delta ratio []
        nmaster = 1
        delta = 0.03
        ratio = 0.6

myLogHook p =  do
  copies <- wsContainingCopies
  let check ws | ws == "NSP" = ""                               -- Hide the scratchpad workspace
               | ws `elem` copies = xmobarColor "red" "black" ws  -- Workspaces with copied windows are red on black
               | otherwise = ws
  dynamicLogWithPP $ xmobarPP { ppHidden = check
                              , ppOutput = hPutStrLn p
                              , ppUrgent = xmobarColor "white" "red"
                              , ppTitle  = xmobarColor "green" "" . shorten 180
                              }
  fadeInactiveLogHook 0.6
```

</details>

### XMonad.Config.Sjanssen

<details markdown=1>
  <summary>xmonad.hs</summary>

``` haskell
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  XMonad.Config.Sjanssen
-- Description :  Spencer Janssen's xmonad config.
--
------------------------------------------------------------------------
module XMonad.Config.Sjanssen (sjanssenConfig) where

import XMonad hiding (Tall(..))
import qualified XMonad.StackSet as W
import XMonad.Actions.CopyWindow
import XMonad.Layout.Tabbed
import XMonad.Layout.HintedTile
import XMonad.Layout.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.EwmhDesktops
import XMonad.Prompt
import XMonad.Actions.SpawnOn
import XMonad.Util.SpawnOnce

import XMonad.Layout.LayoutScreens
import XMonad.Layout.TwoPane

import qualified Data.Map as M

sjanssenConfig =
    docks $ ewmh $ def
        { terminal = "exec urxvt"
        , workspaces = ["irc", "web"] ++ map show [3 .. 9 :: Int]
        , mouseBindings = \XConfig {modMask = modm} -> M.fromList
                [ ((modm, button1), \w -> focus w >> mouseMoveWindow w)
                , ((modm, button2), \w -> focus w >> windows W.swapMaster)
                , ((modm.|. shiftMask, button1), \w -> focus w >> mouseResizeWindow w) ]
        , keys = \c -> mykeys c `M.union` keys def c
        , logHook = dynamicLogString sjanssenPP >>= xmonadPropLog
        , layoutHook  = modifiers layouts
        , manageHook  = composeAll [className =? x --> doShift w
                                    | (x, w) <- [ ("Firefox", "web")
                                                , ("Ktorrent", "7")
                                                , ("Amarokapp", "7")]]
                        <+> manageHook def <+> manageSpawn
                        <+> (isFullscreen --> doFullFloat)
        , startupHook = mapM_ spawnOnce spawns
        }
 where
    tiled     = HintedTile 1 0.03 0.5 TopLeft
    layouts   = (tiled Tall ||| (tiled Wide ||| Full)) ||| tabbed shrinkText myTheme
    modifiers = avoidStruts . smartBorders

    spawns = [ "xmobar"
             , "xset -b", "xset s off", "xset dpms 0 600 1200"
             , "nitrogen --set-tiled wallpaper/wallpaper.jpg"
             , "trayer --transparent true --expand true --align right "
               ++ "--edge bottom --widthtype request" ]

    mykeys XConfig{modMask = modm} = M.fromList
        [((modm,               xK_p     ), shellPromptHere myPromptConfig)
        ,((modm .|. shiftMask, xK_Return), spawnHere =<< asks (terminal . config))
        ,((modm .|. shiftMask, xK_c     ), kill1)
        ,((modm .|. shiftMask .|. controlMask, xK_c     ), kill)
        ,((modm .|. shiftMask, xK_0     ), windows copyToAll)
        ,((modm,               xK_z     ), layoutScreens 2 $ TwoPane 0.5 0.5)
        ,((modm .|. shiftMask, xK_z     ), rescreen)
        , ((modm             , xK_b     ), sendMessage ToggleStruts)
        ]

    myFont = "xft:Bitstream Vera Sans Mono:pixelsize=10"
    myTheme = def { fontName = myFont }
    myPromptConfig = def
                        { position = Top
                        , font = myFont
                        , showCompletionOnTab = True
                        , historyFilter = deleteConsecutive
                        , promptBorderWidth = 0 }
```

</details>
