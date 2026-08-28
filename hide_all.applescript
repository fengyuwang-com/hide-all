-- 隐藏所有.app 自包含逻辑：关闭所有可见应用（类似注销），不是隐藏
-- 同时兼容外部 Documents/隐藏所有.command
set excludedApps to {"Finder", "System Events", "Dock", "loginwindow", "隐藏所有", "applet", "SystemUIServer", "ControlCenter", "NotificationCenter", "WindowManager"}

tell application "System Events"
    set visibleApps to name of every process whose visible is true
end tell

repeat with appName in visibleApps
    if appName is not in excludedApps then
        try
            tell application appName to quit
        end try
    end if
end repeat

delay 3

tell application "System Events"
    set stillVisible to name of every process whose visible is true
end tell

repeat with appName in stillVisible
    if appName is not in excludedApps then
        try
            do shell script "killall " & quoted form of appName
        end try
    end if
end repeat
