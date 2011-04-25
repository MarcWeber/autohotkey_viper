;
; WindowPad.ahk
; Version: 0.4
; Last Updated: 11/5/2009
;
; This file contains functions which are useful for manipulating and moving windows.
; This is a stripped down version of WindowPad v.1.56 by Lexikos.
; Downloaded from http://www.autohotkey.com/forum/topic21703.html
;

WindowPadMove(P)
{
     StringSplit, P, P, `,, %A_Space%%A_Tab%
     ; Params: 1:dirX, 2:dirY, 3:widthFactor, 4:heightFactor, 5:window
     
     if P1 =
          P1 = R
     if P2 =
          P2 = R
     
     WindowPad_WinExist(P5)

     if !WinExist()
          return

     ; Determine width/height factors.
     if (P1 or P2) {      ; to a side
          widthFactor  := P3+0 ? P3 : (P1 ? 0.5 : 1.0)
          heightFactor := P4+0 ? P4 : (P2 ? 0.5 : 1.0)
     } else {               ; to center
          widthFactor  := P3+0 ? P3 : 1.0
          heightFactor := P4+0 ? P4 : 1.0
     }
     
     ; Move the window!
     MoveWindowInDirection(P1, P2, widthFactor, heightFactor)
}

MaximizeToggle(P)
{
     WindowPad_WinExist(P)
     
     WinGet, state, MinMax
     if state
          WinRestore
     else
          WinMaximize
}

; Does the grunt work of the script.
MoveWindowInDirection(sideX, sideY, widthFactor, heightFactor)
{
     WinGetPos, x, y, w, h
     
     hwnd:=WinExist()
     if (can_restore := GetWindowProperty(hwnd,"wpHasRestorePos"))
     {   ; Window has restore info. Check if it is where we last put it.
          last_x := GetWindowProperty(hwnd,"wpLastX")
          last_y := GetWindowProperty(hwnd,"wpLastY")
          last_w := GetWindowProperty(hwnd,"wpLastW")
          last_h := GetWindowProperty(hwnd,"wpLastH")
     }
     if (can_restore && last_x = x && last_y = y && last_w = w && last_h = h)
     {   ; Window is where we last put it. Check if user wants to restore.
          if SubStr(sideX,1,1) = "R"
          {   ; Restore on X-axis.
               restore_x := GetWindowProperty(hwnd,"wpRestoreX")
               restore_w := GetWindowProperty(hwnd,"wpRestoreW")
               StringTrimLeft, sideX, sideX, 1
          }
          if SubStr(sideY,1,1) = "R"
          {   ; Restore on Y-axis.
               restore_y := GetWindowProperty(hwnd,"wpRestoreY")
               restore_h := GetWindowProperty(hwnd,"wpRestoreH")
               StringTrimLeft, sideY, sideY, 1
          }
          if (restore_x != "" || restore_y != "")
          {   ; If already at the "restored" size and position, do the normal thing instead.
               if ((restore_x = x || restore_x = "") && (restore_y = y || restore_y = "")
                    && (restore_w = w || restore_w = "") && (restore_h = h || restore_h = ""))
               {
                    restore_x =
                    restore_y =
                    restore_w =
                    restore_h =
               }
          }
     }
     else
     {   ; Next time user requests the window be "restored" use this position and size.
          SetWindowProperty(hwnd,"wpHasRestorePos",true)
          SetWindowProperty(hwnd,"wpRestoreX",x)
          SetWindowProperty(hwnd,"wpRestoreY",y)
          SetWindowProperty(hwnd,"wpRestoreW",w)
          SetWindowProperty(hwnd,"wpRestoreH",h)
          
          if SubStr(sideX,1,1) = "R"
               StringTrimLeft, sideX, sideX, 1
          if SubStr(sideY,1,1) = "R"
               StringTrimLeft, sideY, sideY, 1
     }
     
     ; If no direction specified, restore or only switch monitors.
     if (sideX+0 = "" && restore_x = "")
          restore_x := x, restore_w := w
     if (sideY+0 = "" && restore_y = "")
          restore_y := y, restore_h := h
     
     ; Determine which monitor contains the center of the window.
     m := GetMonitorAt(x+w/2, y+h/2)
     
     ; Get work area of active monitor.
     gosub CalcMonitorStats
     ; Calculate possible new position for window.
     gosub CalcNewSizeAndPosition

     ; If the window is already there,
     if (newx "," newy "," neww "," newh) = (x "," y "," w "," h)
     {   ; ..move to the next monitor along instead.
     
          if (sideX or sideY)
          {   ; Move in the direction of sideX or sideY.
               SysGet, monB, Monitor, %m% ; get bounds of entire monitor (vs. work area)
               x := (sideX=0) ? (x+w/2) : (sideX>0 ? monBRight : monBLeft) + sideX
               y := (sideY=0) ? (y+h/2) : (sideY>0 ? monBBottom : monBTop) + sideY
               newm := GetMonitorAt(x, y, m)
          }
          else
          {   ; Move to center (Numpad5)
               newm := m+1
               SysGet, mon, MonitorCount
               if (newm > mon)
                    newm := 1
          }
     
          if (newm != m)
          {   m := newm
               ; Move to opposite side of monitor (left of a monitor is another monitor's right edge)
               sideX *= -1
               sideY *= -1
               ; Get new monitor's work area.
               gosub CalcMonitorStats
          }
          else
          {   ; No monitor to move to, alternate size of window instead.
               if sideX
                    widthFactor /= 2
               else if sideY
                    heightFactor /= 2
               else
                    widthFactor *= 1.5
               gosub CalcNewSizeAndPosition
          }
          
          ; Calculate new position for window.
          gosub CalcNewSizeAndPosition
     }

     ; Restore before resizing...
     WinGet, state, MinMax
     if state
          WinRestore

     WinDelay := A_WinDelay
     SetWinDelay, 0
     
     ; Move the window!
     WinMove,,, newx, newy, neww, newh
     
     ; For console windows and other windows which have size restrictions, check
     ; that the window was actually resized. If not, reposition based on actual size.
     WinGetPos, newx, newy, realw, realh
     if (neww != realw || newh != realh)
     {
          neww := realw
          newh := realh
          gosub CalcNewPosition
          if ((newm = "" || newm = m) && (newx "," newy "," realw "," realh)=(x "," y "," w "," h))
          {
               if sideX
                    neww //= 2
               else if sideY
                    newh //= 2
               else
                    neww := Round(neww*1.5)
               ; Size first, since the window size will probably be restricted in some way.
               WinMove,,,,, neww, newh
               WinGetPos,,, neww, newh
               gosub CalcNewPosition
          }
          WinMove,,, newx, newy
     }
     
     ; Explorer uses WM_EXITSIZEMOVE to detect when a user finishes moving a window
     ; in order to save the position for next time. May also be used by other apps.
     PostMessage, 0x232
     
     SetWinDelay, WinDelay
     
     ; Remember where we put it, to detect if the user moves it.
     SetWindowProperty(hwnd,"wpLastX",newx)
     SetWindowProperty(hwnd,"wpLastY",newy)
     SetWindowProperty(hwnd,"wpLastW",neww)
     SetWindowProperty(hwnd,"wpLastH",newh)
     return

CalcNewSizeAndPosition:
     ; Calculate new size.
     if (IsResizable()) {
          neww := restore_w != "" ? restore_w : Round(monWidth * widthFactor)
          newh := restore_h != "" ? restore_h : Round(monHeight * heightFactor)
     } else {
          neww := w
          newh := h
     }
CalcNewPosition:
     ; Calculate new position.
     newx := restore_x != "" ? restore_x : Round(monLeft + (sideX+1) * (monWidth  - neww)/2) 
     newy := restore_y != "" ? restore_y : Round(monTop  + (sideY+1) * (monHeight - newh)/2)
     return

CalcMonitorStats:
     ; Get work area (excludes taskbar-reserved space.)
     SysGet, mon, MonitorWorkArea, %m%
     monWidth  := monRight - monLeft
     monHeight := monBottom - monTop
     return
}

; Get/set window property. type should be int, uint or float.
GetWindowProperty(hwnd, property_name, type="int") {
     return DllCall("GetProp", "uint", hwnd, "str", property_name, type)
}
SetWindowProperty(hwnd, property_name, data, type="int") {
     return DllCall("SetProp", "uint", hwnd, "str", property_name, type, data)
}

; Get the index of the monitor containing the specified x and y co-ordinates.
GetMonitorAt(x, y, default=1)
{
     SysGet, m, MonitorCount
     ; Iterate through all monitors.
     Loop, %m%
     {   ; Check if the window is on this monitor.
          SysGet, Mon, Monitor, %A_Index%
          if (x >= MonLeft && x <= MonRight && y >= MonTop && y <= MonBottom)
               return A_Index
     }

     return default
}

IsResizable()
{
     WinGetClass, Class
     if Class = Chrome_XPFrame
          return true
     if Class = ConsoleWindowClass
          return false
     WinGet, Style, Style
     return (Style & 0x40000) ; WS_SIZEBOX
}

WindowPad_WinExist(WinTitle)
{
     if WinTitle = P
          return WinPreviouslyActive()
     if WinTitle = M
     {
          MouseGetPos,,, win
          return WinExist("ahk_id " win)
     }
     return WinExist(WinTitle!="" ? WinTitle : "A")
}

; Note: This may not work properly with always-on-top windows. (Needs testing)
WinPreviouslyActive()
{
     active := WinActive("A")
     WinGet, win, List

     ; Find the active window.
     ; (Might not be win1 if there are always-on-top windows?)
     Loop, %win%
          if (win%A_Index% = active)
          {
               if (A_Index < win)
                    N := A_Index+1
               
               ; hack for PSPad: +1 seems to get the document (child!) window, so do +2
               ifWinActive, ahk_class TfPSPad
                    N += 1
               
               break
          }

     ; Use WinExist to set Last Found Window (for consistency with WinActive())
     return WinExist("ahk_id " . win%N%)
}


;
; Switch without moving/resizing (relative to screen)
;
WindowScreenMove(P)
{
     SetWinDelay, 0
     
     StringSplit, P, P, `,, %A_Space%%A_Tab%
     ; 1:Next|Prev|Num, 2:Window
     
     WindowPad_WinExist(P2)

     WinGet, state, MinMax
     if state = 1
          WinRestore

     WinGetPos, x, y, w, h
     
     ; Determine which monitor contains the center of the window.
     ms := GetMonitorAt(x+w/2, y+h/2)
     
     SysGet, mc, MonitorCount

     ; Determine which monitor to move to.
     if P1 in ,N,Next
     {
          md := ms+1
          if (md > mc)
               md := 1
     }
     else if P1 in P,Prev,Previous
     {
          md := ms-1
          if (md < 1)
               md := mc
     }
     else if P1 is integer
          md := P1
     
     if (md=ms or (md+0)="" or md<1 or md>mc)
          return
     
     ; Get source and destination work areas (excludes taskbar-reserved space.)
     SysGet, ms, MonitorWorkArea, %ms%
     SysGet, md, MonitorWorkArea, %md%
     msw := msRight - msLeft, msh := msBottom - msTop
     mdw := mdRight - mdLeft, mdh := mdBottom - mdTop
     
     ; Calculate new size.
     if (IsResizable()) {
          w := Round(w*(mdw/msw))
          h := Round(h*(mdh/msh))
     }
     
     ; Move window, using resolution difference to scale co-ordinates.
     WinMove,,, mdLeft + (x-msLeft)*(mdw/msw), mdTop + (y-msTop)*(mdh/msh), w, h

     if state = 1
          WinMaximize
}


