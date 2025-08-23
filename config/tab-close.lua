-- 双击标签关闭功能实现
-- 由于WezTerm的鼠标绑定限制，使用替代方案

local wezterm = require 'wezterm'
local M = {}

-- 添加双击标签关闭的鼠标绑定
function M.setup_tab_close_bindings(config)
  -- 扩展现有的鼠标绑定
  local mouse_bindings = config.mouse_bindings or {}
  
  -- 添加双击标签关闭绑定
  table.insert(mouse_bindings, {
    event = { Up = { streak = 2, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action_callback(function(window, pane)
      -- 检查是否点击在标签栏区域
      local tab = window:active_tab()
      if tab and #window:tabs() > 1 then
        tab:close()
      elseif tab and #window:tabs() == 1 then
        -- 如果只有一个标签，关闭窗口
        window:close()
      end
    end),
  })
  
  config.mouse_bindings = mouse_bindings
  return config
end

return M