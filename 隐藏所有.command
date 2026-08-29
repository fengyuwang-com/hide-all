#!/bin/bash
# 隐藏所有 -> 无条件杀掉所有可见应用（注销级暴力），自己也退出
osascript <<'APPLESCRIPT'
set excludedApps to {"Finder", "System Events", "Dock", "loginwindow", "applet", "SystemUIServer", "ControlCenter", "NotificationCenter", "WindowManager"}

tell application "System Events"
    set visibleApps to name of every process whose visible is true
end tell

repeat with appName in visibleApps
    if appName is not in excludedApps then
        try
            do shell script "killall " & quoted form of appName
        end try
    end if
end repeat

tell application "System Events" to set visible of every process whose visible is true to false

-- 杀完所有后，自己也退出
delay 0.5
do shell script "killall applet || true"
do shell script "killall '隐藏所有' || true"
do shell script "killall Terminal || true"
exit
APPLESCRIPT