;
; "Gather" windows on a specific screen.
;
GatherWindows(md=1)
{
     global ProcessGatherExcludeList
     
     SetWinDelay, 0
     
     ; List all visible windows.
     WinGet, win, List
     
     ; Copy bounds of all monitors to an array.
     SysGet, mc, MonitorCount
     Loop, %mc%
          SysGet, mon%A_Index%, MonitorWorkArea, %A_Index%
     
     if md = M
     {   ; Special exception for 'M', since the desktop window
          ; spreads across all screens.
          CoordMode, Mouse, Screen
          MouseGetPos, x, y
          md := GetMonitorAt(x, y, 0)
     }
     else if md is not integer
     {   ; Support A, P and WinTitle.
          ; (Gather at screen containing specified window.)
          WindowPad_WinExist(md)
          WinGetPos, x, y, w, h
          md := GetMonitorAt(x+w/2, y+h/2, 0)
     }
     if (md<1 or md>mc)
          return
     
     ; Destination monitor
     mdx := mon%md%Left
     mdy := mon%md%Top
     mdw := mon%md%Right - mdx
     mdh := mon%md%Bottom - mdy
     
     Loop, %win%
     {
          ; If this window matches the GatherExclude group, don't touch it.
          if (WinExist("ahk_group GatherExclude ahk_id " . win%A_Index%))
               continue
          
          ; Set Last Found Window.
          if (!WinExist("ahk_id " . win%A_Index%))
               continue

          WinGet, procname, ProcessName
          ; Check process (program) exclusion list.
          if procname in %ProcessGatherExcludeList%
               continue
          
          WinGetPos, x, y, w, h
          
          ; Determine which monitor this window is on.
          xc := x+w/2, yc := y+h/2
          ms := 0
          Loop, %mc%
               if (xc >= mon%A_Index%Left && xc <= mon%A_Index%Right
                    && yc >= mon%A_Index%Top && yc <= mon%A_Index%Bottom)
               {
                    ms := A_Index
                    break
               }
          ; If already on destination monitor, skip this window.
          if (ms = md)
               continue
          
          WinGet, state, MinMax
          if (state = 1) {
               WinRestore
               WinGetPos, x, y, w, h
          }
     
          if ms
          {
               ; Source monitor
               msx := mon%ms%Left
               msy := mon%ms%Top
               msw := mon%ms%Right - msx
               msh := mon%ms%Bottom - msy
               
               ; If the window is resizable, scale it by the monitors' resolution difference.
               if (IsResizable()) {
                    w *= (mdw/msw)
                    h *= (mdh/msh)
               }
          
               ; Move window, using resolution difference to scale co-ordinates.
               WinMove,,, mdx + (x-msx)*(mdw/msw), mdy + (y-msy)*(mdh/msh), w, h
          }
          else
          {   ; Window not on any monitor, move it to center.
               WinMove,,, mdx + (mdw-w)/2, mdy + (mdh-h)/2
          }

          if state = 1
               WinMaximize
     }
}

GetLastMinimizedWindow()
{
     WinGet, w, List

     Loop %w%
     {
          wi := w%A_Index%
          WinGet, m, MinMax, ahk_id %wi%
          if m = -1 ; minimized
          {
               lastFound := wi
               break
          }
     }

     return "ahk_id " . (lastFound ? lastFound : 0)
}
