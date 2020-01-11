-- Automatically reload config
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local hyper = {"alt", "cmd"}
local shift_hyper = {"alt", "cmd"}

hs.hotkey.bind(hyper, "V", function()
  hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

-- Setup MiroWindowsManager
hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0.08
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "k"},
  right = {hyper, "l"},
  down = {hyper, "j"},
  left = {hyper, "h"},
  fullscreen = {shift_hyper, "f"}
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

hs.hotkey.bind(hyper, "f", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local max = win:screen():frame()

	local x = f

  if win:isMaximizable() then
    x.h = max.h
    x.w = max.w
    x.x = ((max.w - x.w)) + max.x
    x.y = 0
  else
    x.x = ((max.w - f.w) / 2) + max.x
    x.y = ((max.h - f.h) / 2) + max.y
  end

	win:setFrame(x)
end)

hs.hotkey.bind(hyper, "c", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local max = win:screen():frame()

	local x = f

  if win:isMaximizable() then
    x.h = max.h
    x.w = max.w*2/3
    x.x = ((max.w - x.w) / 2) + max.x
    x.y = 0
    win:setFrame(x)
  else
    x.x = ((max.w - f.w) / 2) + max.x
    x.y = ((max.h - f.h) / 2) + max.y
  end

	win:setFrame(x)
end)


function ejectAll()
  local volumes = hs.fs.volume.allVolumes()
  local log = hs.logger.new("sleep", "info")

  for path, volume in pairs(volumes) do
    if not volume["NSURLVolumeIsInternalKey"] then
      log.i("Ejecting " .. path)
      hs.fs.volume.eject(path)
    end
  end
end

function sleepWatcher(eventType)
  if eventType == hs.caffeinate.watcher.systemWillSleep then
    ejectAll()
  end
end

watcher = hs.caffeinate.watcher.new(ejectAll)
watcher:start()
