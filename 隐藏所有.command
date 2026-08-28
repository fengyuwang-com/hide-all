#!/bin/bash
# 隐藏所有 -> 关闭所有可见应用（类似注销）
# 放在 Documents/隐藏所有.command
# 逻辑：优雅 quit 所有 visible 进程，3秒后仍未退出的强制 kill

osascript <<'APPLESCRIPT'
set excludedApps to {"Finder", "System Events", "Dock", "loginwindow", "隐藏所有", "applet", "SystemUIServer", "ControlCenter", "NotificationCenter", "WindowManager"}

tell application "System Events"
    set visibleApps to name of every process whose visible is true
end tell

-- 第一轮：优雅退出
repeat with appName in visibleApps
    if appName is not in excludedApps then
        try
            tell application appName to quit
        end try
    end if
end repeat

-- 等待3秒让应用保存/退出
delay 3

-- 第二轮：仍在运行的强制结束（模拟注销）
tell application "System Events"
    set stillVisible to name of every process whose visible is true
end tell

repeat with appName in stillVisible
    if appName is not in excludedApps then
        try
            do shell script "killall " & quoted form of appName
        end try
        try
            tell application "System Events" to set visible of process appName to false
        end try
    end if
end repeat
APPLESCRIPT
