# hide-all / 隐藏所有

一键关闭 macOS 上所有可见应用，效果类似“注销”但不注销系统。

> 原 `FengHermes/隐藏所有.command` 已失效，现重构为独立脚本 + AppleScript App。

## 功能
- `visible is true` 的所有应用优雅 `quit`
- 等待 3 秒后仍未退出的 `killall` 强制结束
- 排除系统关键进程：`Finder`, `System Events`, `Dock`, `loginwindow`, `SystemUIServer`, `ControlCenter`, `NotificationCenter`, `WindowManager` 等
- 不是隐藏（Hide），是真正关闭

## 文件

| 文件 | 说明 |
|------|------|
| `隐藏所有.command` | 双击即运行的 shell + osascript 脚本 |
| `hide_all.applescript` | 同逻辑的 AppleScript 源码，可用 `osacompile` 编进 `.app` |
| `/Applications/隐藏所有.app` | 本地已安装的 Dock 壳（`applet`，BundleID `com.user.hideall`） |

## 使用

### 1. 直接运行脚本
```bash
chmod +x "隐藏所有.command"
./"隐藏所有.command"
# 或双击
open "隐藏所有.command"
```

### 2. 编译为 App（已在 /Applications 完成）
```bash
osacompile -o "/Applications/隐藏所有.app/Contents/Resources/Scripts/main.scpt" hide_all.applescript
codesign --force --deep --sign - "/Applications/隐藏所有.app"
killall Dock
```
然后把 `/Applications/隐藏所有.app` 拖到 Dock。

## 安装位置

- 主副本：`~/Documents/隐藏所有.command`
- 兼容旧路径：`~/Documents/FengHermes/隐藏所有.command`
- Dock 指向：`file:///Applications/隐藏所有.app/`

## 警告
会关闭所有可见应用，未保存的文档可能丢失。第二轮强制 kill 前有 3 秒缓冲。

## License
MIT
