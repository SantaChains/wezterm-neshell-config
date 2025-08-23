-- 键盘绑定配置模块
-- 包含快捷键、按键映射等设置

local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

function M.apply_to_config(config)
  -- ============================================================================
  -- 基础按键设置
  -- ============================================================================
  
  -- 禁用默认按键绑定
  config.disable_default_key_bindings = false
  
  -- Leader 键设置 (类似 tmux)
  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
  
  -- ============================================================================
  -- 自定义按键绑定
  -- ============================================================================
  
  config.keys = {
    -- ========================================================================
    -- 窗口和面板管理
    -- ========================================================================
    
    -- 分割面板
    {
      key = '|',
      mods = 'LEADER|SHIFT',
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
    
    -- ========================================================================
    -- 标签页管理
    -- ========================================================================
    
    -- 新建标签页
    {
      key = 'c',
      mods = 'LEADER',
      action = act.SpawnTab 'CurrentPaneDomain',
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
    
    -- ========================================================================
    -- 复制粘贴和选择
    -- ========================================================================
    
    -- 复制模式
    {
      key = '[',
      mods = 'LEADER',
      action = act.ActivateCopyMode,
    },
    
    -- 快速复制粘贴
    {
      key = 'c',
      mods = 'CTRL|SHIFT',
      action = act.CopyTo 'Clipboard',
    },
    {
      key = 'v',
      mods = 'CTRL|SHIFT',
      action = act.PasteFrom 'Clipboard',
    },
    
    -- ========================================================================
    -- 搜索功能
    -- ========================================================================
    
    {
      key = 'f',
      mods = 'CTRL|SHIFT',
      action = act.Search { CaseSensitiveString = '' },
    },
    
    -- ========================================================================
    -- 配置和调试
    -- ========================================================================
    
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
    
    -- 显示启动器
    {
      key = 'p',
      mods = 'CTRL|SHIFT',
      action = act.ShowLauncher,
    },
    
    -- ========================================================================
    -- 字体大小调整
    -- ========================================================================
    
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
    
    -- ========================================================================
    -- 全屏和窗口控制
    -- ========================================================================
    
    {
      key = 'F11',
      mods = '',
      action = act.ToggleFullScreen,
    },
    
    -- 隐藏/显示标签栏
    {
      key = 't',
      mods = 'CTRL|SHIFT',
      action = act.EmitEvent 'toggle-tabbar',
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
  
  wezterm.log_info('键盘绑定配置已应用')
end

return M