import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName(setWMName)
import XMonad.Layout.NoBorders
import XMonad.Layout.IM
import XMonad.Layout.Reflect
import XMonad.Util.Run
import System.IO
import qualified Data.Map as M

main=do
  conky <- spawnPipe myConkyBar
  xmonad =<< dzen defaultConfig
    { terminal = "urxvtc"
    , modMask  = mod4Mask
    , borderWidth = 1
    , normalBorderColor = "#000000"
    , focusedBorderColor = "#0000ff"
    , workspaces = ["web", "emacs", "shell", "news" ] ++ map show [5..9]
    , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
    , manageHook = composeAll [isFullscreen --> doFullFloat
                              ,className =? "Qjackctl" --> doFloat
                              ,className =? "Qjackctl" --> doShift "9"
                              ,className =? "Emacs" --> doShift "2"
                              ,className =? "Xfce4-notifyd" --> doIgnore
                              ,className =? "Pidgin" --> doFloat
                              ,className =? "Skype" --> doFloat
                              ,className =? "Chromium" --> doShift "1"
                              ,className =? "Gimp" --> doFloat
                              ,manageDocks
                              ]
    , keys = newKeys
    }


defKeys = keys defaultConfig
delKeys x = foldr M.delete (defKeys x) (toRemove x)
newKeys x = foldr (uncurry M.insert) (delKeys x) (toAdd x)

toRemove x =
   [ (modMask x, xK_p )
   ]

toAdd x =
    [ ((mod4Mask,  xK_z), setWMName "LG3D")
    , ((mod4Mask, xK_Z), setWMName "XMonad")
    , ((mod4Mask, xK_p), spawn myDmenuLaunch)
    ]

myBarBgColor = "#1a1a1a"
myBarFgColor = "#e0e0e0"
myDzenOpts = "-fg '" ++ myBarFgColor ++ "' -bg '" ++ myBarBgColor ++ "' -h '16'"

myStatusBar = "dzen2 -w 655 -ta l " ++ myDzenOpts

myConkyBar = "conky | dzen2 -e 'onstart=lower' -w '690' -x '750' -ta r " ++ myDzenOpts

myDmenuLaunch = "dmenu_run -b"
