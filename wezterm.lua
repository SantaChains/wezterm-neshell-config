-- WezTerm 主配置文件
-- 针对 Windows 11 环境优化，支持磨砂背景效果和现代化特性

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ============================================================================
-- 主题切换功能 (浅色/深色主题)
-- ============================================================================

local theme_manager = {}

-- 读取上次保存的主题设置
local function load_theme_preference()
  local success, theme_file = pcall(io.open, wezterm.config_dir .. '/current_theme.txt', 'r')
  if success and theme_file then
    local saved_theme = theme_file:read('*line')
    theme_file:close()
    return saved_theme == 'dark' and 'dark' or 'light'
  end
  return 'light'  -- 默认浅色主题
end

-- 保存当前主题设置
local function save_theme_preference(theme_name)
  local success, theme_file = pcall(io.open, wezterm.config_dir .. '/current_theme.txt', 'w')
  if success and theme_file then
    theme_file:write(theme_name)
    theme_file:close()
  end
end

theme_manager.current_theme = load_theme_preference()

-- 浅色主题配置 (宣纸米色护眼)
theme_manager.light_theme = {
  background = {
    {
      source = { Color = '#f7f3e9' },  -- 宣纸米色
      height = "100%",
      width = "100%",
      opacity = 0.88,
    },
    {
      source = { Color = '#f0ebe1' },  -- 温润米白
      height = "100%",
      width = "100%",
      opacity = 0.70,
    },
    {
      source = { Color = '#e8e0d0' },  -- 淡雅米黄
      height = "100%",
      width = "100%",
      opacity = 0.35,
    },
  },
  colors = {
    foreground = '#2c2c2c',
    background = '#f7f3e9',
    cursor_bg = '#2c2c2c',
    cursor_fg = '#f7f3e9',
    selection_bg = '#d4c4a8',
    selection_fg = '#2c2c2c',
    ansi = {
      '#2c2c2c',  -- black
      '#d14d41',  -- red
      '#879a39',  -- green
      '#d0a215',  -- yellow
      '#205ea6',  -- blue
      '#af3a03',  -- magenta
      '#24837b',  -- cyan (注释颜色改为深青色，提高可读性)
      '#6c6c6c',  -- white
    },
    brights = {
      '#6c6c6c',  -- bright black
      '#d14d41',  -- bright red
      '#879a39',  -- bright green
      '#d0a215',  -- bright yellow
      '#205ea6',  -- bright blue
      '#af3a03',  -- bright magenta
      '#24837b',  -- bright cyan
      '#2c2c2c',  -- bright white
    },
  }
}

-- 深色主题配置 (Gruvbox 字体 + Tokyo Night 背景)
theme_manager.dark_theme = {
  background = {
    {
      source = { Color = '#1a1b26' },  -- Tokyo Night 深色背景
      height = "100%",
      width = "100%",
      opacity = 0.85,
    },
    {
      source = { Color = '#24283b' },  -- Tokyo Night 中层
      height = "100%",
      width = "100%",
      opacity = 0.65,
    },
    {
      source = { Color = '#414868' },  -- Tokyo Night 顶层
      height = "100%",
      width = "100%",
      opacity = 0.30,
    },
  },
  colors = {
    foreground = '#ebdbb2',  -- Gruvbox 前景色
    background = '#1a1b26',  -- Tokyo Night 背景
    cursor_bg = '#ebdbb2',   -- Gruvbox 光标
    cursor_fg = '#1a1b26',   -- Tokyo Night 背景
    selection_bg = '#504945', -- Gruvbox 选择背景
    selection_fg = '#ebdbb2', -- Gruvbox 选择前景
    ansi = {
      '#32302f',  -- Gruvbox dark0 (black)
      '#fb4934',  -- Gruvbox bright_red
      '#b8bb26',  -- Gruvbox bright_green
      '#fabd2f',  -- Gruvbox bright_yellow
      '#83a598',  -- Gruvbox bright_blue
      '#d3869b',  -- Gruvbox bright_purple
      '#8ec07c',  -- Gruvbox bright_aqua (注释颜色，清晰可读)
      '#ebdbb2',  -- Gruvbox light1 (white)
    },
    brights = {
      '#665c54',  -- Gruvbox gray (bright black)
      '#fb4934',  -- Gruvbox bright_red
      '#b8bb26',  -- Gruvbox bright_green
      '#fabd2f',  -- Gruvbox bright_yellow
      '#83a598',  -- Gruvbox bright_blue
      '#d3869b',  -- Gruvbox bright_purple
      '#8ec07c',  -- Gruvbox bright_aqua
      '#fbf1c7',  -- Gruvbox light0 (bright white)
    },
  }
}

