# WezTerm 配置

个人的 WezTerm 终端模拟器配置文件，针对 Windows 11 系统优化。

## 安装使用

1. 安装 WezTerm：
   ```bash
   # Windows (使用 winget)
   winget install wez.wezterm
   ```

2. 克隆此配置：
   ```bash
   git clone https://github.com/SantaChains/wezterm-neshell-config.git
   ```

3. 重启 WezTerm 即可生效

## 配置特性

- 🎨 双主题切换 (浅色护眼/深色主题)
- 🪟 Windows 11 Acrylic 毛玻璃效果
- ⚡ GPU 加速渲染 (WebGpu)
- 🔤 优化字体配置 (JetBrains Mono + 中文回退)
- ⌨️ Vim 风格键盘映射
- 📋 多标签页管理
- 🖱️ 智能鼠标操作

## 快捷键

### Leader 键: `Alt + A`

| 快捷键 | 功能 |
|--------|------|
| `Ctrl + Alt + T` | 切换浅色/深色主题 |
| `Leader + =` | 水平分割面板 |
| `Leader + -` | 垂直分割面板 |
| `Leader + hjkl` | 面板导航 |
| `Leader + 方向键` | 调整面板大小 |
| `Leader + x` | 关闭当前面板 |
| `Leader + c` | 新建标签页 |
| `Leader + 1-5` | 切换到指定标签页 |
| `Alt + ` ` | 切换窗口边框 |

## 主题说明

- **浅色主题**: 宣纸米色护眼配色，适合长时间编程
- **深色主题**: Gruvbox 字体 + Tokyo Night 背景，夜间使用

## 系统要求

- Windows 11 (支持 Acrylic 效果)
- WezTerm 最新版本
- PowerShell 7 / Nushell (可选)

## 配置文件结构

```
~/.config/wezterm/
├── wezterm.lua          # 主配置文件
├── current_theme.txt    # 主题偏好设置 (自动生成)
└── config/
    └── nushell-config.nu # Nushell 配置 (可选)
