-- Automatically reload config
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local hyper = {"ctrl", "cmd"}
local shift_hyper = {"shift", "ctrl", "cmd"}

hs.hotkey.bind(shift_hyper, "v", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

hs.window.animationDuration = 0.00

hs.loadSpoon("MiroWindowsManager")
window_manager = spoon.MiroWindowsManager 
window_manager.sizes = {1, 4/3, 3/2, 2, 4}
window_manager.fullScreenSizes = {1}

window_manager:bindHotkeys({
  up = {hyper, "k"},
  right = {hyper, "l"},
  down = {hyper, "j"},
  left = {hyper, "h"},
  fullscreen = {hyper, "f"},
  nextscreen = {hyper, "n"},
})

-- Cycle current window through monitors
-- https://stackoverflow.com/questions/54151343/how-to-move-an-application-between-monitors-in-hammerspoon
hs.hotkey.bind(hyper, "m", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  -- compute the unitRect of the focused window relative to the current screen
  -- and move the window to the next screen setting the same unitRect
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

hs.hotkey.bind(hyper, "c", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local max = win:screen():frame()

  if win:isMaximizable() then
    f.h = max.h
    f.w = max.w*2/3
    f.x = ((max.w - f.w) / 2) + max.x
    f.y = 0
  else
    f.x = ((max.w - f.w) / 2) + max.x
    f.y = ((max.h - f.h) / 2) + max.y
  end

	win:setFrame(f)
end)

local function moveWindowRelative(moveX, moveY)
  local moveAmount = 10;

  return function()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.x = f.x + moveX * moveAmount
    f.y = f.y + moveY * moveAmount
    win:setFrame(f)
  end
end

hs.hotkey.bind(shift_hyper, "l", moveWindowRelative(1, 0), nil, moveWindowRelative(1, 0))
hs.hotkey.bind(shift_hyper, "h", moveWindowRelative(-1, 0), nil, moveWindowRelative(-1, 0))
hs.hotkey.bind(shift_hyper, "j", moveWindowRelative(0, 1), nil, moveWindowRelative(0, 1))
hs.hotkey.bind(shift_hyper, "k", moveWindowRelative(0, -1), nil, moveWindowRelative(0, -1))

hs.hotkey.bind(hyper, "v", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local max = win:screen():frame()

  if win:isMaximizable() then
    f.h = max.h
    f.y = 0
    win:setFrame(f)
  end
end)

-- Add hotkeys to emulate media next and previous keys
hs.hotkey.bind({"shift", "ctrl"}, "n", function()
  hs.eventtap.event.newSystemKeyEvent("NEXT", true):post()
end)

hs.hotkey.bind({"shift", "ctrl"}, "p", function()
  hs.eventtap.event.newSystemKeyEvent("PREVIOUS", true):post()
end)

hs.hotkey.bind({"shift", "ctrl"}, "SPACE", function()
  hs.eventtap.event.newSystemKeyEvent("PLAY", true):post()
end)

-- local function ejectAll()
--   local volumes = hs.fs.volume.allVolumes()
--   local log = hs.logger.new("sleep", "info")
--
--   for path, volume in pairs(volumes) do
--     if not volume["NSURLVolumeIsInternalKey"] then
--       log.i("Ejecting " .. path)
--       hs.fs.volume.eject(path)
--     end
--   end
-- end

-- local function sleepWatcher(eventType)
--   if eventType == hs.caffeinate.watcher.systemWillSleep then
--     ejectAll()
--   end
-- end
--
-- watcher = hs.caffeinate.watcher.new(ejectAll)
-- watcher:start()


hs.loadSpoon("Caffeine")
spoon.Caffeine:bindHotkeys({ toggle = { shift_hyper, "c" } })
spoon.Caffeine:start()
