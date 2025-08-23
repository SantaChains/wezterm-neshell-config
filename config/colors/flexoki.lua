-- Flexoki 配色方案
-- 现代化的暖色调配色方案，适合长时间编程使用

local wezterm = require 'wezterm'

local M = {}

-- Flexoki 颜色定义
local colors = {
  -- 基础颜色
  black = '#100f0f',
  paper = '#fffcf0',
  
  -- 灰色调
  tx_3 = '#100f0f',
  tx_2 = '#1c1b1a',
  tx = '#403e3c',
  ui_3 = '#575653',
  ui_2 = '#6f6e69',
  ui = '#878580',
  bg_2 = '#cecdc3',
  bg = '#e6e4d9',
  
  -- 主色调
  red = '#af3029',
  orange = '#bc5215',
  yellow = '#ad8301',
  green = '#66800b',
  cyan = '#24837b',
  blue = '#205ea6',
  purple = '#5e409d',
  magenta = '#a02f6f',
  
  -- 亮色调
  red_2 = '#d14d41',
  orange_2 = '#da702c',
  yellow_2 = '#d0a215',
  green_2 = '#879a39',
  cyan_2 = '#4d9b94',
  blue_2 = '#4385be',
  purple_2 = '#8b7ec8',
  magenta_2 = '#ce5d97',
}

function M.apply_to_config(config)
  -- 设置配色方案
  config.colors = {
    -- 前景和背景
    foreground = colors.tx,
    background = colors.paper,
    
    -- 光标颜色
    cursor_bg = colors.tx,
    cursor_fg = colors.paper,
    cursor_border = colors.tx,
    
    -- 选择区域
    selection_fg = colors.paper,
    selection_bg = colors.blue,
    
    -- 滚动条
    scrollbar_thumb = colors.ui,
    
    -- 分割线
    split = colors.ui_2,
    
    -- ANSI 颜色
    ansi = {
      colors.black,      -- 黑色
      colors.red,        -- 红色
      colors.green,      -- 绿色
      colors.yellow,     -- 黄色
      colors.blue,       -- 蓝色
      colors.magenta,    -- 品红
      colors.cyan,       -- 青色
      colors.bg_2,       -- 白色
    },
    
    -- 明亮 ANSI 颜色
    brights = {
      colors.ui_3,       -- 亮黑色
      colors.red_2,      -- 亮红色
      colors.green_2,    -- 亮绿色
      colors.yellow_2,   -- 亮黄色
      colors.blue_2,     -- 亮蓝色
      colors.magenta_2,  -- 亮品红
      colors.cyan_2,     -- 亮青色
      colors.paper,      -- 亮白色
    },
    
    -- 标签栏颜色
    tab_bar = {
      background = colors.bg,
      
      active_tab = {
        bg_color = colors.paper,
        fg_color = colors.tx,
        intensity = 'Bold',
      },
      
      inactive_tab = {
        bg_color = colors.bg,
        fg_color = colors.ui,
      },
      
      inactive_tab_hover = {
        bg_color = colors.bg_2,
        fg_color = colors.tx_2,
      },
      
      new_tab = {
        bg_color = colors.bg,
        fg_color = colors.ui,
      },
      
      new_tab_hover = {
        bg_color = colors.bg_2,
        fg_color = colors.tx,
      },
    },
    
  }
  
  wezterm.log_info('Flexoki 配色方案已应用')
end

return M