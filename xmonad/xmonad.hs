import qualified Data.Map as M
import System.Exit
import System.IO

import XMonad
import qualified XMonad.StackSet as W
import XMonad.Actions.Navigation2D
import XMonad.Actions.WindowGo
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName -- Bug with Java/Swing apps
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.Decoration
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing                -- this makes smart space around windows
import XMonad.Layout.ToggleLayouts          -- Full window at any time
import XMonad.Layout.Tabbed
import XMonad.Layout.MouseResizableTile -- Mouse resize

import XMonad.Prompt                        -- to get my old key bindings working
import XMonad.Prompt.ConfirmPrompt          -- don't just hard quit
import XMonad.Util.Cursor
import XMonad.Util.EZConfig                 -- removeKeys, additionalKeys
import XMonad.Util.NamedActions
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

main = do
    xmonad
        $ addDescrKeys ((myModMask, xK_F1), showKeybindings) myKeys
        $ docks
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
wsGame = "7"
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
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
red     = "#dc322f"
violet  = "#6c71c4"
blue    = "#268bd2"

-- sizes
border = 1
prompt = 20

myNormalBorderColor     = "#2d2948"
myFocusedBorderColor    = "#6d0569"

myFont      = "xft:Hack:size=9"

myPromptTheme = def
    { font                  = myFont
    , bgColor               = base03
    , fgColor               = blue
    , fgHLight              = base03
    , bgHLight              = blue
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

tabConfig = def {
    fontName = myFont,
    activeBorderColor = myFocusedBorderColor,
    activeTextColor = "#fcf4fa",
    activeColor = "#221530",
    inactiveBorderColor = myNormalBorderColor,
    inactiveTextColor = "#c5c6c8",
    inactiveColor = "#13131e"
}

----------
-- Layout
----------

myLayoutHook = avoidStruts 
    $ mouseResizableTile{draggerType = BordersDragger} ||| (
                tabbed shrinkText tabConfig |||
                Full
            )

------------
-- Binding
------------

myModMask = mod4Mask -- super

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
    h <- spawnPipe "zenity --text-info --font=Hack"
    hPutStr h (unlines $ showKm x)
    hClose h
    return ()

myKeys conf = let

    subKeys str ks = subtitle str : mkNamedKeymap conf ks
    arrowKeys = ["<D>","<U>","<L>","<R>"]
    dirs      = [ D,  U,  L,  R ]

    zipM  m nm ks as f = zipWith (\k d -> (m ++ k, addName nm $ f d)) ks as
    zipM' m nm ks as f b = zipWith (\k d -> (m ++ k, addName nm $ f d b)) ks as

    in

    subKeys "System"
    [ ("M-S-z" , addName "Restart XMonad"               $ spawn "xmonad --restart")
    , ("M-C-z" , addName "Rebuild & restart XMonad"     $ spawn "xmonad --recompile && xmonad --restart")
    , ("M-<F4>" , addName "Power menu"                  $ spawn "~/.dotfiles/bin/rofi-logout")
    , ("M-S-<F4>" , addName "Quit XMonad"                  $ confirmPrompt hotPromptTheme "Quit XMonad" $ io (exitWith ExitSuccess))
    , ("M-M1-v", addName "Lock"                 $ spawn "systemctl suspend")
    , ("M-S-x", addName "Xrandr"                 $ spawn "~/.dotfiles/bin/rofi-xrandr")
    , ("M-S-l", addName "Lock"                 $ spawn "xtrlock -b")
    , ("<XF86MonBrightnessUp>", addName "Brightness up" $ spawn "light -A 5")
    , ("<XF86MonBrightnessDown>", addName "Brightness down" $ spawn "light -U 5")
    , ("<XF86AudioRaiseVolume>", addName "Volume up" $ spawn "amixer -q set Master 5%+")
    , ("<XF86AudioLowerVolume>", addName "Volume down" $ spawn "amixer -q set Master 5%-")
    , ("<XF86AudioMute>", addName "Volume down" $ spawn "amixer -q set Master toggle")
    ] ^++^

    subKeys "Windows, Workspaces & Screens"
    (
    [ ("M-S-q"          , addName "Kill"         kill) ]
    ++ zipM' "M-"     "Navigate window"          arrowKeys dirs windowGo True
    ++ zipM' "M-S-"   "Move window"              arrowKeys dirs windowSwap True
    ++ zipM' "M-C-"   "Swap workspace to screen" arrowKeys dirs screenSwap True
    ) ^++^

    subKeys "Launchers"
    [ ("M-d", addName "Launcher" $ spawn myLauncher)
    , ("M-g", addName "Calculator" $ spawn "galculator")
    , ("M-<F2>" , addName "Run Launcher" $ spawn myRunLauncher)
    , ("M1-<Tab>" , addName "Rofi window" $ spawn "rofi -show window")
    , ("M-<Return>" , addName "Terminal" $ spawn myTerminal)
    , ("M-S-n", addName "Nautilus" $ spawn "nautilus")
    , ("<Print>", addName "Screenshot" $ spawn "flameshot full -p ~/Pictures/screenshots")
    , ("C-<Print>", addName "Screenshot selection" $ spawn "flameshot gui -p ~/Pictures/screenshots")
    ]

------------------------------------------------------------------------}}}
-- Startup                                                              {{{
---------------------------------------------------------------------------

myStartupHook = do
    setWMName "LG3D"
    spawnOnce "compton"
    spawnOnce "redshift-gtk"
    spawnOnce "nm-applet"
    spawnOnce "google-chrome-stable"
    spawnOnce "slack"
    spawnOnce "dunst -config ~/.config/i3/dunstrc"
    spawnOnce "nitrogen --restore"
    -- spawn "/usr/lib/gsd-xsettings"
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
    where
        manageAll = composeAll
            [ className =? "jetbrains-idea" --> doShift (wsDev)
            , className =? "code-oss" --> doShift (wsDev)
            , className =? "FireFox" --> doShift (wsBrowser)
            , className =? "Chrome" --> doShift (wsBrowser)
            , className =? "google-chrome" --> doShift (wsBrowser)
            , className =? "Google-chrome" --> doShift (wsBrowser)
            , className =? "Slack" --> doShift (wsSocial)
            , className =? "discord" --> doShift (wsSocial)
            , className =? "Mumble" --> doShift (wsSocial)
            , className =? "Shutter" --> doFloat
             ]

---------------------------------------------------------------------------
-- X Event Actions
---------------------------------------------------------------------------

myHandleEventHook = def
                <+> XMonad.Hooks.EwmhDesktops.fullscreenEventHook