-- 应用当前主题
function theme_manager.apply_theme(config, theme_name)
  local theme = theme_name == 'dark' and theme_manager.dark_theme or theme_manager.light_theme
  config.background = theme.background
  config.colors = theme.colors
  theme_manager.current_theme = theme_name
end

-- ============================================================================
-- 基础配置
-- ============================================================================

-- 默认程序设置为 Nushell (处理路径空格)，并加载自定义配置
config.default_prog = { 
  'C:\\Users\\Jliu Pureey\\AppData\\Local\\Programs\\nu\\bin\\nu.exe',
  '--config',
  'C:\\Users\\Jliu Pureey\\.config\\wezterm\\config\\nushell-config.nu'
}

-- 启动时的窗口大小
config.initial_cols = 120
config.initial_rows = 30

-- ============================================================================
-- Windows 磨砂背景效果配置
-- ============================================================================

-- Windows 11 Acrylic 背景支持
config.win32_system_backdrop = "Acrylic"

-- 重新设计的高斯模糊毛玻璃背景
config.window_background_opacity = 0.60  -- 更强的透明效果 (增强毛玻璃感)
config.macos_window_background_blur = 80  -- 增强高斯模糊强度 (更强模糊)

-- 初始应用浅色主题
theme_manager.apply_theme(config, 'light')

-- ============================================================================
-- 性能优化配置
-- ============================================================================

-- 启用 GPU 加速 (WebGpu 前端)
config.front_end = "WebGpu"

-- 最大帧率
config.max_fps = 120

-- 启用硬件加速
config.enable_wayland = false

-- ============================================================================
-- 窗口和外观配置
-- ============================================================================

-- 窗口装饰 (隐藏边框，通过快捷键切换)
config.window_decorations = "NONE"

-- 启用窗口拖动功能 (隐藏边框模式) - Flexoki 主题
config.window_frame = {
  -- 字体配置
  font = wezterm.font { family = 'Segoe UI', weight = 'Bold' },
  font_size = 9.0,
  -- 标题栏颜色 (Flexoki 暖色调)
  active_titlebar_bg = '#e6e4d9',   -- Flexoki bg
  inactive_titlebar_bg = '#cecdc3', -- Flexoki bg_2
}

-- 启用 IME 支持 (中文输入法)
config.use_ime = true

-- 窗口边距和圆角设计
config.window_padding = {
  left = 16,
  right = 16,
  top = 12,
  bottom = 12,
}

-- ============================================================================
-- 字体配置
-- ============================================================================

-- 主字体配置，优先使用编程字体，包含中文字体回退
config.font = wezterm.font_with_fallback {
  {
    family = 'JetBrains Mono',
    weight = 'Medium',
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
  },
  {
    family = 'Cascadia Code',
    weight = 'Medium',
  },
  {
    family = 'Consolas',
    weight = 'Medium',
  },
  {
    family = 'Microsoft YaHei UI',
    weight = 'Medium',
  },
  {
    family = 'Segoe UI Emoji',
  },
}

config.font_size = 11.0
config.line_height = 1.2

-- 光标配置 (心跳频率 60-100 BPM，选择75 BPM)
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 800  -- 800ms = 75 BPM 心跳频率
config.cursor_blink_ease_in = 'Ease'
config.cursor_blink_ease_out = 'Ease'

-- ============================================================================
-- 标签栏配置
-- ============================================================================

-- 使用简洁的标签栏样式
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false  -- 始终显示标签栏

-- 标签栏样式 (保留新建标签按钮)
config.tab_max_width = 32
config.show_tab_index_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true  -- 显示新建标签的加号按钮

-- 新建标签按钮样式自定义 (Flexoki 主题)
config.tab_bar_style = {
  new_tab = wezterm.format {
    { Background = { Color = '#e6e4d9' } },  -- Flexoki bg
    { Foreground = { Color = '#205ea6' } },  -- Flexoki blue
    { Text = ' + ' },
  },
  new_tab_hover = wezterm.format {
    { Background = { Color = '#cecdc3' } },  -- Flexoki bg_2
    { Foreground = { Color = '#4385be' } },  -- Flexoki blue_2
    { Text = ' + ' },
  },
}

-- 启动器菜单配置 (右键新建按钮显示关闭标签选项)
config.launch_menu = {
  {
    label = '🗙 关闭当前标签',
    args = { 'cmd', '/c', 'echo', 'close-current-tab' },
  },
  {
    label = '🗙 关闭其他标签',
    args = { 'cmd', '/c', 'echo', 'close-other-tabs' },
  },
  {
    label = '🗙 关闭左侧标签',
    args = { 'cmd', '/c', 'echo', 'close-left-tabs' },
  },
  {
    label = '🗙 关闭第一个标签',
    args = { 'cmd', '/c', 'echo', 'close-first-tab' },
  },
  {
    label = '📋 新建标签 (PowerShell)',
    args = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' },
  },
  {
    label = '📋 新建标签 (Nushell)',
    args = { 'C:\\Users\\Jliu Pureey\\AppData\\Local\\Programs\\nu\\bin\\nu.exe' },
  },
}

