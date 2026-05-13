import Colors
import Data.Maybe
import XMonad
import XMonad.Actions.CycleWorkspaceByScreen
import XMonad.Actions.DwmPromote
import XMonad.Actions.FindEmptyWorkspace
import XMonad.Actions.WithAll
import XMonad.Actions.MouseResize
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import qualified XMonad.Hooks.ManageHelpers as MH
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.WorkspaceHistory (workspaceHistoryHook)
import XMonad.Layout.Accordion
import XMonad.Layout.Dwindle
import XMonad.Layout.LayoutCombinators (JumpToLayout)
import XMonad.Layout.NoBorders
import qualified XMonad.Layout.Renamed as R
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimpleDecoration
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.ManageHook
import qualified XMonad.StackSet as W
import XMonad.Util.ClickableWorkspaces
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce

-- variables
myMod = mod4Mask

myTerminal = "kitty"

myRunCmd = "bemenu-run"

myWorkspaces = show <$> [1 .. 9]


-- keybindings
myKeys =
  [ ("M-<Return>", spawn myTerminal),
    ("M-q", spawn "xmonad --recompile; xmonad --restart"),
    ("M-r", spawn myRunCmd),
    ("M-<Delete>", spawn "rofi -show power-menu -modi power-menu:rofi-power-menu"),
    ("M-w", spawn "rofi -show window"),
    ("M-C-b", spawn "bm"),
    ("M-C-s", spawn "maim -s | xclip -selection clipboard -t image/png"),
    ("M-<F3>", spawn "brightnessctl set +5"),
    ("M-<F2>", spawn "brightnessctl set 5-"),
    ("M-<F7>", spawn "amixer set Master 2%+"),
    ("M-<F6>", spawn "amixer set Master 2%-"),
    ("M-0", namedScratchpadAction scratchpads "term"),
    ("M-p", namedScratchpadAction scratchpads "volume"),
    ("M-x", namedScratchpadAction scratchpads "top"),
    ("M-f", namedScratchpadAction scratchpads "file"),
    ("M-<Backspace>", kill),
    ("M-S-<Backspace>", killAll),
    ("M-<Tab>", sendMessage NextLayout),
    ("M-h", sendMessage Shrink),
    ("M-l", sendMessage Expand),
    ("M-i", sendMessage MirrorExpand),
    ("M-m", sendMessage MirrorShrink),
    ("M-<.>", sendMessage $ IncMasterN (-1)),
    ("M-<,>", sendMessage $ IncMasterN 1),
    ("M-d", decWindowSpacing 4),
    ("M-a", incWindowSpacing 4),
    ("M-<Space>", windows W.focusDown),
    ("M-j", windows W.focusUp),
    ("M-k", windows W.focusDown),
    ("M-s", dwmpromote),
    ("M-C-l",  spawn "betterlockscreen -l"),
    ("M-S-f", sendMessage $ JumpToLayout "Full"),
    ("M-S-t", sendMessage $ JumpToLayout "Tall"),
    ("M-S-d", sendMessage $ JumpToLayout "Dwind"),
    ("M-S-w", sendMessage $ JumpToLayout "Wide"),
    ("M-S-m", sendMessage $ JumpToLayout "Threecol"),
    ("M-v", cycleWorkspaceOnCurrentScreen [xK_c] xK_v xK_grave),
    ("M-n", viewEmptyWorkspace),
    ("M-C-n", tagToEmptyWorkspace),
    ("M-C-t", sinkAll)
  ]

-- layouts
myLayout =
  let full =
        R.renamed [R.Replace "Full"] $ noBorders Full -- for jumpToLayout
      wide =
        R.renamed [R.Replace "Wide"] $ Mirror tall
      tall =
        R.renamed [R.Replace "Tall"] $ ResizableTall 1 (3 / 100) (1 / 2) []
--      threecol = R.named "Threecol" $ ThreeColMid 1 (3/100) (1/2)
   in lessBorders OnlyScreenFloat $
        avoidStruts
          ( R.renamed [R.CutWordsLeft 1] $
              spacingWithEdge 3 $
                tall ||| wide
          )
          ||| full




-- managehook
myManageHook =
  composeAll
    [ className =? "confirm" --> doFloat,
      className =? "file_progress" --> doFloat,
      className =? "dialog" --> doFloat,
      className =? "download" --> doFloat,
      className =? "error" --> doFloat,
      className =? "freetube" --> MH.doSink,
      className =? "vesktop" --> doShift (myWorkspaces !! 1),
      className =? "discord" --> doShift (myWorkspaces !! 1),
      className =? "float" --> MH.doRectFloat (W.RationalRect 0.25 0.25 0.5 0.5)
    ]
    <+> namedScratchpadManageHook scratchpads
  where
scratchpads =
  let customFloat = customFloating $ W.RationalRect (1 / 12) (1 / 10) (5 / 6) (5 / 6)
   in [ NS "term" (myTerminal ++ " -T term") (title =? "term") customFloat,
        ----NS "passman" myPassMan (className =? myPassMan) customFloat,
        NS "volume" (myTerminal ++ " -T volume -e pulsemixer") (title =? "volume") customFloat,
        NS "top" (myTerminal ++ " -T top -e btm") (title =? "top") customFloat,
        NS "file" (myTerminal ++ " -T file -e " ++ "yazi") (title =? "file") customFloat
      ]

-- eventhook
myHandleEventHook = swallowEventHook (className =? myTerminal) $ return True

-- startuphook
myStartupHook = do
  spawnOnce "xset r rate 200 50 &"
  setWMName "LG3D"

-- statusbar
mySB =
  statusBarProp "xmobar" $
    clickablePP $ -- lifts pp to X pp
      filterOutWsPP [scratchpadWorkspaceTag] $
        def
          {
            --ppCurrent = xmobarColor color09 "",
            ppCurrent = xmobarBorder "Bottom" color09 2,
            ppHidden = xmobarColor color05 "",
            ppTitle = xmobarColor color05 "" . shorten 40,
            ppLayout =
              ( \x -> case x of
                  "Tall" -> "[]="
                  "Wide" -> "TTT"
                  "Dwind" -> "[@]"
                  "Threecol" -> "|||"
                  _ -> x
              ),
            ppSep = "  ",
            ppOrder = \(ws : l : t : _) -> [ws, l, t] -- ++ [t]
          }

main =
  xmonad $
    ewmhFullscreen $
      ewmh $
        withSB mySB $
          docks $
            def
              { terminal = myTerminal,
                modMask = mod4Mask,
                layoutHook = myLayout,
                startupHook = myStartupHook,
                manageHook = myManageHook,
                handleEventHook = myHandleEventHook,
                borderWidth = 4,
                normalBorderColor = color00,
                focusedBorderColor = color09,
                workspaces = myWorkspaces,
                logHook = workspaceHistoryHook
              }
              `additionalKeysP` myKeys
