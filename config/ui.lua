-- UI 和外观配置模块
-- 包含字体、颜色、窗口外观等设置

local wezterm = require 'wezterm'
local flexoki = require 'config.colors.flexoki'

local M = {}

function M.apply_to_config(config)
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
  config.cell_width = 1.0
  
  -- 字体抗锯齿
  config.freetype_load_target = 'Normal'
  config.freetype_render_target = 'Normal'
  
  -- ============================================================================
  -- 颜色和主题配置
  -- ============================================================================
  
  -- 使用 Flexoki 配色方案
  flexoki.apply_to_config(config)
  
  -- 光标配置
  config.default_cursor_style = 'BlinkingBlock'
  config.cursor_blink_rate = 500
  config.cursor_blink_ease_in = 'Constant'
  config.cursor_blink_ease_out = 'Constant'
  
  -- ============================================================================
  -- 窗口外观配置
  -- ============================================================================
  
  -- 窗口装饰 (Windows 11 集成按钮)
  config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
  
  -- 窗口背景透明度和模糊效果
  config.window_background_opacity = 0.92
  config.text_background_opacity = 1.0
  
  -- Windows 11 Acrylic 背景效果
  config.win32_system_backdrop = 'Acrylic'
  
  -- 窗口边距
  config.window_padding = {
    left = 12,
    right = 12,
    top = 8,
    bottom = 8,
  }
  
  -- 窗口关闭行为
  config.window_close_confirmation = 'NeverPrompt'
  config.skip_close_confirmation_for_processes_named = {
    'bash',
    'sh',
    'zsh',
    'fish',
    'tmux',
    'nu',
    'cmd.exe',
    'pwsh.exe',
    'powershell.exe'
  }
  
  -- ============================================================================
  -- 标签栏配置
  -- ============================================================================
  
  -- 使用简洁的标签栏样式
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = false
  config.hide_tab_bar_if_only_one_tab = true
  
  -- 标签栏样式
  config.tab_max_width = 32
  config.show_tab_index_in_tab_bar = false
  config.show_new_tab_button_in_tab_bar = false
  
  -- ============================================================================
  -- 滚动条配置
  -- ============================================================================
  
  config.enable_scroll_bar = true
  config.scrollback_lines = 10000
  
  -- ============================================================================
  -- 其他 UI 配置
  -- ============================================================================
  
  -- 启用 Kitty 图像协议支持
  config.enable_kitty_graphics = true
  
  -- 启用 CSI u 模式
  config.enable_csi_u_key_encoding = true
  
  wezterm.log_info('UI 配置已应用')
end

return M