-- 修复文件路径显示重影问题
config.text_background_opacity = 1.0
config.window_background_gradient = nil  -- 移除渐变避免重影

-- ============================================================================
-- 键盘绑定配置
-- ============================================================================

-- Leader 键设置 (实际可行的组合键)
config.leader = { key = 'a', mods = 'ALT', timeout_milliseconds = 1000 }

-- 自定义按键绑定
local act = wezterm.action
config.keys = {
  -- 分割面板
  {
    key = '=',
    mods = 'LEADER',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  
  -- 面板导航
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection 'Right',
  },
  
  -- 面板大小调整
  {
    key = 'LeftArrow',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'RightArrow',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'UpArrow',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Up', 5 },
  },
  {
    key = 'DownArrow',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Down', 5 },
  },
  
  -- 关闭面板
  {
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true },
  },
  
  -- 新建标签页 (Ctrl+T) - 启动 PowerShell 7
  {
    key = 't',
    mods = 'CTRL',
    action = act.SpawnCommandInNewTab {
      args = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' },
    },
  },
  
  -- 关闭标签页 (Ctrl+W)
  {
    key = 'w',
    mods = 'CTRL',
    action = act.CloseCurrentTab { confirm = false },
  },
  
  -- 新建标签页 (Leader + c) - 启动 PowerShell 7
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnCommandInNewTab {
      args = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' },
    },
  },
  
  -- 标签页导航
  {
    key = 'n',
    mods = 'LEADER',
    action = act.ActivateTabRelative(1),
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = act.ActivateTabRelative(-1),
  },
  
  -- 数字键切换标签页
  {
    key = '1',
    mods = 'LEADER',
    action = act.ActivateTab(0),
  },
  {
    key = '2',
    mods = 'LEADER',
    action = act.ActivateTab(1),
  },
  {
    key = '3',
    mods = 'LEADER',
    action = act.ActivateTab(2),
  },
  {
    key = '4',
    mods = 'LEADER',
    action = act.ActivateTab(3),
  },
  {
    key = '5',
    mods = 'LEADER',
    action = act.ActivateTab(4),
  },
  
  -- 复制粘贴 (标准快捷键)
  {
    key = 'c',
    mods = 'CTRL',
    action = act.CopyTo 'Clipboard',
  },
  {
    key = 'v',
    mods = 'CTRL',
    action = act.PasteFrom 'Clipboard',
  },
  
  -- 全选当前输入 (Ctrl+A)
  {
    key = 'a',
    mods = 'CTRL',
    action = act.SendKey { key = 'a', mods = 'CTRL' },
  },
  
  -- 全选整个页面 (Ctrl+Shift+A)
  {
    key = 'a',
    mods = 'CTRL|SHIFT',
    action = act.ActivateCopyMode,
  },
  
  -- 复制模式
  {
    key = '[',
    mods = 'LEADER',
    action = act.ActivateCopyMode,
  },
  
  -- 搜索功能
  {
    key = 'f',
    mods = 'CTRL|SHIFT',
    action = act.Search { CaseSensitiveString = '' },
  },
  
  -- 重新加载配置
  {
    key = 'r',
    mods = 'CTRL|SHIFT',
    action = act.ReloadConfiguration,
  },
  
  -- 显示调试覆盖层
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = act.ShowDebugOverlay,
  },
  
  -- 字体大小调整
  {
    key = '=',
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },
  {
    key = '-',
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
  {
    key = '0',
    mods = 'CTRL',
    action = act.ResetFontSize,
  },
  
  -- 全屏切换
  {
    key = 'F11',
    mods = '',
    action = act.ToggleFullScreen,
  },
  
  -- 切换窗口边框显示 (Alt + `)
  {
    key = '`',
    mods = 'ALT',
    action = act.EmitEvent 'toggle-window-decorations',
  },
  
  -- 关闭标签快捷键增强
  {
    key = 'q',
    mods = 'LEADER',
    action = act.CloseCurrentTab { confirm = true },
  },
  
  -- 显示启动器菜单 (包含关闭标签选项)
  {
    key = 'm',
    mods = 'LEADER',
    action = act.ShowLauncher,
  },
  
  -- 关闭其他标签
  {
    key = 'o',
    mods = 'LEADER',
    action = act.EmitEvent 'close-other-tabs',
  },
  
  -- 关闭左侧标签
  {
    key = 'h',
    mods = 'LEADER|SHIFT',
    action = act.EmitEvent 'close-left-tabs',
  },
  
  -- 关闭第一个标签
  {
    key = '1',
    mods = 'LEADER|SHIFT',
    action = act.EmitEvent 'close-first-tab',
  },
  
  -- 主题切换快捷键 (Ctrl + Alt + T)
  {
    key = 't',
    mods = 'CTRL|ALT',
    action = act.EmitEvent 'toggle-theme',
  },
}

