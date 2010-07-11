import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Util.Run

main=do
  conky <- spawnPipe myConkyBar
--  statusBar <- spawnPipe myStatusBar           
  xmonad =<< dzen defaultConfig
    { terminal = "urxvtc"
    , modMask  = mod4Mask
    , borderWidth = 3
    , layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig 
    , manageHook = composeAll [isFullscreen --> doFullFloat
                              ,manageDocks
                              ]
    --    , logHook = dynamicLogWithPP $ defaultPP { ppOutput = hPutStrLn statusBar }
    }


myBarBgColor = "#1a1a1a"
myBarFgColor = "#e0e0e0"
myDzenOpts = "-fg '" ++ myBarFgColor ++ "' -bg '" ++ myBarBgColor ++ "' -h '16'"

myStatusBar = "dzen2 -w 655 -ta l " ++ myDzenOpts
                
myConkyBar = "conky | dzen2 -e 'onstart=lower' -w '690' -x '750' -ta r " ++ myDzenOpts



