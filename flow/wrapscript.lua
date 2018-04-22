local script_global_scope = {
  --- Module with functions for async operations
  wait = require "flow.flow",
  --- Module with supportive functions for cut-scenes
  narrative = require "flow.narrative",
  --
  global = require "global",
  --
  monarch = require "monarch.monarch",
  --
  msg = msg,
  --
  go = go,
  --
  gui = gui,
  --
  print = print,
}

setmetatable(script_global_scope, { __index = _G })

return function (func)
  setfenv(func, script_global_scope)
end
