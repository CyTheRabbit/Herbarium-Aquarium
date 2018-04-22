-- Button module
-- simplyfies button creation and handling by remembering its

-- Usage:

-- Create button using function returned from require, assign node, callback and
-- default arguments to it:
--
-- local button = require 'modules.button'
-- local inc_btn = button(
--     gui.get_node 'inc_btn',
--     function(i) a = a + i end,
--     { 1 })

-- You can change this properties later in runtime:
--
-- inc_btn.node = gui.get_node 'dec_btn'
-- inc_btn.callback = function(i) a = a - i end
-- inc_btn.defaults = { 2 }

-- You can initialize buttons in such way:
--
-- local dec_btn = button()
-- dec_btn.node = gui.get_node 'dec_btn'
-- dec_btn.callback = function(i) b = b - i end
-- dec_btn.defaults = { 1 }

-- You process button simply by calling it with action table and arguments for
-- callback function as params:
--
-- if action_id == hash 'click' then
--   inc_btn(action, { 10 })
-- end


local CLICK_SCALE_TO = vmath.vector3(0.1, 0.1, 1)
local TIME = 0.2

local function set_call(table, func)
  setmetatable(table, { __call = func })
end

local function create_button(node, callback, defaults)
  local args -- passed to callback
  local size -- nodes original size

  local button = {}
  button.node = node
  button.callback = callback
  button.defaults = defaults
  button.active = true

  local function toggle_active()
    button.active = not button.active
  end

  local function on_click()
    button.callback(unpack(args))
    gui.animate(button.node,
        gui.PROP_SCALE, size,
        gui.EASING_INSINE, TIME, 0,
        toggle_active)
  end

  local function check_click(self, action, params)
    if not button.active then return end
    if not gui.pick_node(button.node, action.x, action.y) then return end
    toggle_active()
    args = params or button.defaults
    size = gui.get_scale(button.node)
    gui.animate(button.node,
        gui.PROP_SCALE, size + CLICK_SCALE_TO,
        gui.EASING_INSINE, TIME, 0,
        on_click)
  end

  set_call(button, check_click)

  return button
end

return create_button
