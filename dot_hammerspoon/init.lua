local hyper = { "cmd", "alt", "ctrl", "shift" }
placid = {"cmd", "alt"}

hs.hotkey.bind(hyper, "0", function()
  hs.reload()
end)

hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

hs.hotkey.bind(hyper, "[", function()
  local win = hs.window.focusedWindow();
  if not win then return end
  
win:moveToUnit(hs.layout.left50)
end)

hs.hotkey.bind(hyper, "left", function()
  local win = hs.window.focusedWindow();
  if not win then return end
  
win:moveToUnit(hs.layout.left70)
end)

hs.hotkey.bind(hyper, "up", function()
  local win = hs.window.focusedWindow();
  if not win then return end
  
win:moveToUnit(hs.layout.maximized)
end)

hs.hotkey.bind(hyper, "down", function()
  local win = hs.window.focusedWindow();
  if not win then return end
  
win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind(hyper, "right", function()
  local win = hs.window.focusedWindow();
  if not win then return end

win:moveToUnit(hs.layout.right30)
end)
  
hs.hotkey.bind(hyper, "1", function()
  local win = hs.window.focusedWindow();
  if not win then return end

win:moveOneScreenWest(false, true)
end)

hs.hotkey.bind(hyper, "2", function()
  local win = hs.window.focusedWindow();
  if not win then return end

win:moveOneScreenEast(false, true)
end)

local applicationHotkeys = {
  a = 'Anki',
  b = 'calibre',
  c = 'Arc.app',
  d = 'DXOPhotoLab4.app',
  e = 'Mail',
  f = 'Finder',
  g = 'KaTrain',
  i = 'WezTerm',
  j = 'JOSM',
  k = 'Kindle',
  l = '',
  m = '',
  o = 'Obsidian',
  p = 'Preview',
  q = 'Simulator',
  s = 'Finder',
  t = 'Filezilla',
  u = 'ClickUp',
  v = 'Visual Studio Code',
  w = 'WezTerm',
  x = 'Microsoft Excel',
  z = 'Dizionari ZANICHELLI '
}

for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end

-- Clipboard Manager
hs.loadSpoon('ClipboardTool')
spoon.ClipboardTool.hist_size = 100
spoon.ClipboardTool.show_in_menubar = true
spoon.ClipboardTool.show_copied_alert = false
spoon.ClipboardTool:start()
spoon.ClipboardTool:bindHotkeys({
  toggle_clipboard = {placid, 'v'}
})

-- Resize Windows
function get_window_under_mouse()
  local pos = hs.geometry.new(hs.mouse.getAbsolutePosition())
  local screen = hs.mouse.getCurrentScreen()

  return hs.fnutils.find(hs.window.orderedWindows(), function(w)
    return screen == w:screen() and pos:inside(w:frame())
  end)
end

dragging_window = nil

drag_event = hs.eventtap.new(
  {
    hs.eventtap.event.types.leftMouseDragged,
    hs.eventtap.event.types.rightMouseDragged,
  }, function(e)
    if not dragging_win then return nil end

    local dx = e:getProperty(hs.eventtap.event.properties.mouseEventDeltaX)
    local dy = e:getProperty(hs.eventtap.event.properties.mouseEventDeltaY)
    local mouse = hs.mouse:getButtons()

    if mouse.left then
      dragging_win:move({dx, dy}, nil, false, 0)
    elseif mouse.right then
      local sz = dragging_win:size()
      local w1 = sz.w + dx
      local h1 = sz.h + dy
      dragging_win:setSize(w1, h1)
    end
end)

flag_event = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
  local flags = e:getFlags()

  if flags.cmd then
    dragging_win = get_window_under_mouse()
    drag_event:start()
  else
    draggin_win = nil
    drag_event:stop()
  end
end)

flag_event:start()