-- ============================================================================
-- 鼠标绑定
-- ============================================================================

config.mouse_bindings = {
  -- 右键粘贴
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = act.PasteFrom 'Clipboard',
  },
  
  -- Ctrl+点击打开链接
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

-- ============================================================================
-- 其他配置
-- ============================================================================

-- 启用配置重载
config.automatically_reload_config = true

-- 滚动条配置
config.enable_scroll_bar = true
config.scrollback_lines = 10000

-- 窗口关闭行为
config.window_close_confirmation = 'NeverPrompt'
config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'fish',
  'tmux',
  'nu',
  'nu.exe',
  'cmd.exe',
  'pwsh.exe',
  'powershell.exe'
}

-- 启用 Kitty 图像协议支持
config.enable_kitty_graphics = true

-- 启用 CSI u 模式
config.enable_csi_u_key_encoding = true

-- ============================================================================
-- 事件处理
-- ============================================================================

-- 主题切换事件处理
wezterm.on('toggle-theme', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  
  if theme_manager.current_theme == 'light' then
    -- 切换到深色主题
    overrides.background = theme_manager.dark_theme.background
    overrides.colors = theme_manager.dark_theme.colors
    theme_manager.current_theme = 'dark'
    save_theme_preference('dark')
    wezterm.log_info('已切换到深色主题 (Gruvbox 字体 + Tokyo Night 背景)')
  else
    -- 切换到浅色主题
    overrides.background = theme_manager.light_theme.background
    overrides.colors = theme_manager.light_theme.colors
    theme_manager.current_theme = 'light'
    save_theme_preference('light')
    wezterm.log_info('已切换到浅色主题 (宣纸米色护眼)')
  end
  
  window:set_config_overrides(overrides)
end)

-- 标签标题格式化 (显示当前文件夹名称，12字符内完整显示，显示序号)
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  local cwd = tab.active_pane.current_working_dir
  
  -- 提取文件夹名称
  if cwd then
    local folder_name = string.match(cwd.file_path, "([^/\\]+)[/\\]*$")
    if folder_name then
      title = folder_name
    end
  end
  
  -- 标签序号 (从1开始)
  local tab_index = tab.tab_index + 1
  
  -- 12字符内完整显示，超过则截断
  if #title <= 12 then
    -- 12字符内完整显示，带序号
    return {
      { Text = ' ' .. tab_index .. ': ' .. title .. ' ' },
    }
  else
    -- 超过12字符则截断，带序号
    title = title:sub(1, 7) .. '...'
    return {
      { Text = ' ' .. tab_index .. ': ' .. title .. ' ' },
    }
  end
end)

-- 窗口标题自定义
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  local zoomed = ''
  if tab.active_pane.is_zoomed then
    zoomed = '[Z] '
  end
  
  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
  end
  
  return zoomed .. index .. tab.active_pane.title
end)

-- 切换窗口边框事件
wezterm.on('toggle-window-decorations', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if overrides.window_decorations then
    overrides.window_decorations = nil
  else
    overrides.window_decorations = "TITLE | RESIZE"
  end
  window:set_config_overrides(overrides)
end)

-- 双击标签关闭事件处理
wezterm.on('user-var-changed', function(window, pane, name, value)
  if name == 'close-tab' then
    local tab = window:active_tab()
    if tab then
      tab:close()
    end
  end
end)

-- 配置重载事件
wezterm.on('window-config-reloaded', function(window, pane)
  wezterm.log_info('配置已重新加载')
end)

-- 关闭其他标签事件
wezterm.on('close-other-tabs', function(window, pane)
  local tabs = window:mcp_get_tabs()
  local current_tab = window:active_tab()
  
  for _, tab in ipairs(tabs) do
    if tab:tab_id() ~= current_tab:tab_id() then
      tab:close()
    end
  end
end)

-- 关闭左侧标签事件
wezterm.on('close-left-tabs', function(window, pane)
  local tabs = window:mcp_get_tabs()
  local current_tab = window:active_tab()
  local current_index = current_tab:tab_index()
  
  for i = 0, current_index - 1 do
    if tabs[i + 1] then
      tabs[i + 1]:close()
    end
  end
end)

-- 关闭第一个标签事件
wezterm.on('close-first-tab', function(window, pane)
  local tabs = window:mcp_get_tabs()
  if tabs[1] then
    tabs[1]:close()
  end
end)

return config