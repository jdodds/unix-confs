import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run

main=do
  conky <- spawnPipe myConkyBar
  xmonad =<< dzen defaultConfig
    { terminal = "urxvtc"
    , modMask  = mod4Mask
    , borderWidth = 3
    , layoutHook = avoidStruts $ layoutHook defaultConfig 
    , manageHook = manageDocks <+> manageHook defaultConfig
    }
myConkyBar = "conky | dzen2 -e 'onstart=lower' -h '16' -w '690' -x 750 -ta r -fg '#e0e0e0' -bg '#1a1a1a'"


