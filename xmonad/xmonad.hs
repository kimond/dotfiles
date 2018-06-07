{-# LANGUAGE AllowAmbiguousTypes, DeriveDataTypeable, TypeSynonymInstances, MultiParamTypeClasses #-}
import qualified Data.Map as M
import System.Exit
import System.IO

import XMonad hiding ( (|||) )
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog              -- for xmobar
import XMonad.Actions.Commands
import qualified XMonad.Actions.ConstrainedResize as Sqr
import XMonad.Actions.CopyWindow            -- like cylons, except x windows
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.MessageFeedback       -- pseudo conditional key bindings
import XMonad.Actions.Navigation2D
import XMonad.Actions.SinkAll
import XMonad.Actions.WindowGo
import XMonad.Actions.WithAll               -- action all the things
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks             -- avoid xmobar
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName -- Bug with Java/Swing apps
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.Fullscreen
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Renamed
import XMonad.Layout.PerScreen              -- Check screen width & adjust layouts
import XMonad.Layout.PerWorkspace           -- Configure layouts on a per-workspace
import XMonad.Layout.Reflect
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.SubLayouts             -- Layouts inside windows. Excellent.
import XMonad.Layout.Spacing                -- this makes smart space around windows
import XMonad.Layout.ToggleLayouts          -- Full window at any time
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed

import XMonad.Prompt                        -- to get my old key bindings working
import XMonad.Prompt.ConfirmPrompt          -- don't just hard quit
import XMonad.Util.Cursor
import XMonad.Util.EZConfig                 -- removeKeys, additionalKeys
import XMonad.Util.NamedActions
import XMonad.Util.NamedWindows
import XMonad.Util.Paste as P               -- testing
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.WorkspaceCompare         -- custom WS functions filtering NSP

main = do
    xmonad
        $ addDescrKeys' ((myModMask, xK_F1), showKeybindings) myKeys
        $ ewmh
        $ myConfig

myConfig = def
    { borderWidth = border
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , modMask     = myModMask
    , manageHook = myManageHook
    , handleEventHook = myHandleEventHook
    , layoutHook = myLayoutHook
    , logHook = ewmhDesktopsLogHook
    , startupHook = myStartupHook
    , terminal = myTerminal
    , workspaces = myWorkspaces
    }


--------------
-- Workspaces
--------------
wsDev = "Dev \xf120"
wsBrowser = "Browser \xf268"
wsSocial = "Social \xf086"
wsMusic = "Music \xf144"
wsFile = "File \xf15b"
wsMisc = "Misc"
wsGame = "Game \xff11b"
wsMisc2 = "8"
wsMisc3 = "9"

-- myWorkspaces = map show [1..9]
myWorkspaces = [wsDev, wsBrowser, wsSocial, wsMusic, wsFile, wsMisc, wsGame, wsMisc2, wsMisc3]

----------------
-- Applications
----------------

myTerminal = "xfce4-terminal"
myBrowser = "google-chrome-stable"
myBrowserClass      = "Google-chrome-stable"
myStatusBar = "~/.xmonad/polybar-launch.sh"
myRunLauncher = "rofi -show run"
myLauncher = "rofi -show drun"

---------
-- Theme
---------

base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"

-- sizes
gap = 5
topbar = 5
border = 2
prompt = 20
status = 20

myNormalBorderColor     = "#333333"
myFocusedBorderColor    = "#552e5c"

active      = blue
activeWarn  = red
inactive    = base02
focusColor  = blue
unfocusColor = base02

myFont      = "-*-hack*-*-*-*-160-*-*-*-*-*-*"
myBigFont   = "-*-hack*-*-*-*-240-*-*-*-*-*-*"
myWideFont  = "xft:Hack Black Extended:"
            ++ "style=Regular:pixelsize=180:hinting=true"

myPromptTheme = def
    { font                  = myFont
    , bgColor               = base03
    , fgColor               = active
    , fgHLight              = base03
    , bgHLight              = active
    , borderColor           = base03
    , promptBorderWidth     = 0
    , height                = prompt
    , position              = Top
    }

hotPromptTheme = myPromptTheme
    { bgColor               = red
    , fgColor               = base3
    , position              = Top
    }

----------
-- Layout
----------

myLayoutHook = avoidStruts $ layoutHook defaultConfig

------------
-- Binding
------------

myModMask = mod4Mask -- super

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
    h <- spawnPipe "xenity --text-info --font=hack"
    hPutStr h (unlines $ showKm x)
    hClose h
    return ()

wsKeys = map show $ [1..9] ++ [0]

myKeys conf = let

    subKeys str ks = subtitle str : mkNamedKeymap conf ks
    screenKeys = ["w", "e", "m"]
    dirKeys        = ["j","k","h","l"]
    arrowKeys        = ["<D>","<U>","<L>","<R>"]
    dirs           = [ D,  U,  L,  R ]

    zipM  m nm ks as f = zipWith (\k d -> (m ++ k, addName nm $ f d)) ks as
    zipM' m nm ks as f b = zipWith (\k d -> (m ++ k, addName nm $ f d b)) ks as

    tryMsgR x y = sequence_ [(tryMessage_ x y), refresh]

    in

    subKeys "System"
    [ ("M-S-r" , addName "Restart XMonad"               $ spawn "xmonad --restart")
    , ("M-C-r" , addName "Rebuild & restart XMonad"     $ spawn "xmonad --recompile && xmonad --restart")
    , ("M-S-e" , addName "Quit XMonad"                  $ confirmPrompt hotPromptTheme "Quit XMonad" $ io (exitWith ExitSuccess))
    , ("M-x"   , addName "Lock screen"                  $ spawn "xset s activate")
    , ("M-<F4>", addName "Print Screen"                 $ return () )
    , ("M-M1-v", addName "Lock"                 $ spawn "systemctl suspend")
    , ("<XF86MonBrightnessUp>", addName "Brightness up" $ spawn "light -A 5")
    , ("<XF86MonBrightnessDown>", addName "Brightness down" $ spawn "light -U 5")
  --, ("M-F1"  , addName "Show Keybindings"             $ return ())
    ] ^++^

    subKeys "Windows, Workspaces & Screens"
    (
    [ ("M-S-q"          , addName "Kill"                            kill1)
    , ("M-u"            , addName "Focus urgent"                    focusUrgent)
    ]
    ++ zipM' "M-"     "Navigate window"          arrowKeys dirs windowGo True
    ++ zipM' "M-S-"   "Move window"              arrowKeys dirs windowSwap True
    ++ zipM' "M-M1"   "Navigate screen"          arrowKeys dirs screenGo True
    ++ zipM' "M-C-S-" "Move window to screen"    arrowKeys dirs windowToScreen True
    ++ zipM' "M-C-"   "Swap workspace to screen" arrowKeys dirs screenSwap True
    ++ zipM "M-"      "View      ws"    wsKeys [0..] (withNthWorkspace W.view)
    ++ zipM "M-S-"    "Move w to ws"    wsKeys [0..] (withNthWorkspace W.shift)
    ) ^++^

    subKeys "Launchers"
    [ ("M-d", addName "Launcher" $ spawn myLauncher)
    , ("M-<F2>" , addName "Run Launcher" $ spawn myRunLauncher)
    , ("M1-<Tab>" , addName "Rofi window" $ spawn "rofi -show window")
    , ("M-<Return>" , addName "Terminal" $ spawn myTerminal)
    , ("M-S-n", addName "Nautilus" $ spawn "nautilus")
    , ("<Print>", addName "Screenshot" $ spawn "shutter -f")
    , ("C-<Print>", addName "Screenshot selection" $ spawn "shutter -s")
    ] ^++^

    subKeys "Layout Management"

    [ ("M-<Tab>"   , addName "Cycle all layouts"               $ sendMessage NextLayout)
    , ("M-C-<Tab>" , addName "Cycle sublayout"                 $ toSubl NextLayout)
    , ("M-S-<Tab>" , addName "Reset layout"                    $ setLayout $ XMonad.layoutHook conf)
    -- , ("M-y"       , addName "Float tiled w"                   $ withFocused toggleFloat)
    , ("M-S-y"     , addName "Tile all floating w"             $ sinkAll)
    , ("M-,"       , addName "Decrease master windows"         $ sendMessage (IncMasterN (-1)))
    , ("M-."       , addName "Increase master windows"         $ sendMessage (IncMasterN 1))
    -- , ("M-r"       , addName "Reflect/Rotate"              $ tryMsgR (Rotate) (XMonad.Layout.MultiToggle.Toggle REFLECTX))
    , ("M-S-x"     , addName "Force Reflect (even on BSP)" $ sendMessage (XMonad.Layout.MultiToggle.Toggle REFLECTX))
    -- If following is run on a floating window, the sequence first tiles it.
    -- Not perfect, but works.
    , ("M-f"       , addName "Fullscreen"  $ sequence_ [ (withFocused $ windows . W.sink) , (sendMessage $ XMonad.Layout.MultiToggle.Toggle FULL) ])
    ]

------------------------------------------------------------------------}}}
-- Startup                                                              {{{
---------------------------------------------------------------------------

myStartupHook = do
    setWMName "LG3D"
    spawnOnce "compton"
    spawnOnce "redshift-gtk"
    spawnOnce "nm-applet"
    spawn "dunst -config ~/.config/i3/dunstrc"
    spawn "nitrogen --restore"
    spawn "/usr/lib/gsd-xsettings"
    spawn myStatusBar
    setDefaultCursor xC_left_ptr

--------------
-- Manage Hook
--------------

myManageHook :: ManageHook
myManageHook =
        manageAll
    <+> manageDocks
    <+> fullscreenManageHook
    -- <+> manageSpawn
    where
        manageAll = composeAll
            [ className =? "jetbrains-idea" --> doShift (wsDev)
            , className =? "FireFox" --> doShift (wsBrowser)
            , className =? "Chrome" --> doShift (wsBrowser)
            , className =? "google-chrome" --> doShift (wsBrowser)
            , className =? "Google-chrome" --> doShift (wsBrowser)
            , className =? "Slack" --> doShift (wsSocial)
            , className =? "Mumble" --> doShift (wsSocial)
            , className =? "Shutter" --> doFloat
             ]

---------------------------------------------------------------------------
-- X Event Actions
---------------------------------------------------------------------------

myHandleEventHook = docksEventHook
                <+> handleEventHook def
                <+> XMonad.Layout.Fullscreen.fullscreenEventHook
