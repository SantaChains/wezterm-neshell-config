# WezTerm 配置项目核心文档

## 项目概述
这是一个个人的 WezTerm 终端模拟器配置项目，用于在 Windows 11 AMD64 系统上提供优化的终端体验。

## 项目功能
- 自定义 WezTerm 终端外观和行为
- 配置字体、颜色主题和窗口设置
- 键盘快捷键映射
- 跨平台兼容性配置

## 技术架构
- **配置语言**: Lua
- **目标平台**: Windows 11 (主要), 跨平台支持
- **配置文件**: `wezterm.lua`
- **配置目录**: `~/.config/wezterm/` (Windows: `%USERPROFILE%\.config\wezterm\`)

## 核心配置内容
基于当前的 `wezterm.lua` 文件，主要包含：
- 基础 WezTerm 配置对象初始化
- 字体设置
- 颜色方案配置
- 窗口行为设置
- 键盘映射

## 用户要求
1. 完善项目文档结构
2. 生成 .gitignore 文件
3. 清理无关文件
4. 准备 GitHub 推送

## 参考链接
- [WezTerm 官方文档](https://wezfurlong.org/wezterm/)
- [WezTerm 配置参考](https://wezfurlong.org/wezterm/config/files.html)
- [Lua 配置语法](https://wezfurlong.org/wezterm/config/lua/general.html)

## 实例说明
这个配置项目允许用户：
1. 自定义终端外观（字体、颜色、透明度等）
2. 设置个性化快捷键
3. 配置多标签页和窗口管理
4. 跨设备同步配置（通过 Git）

## 更新记录
- 2025/8/23: 初始化项目文档结构