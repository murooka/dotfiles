local function hasValue(table, value)
  for k, v in ipairs(table) do
    if v == value then
      return true
    end
  end
  return false
end

local function keyCode(key, modifiers)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

local function remapKey(modifiers, key, keyCode)
  hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function enableAllHotkeys()
  for k, v in pairs(hs.hotkey.getHotkeys()) do
    v['_hk']:enable()
  end
end

local function enableHotkeys(keys)
  for k, v in pairs(hs.hotkey.getHotkeys()) do
    if hasValue(keys, v['idx']) then
      print('enable ' .. v['idx'])
      v['_hk']:enable()
    end
  end
end

local function disableAllHotkeys()
  for k, v in pairs(hs.hotkey.getHotkeys()) do
    v['_hk']:disable()
  end
end

local function disableHotkeys(keys)
  for k, v in pairs(hs.hotkey.getHotkeys()) do
    if hasValue(keys, v['idx']) then
      print('disable ' .. v['idx'])
      v['_hk']:disable()
    end
  end
end


local function handleGlobalAppEvent(name, event, app)
  if event == hs.application.watcher.activated then
    -- hs.alert.show(name)
    if name ~= "iTerm2" then
      -- enableAllHotkeys()
      enableHotkeys({'⌃N','⌃P','⌃W'})
    else
      -- disableAllHotkeys()
      disableHotkeys({'⌃N','⌃P','⌃W'})
    end
  end
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start() remapKey({'ctrl'}, 'f', keyCode('right'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'p', keyCode('up'))
remapKey({'ctrl'}, 'w', keyCode('delete', {'option'}))
remapKey({'ctrl'}, '[', keyCode('ESCAPE'))
enableAllHotkeys()
