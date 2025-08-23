-- WezTerm 事件处理配置
-- 包含自定义事件、窗口管理、标签栏控制等

local wezterm = require 'wezterm'

local M = {}

function M.setup()
  -- ============================================================================
  -- 标签栏切换事件
  -- ============================================================================
  
  wezterm.on('toggle-tabbar', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    if overrides.hide_tab_bar_if_only_one_tab then
      overrides.hide_tab_bar_if_only_one_tab = false
    else
      overrides.hide_tab_bar_if_only_one_tab = true
    end
    window:set_config_overrides(overrides)
  end)
  
  -- ============================================================================
  -- 窗口标题自定义
  -- ============================================================================
  
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
  
  -- ============================================================================
  -- 标签页标题格式化
  -- ============================================================================
  
  wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#878580'
    local background = '#e6e4d9'
    local foreground = '#403e3c'
    
    if tab.is_active then
      background = '#fffcf0'
      foreground = '#100f0f'
    elseif hover then
      background = '#cecdc3'
      foreground = '#1c1b1a'
    end
    
    local edge_foreground = background
    local title = tab.active_pane.title
    
    -- 限制标题长度
    if #title > max_width - 4 then
      title = title:sub(1, max_width - 7) .. '...'
    end
    
    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = ' ' },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = ' ' .. title .. ' ' },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = ' ' },
    }
  end)
  
  -- ============================================================================
  -- 启动时事件
  -- ============================================================================
  
  wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    
    -- 设置窗口大小和位置
    window:gui_window():set_inner_size(1200, 800)
    window:gui_window():set_position(100, 100)
    
    wezterm.log_info('WezTerm 启动完成')
  end)
  
  -- ============================================================================
  -- 配置重载事件
  -- ============================================================================
  
  wezterm.on('window-config-reloaded', function(window, pane)
    wezterm.log_info('配置已重新加载')
    -- 可以在这里添加重载后的自定义逻辑
  end)
  
  -- ============================================================================
  -- 面板关闭确认
  -- ============================================================================
  
  wezterm.on('window-close-requested', function(window, pane)
    local tab_count = 0
    for _ in pairs(window:mux_window():tabs()) do
      tab_count = tab_count + 1
    end
    
    if tab_count > 1 then
      local choice = wezterm.dialog.confirm {
        title = '确认关闭',
        message = '当前窗口有多个标签页，确定要关闭吗？',
        ok_button = '关闭',
        cancel_button = '取消',
      }
      return choice
    end
    
    return true
  end)
  
  -- ============================================================================
  -- 右键菜单自定义
  -- ============================================================================
  
  wezterm.on('augment-command-palette', function(window, pane)
    return {
      {
        brief = '重新加载配置',
        icon = 'md_refresh',
        action = wezterm.action.ReloadConfiguration,
      },
      {
        brief = '打开配置文件',
        icon = 'md_settings',
        action = wezterm.action.SpawnCommandInNewTab {
          args = { 'code', wezterm.config_file },
        },
      },
      {
        brief = '显示调试信息',
        icon = 'md_bug_report',
        action = wezterm.action.ShowDebugOverlay,
      },
    }
  end)
  
  wezterm.log_info('事件处理器已设置')
end

return M