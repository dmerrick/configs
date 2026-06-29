-- ~/.hammerspoon/init.lua  (stowed from ~/configs/hammerspoon)
--
-- Window-layout manager: save the position of every window per display
-- configuration, restore them after a reboot, and auto-switch layouts when
-- you plug/unplug a monitor.
--
--   ⌥⌘S  save the current window layout for THIS display setup
--   ⌥⌘R  restore the saved layout for THIS display setup
--   ⌥⌘L  list saved layouts (in the Hammerspoon console)
--   ⌥⌘C  open the Hammerspoon console
--
-- Layouts are keyed by which screens are connected, so "laptop only" and
-- "monitor setup" each remember their own arrangement. Saved layouts live in
-- ~/.cache/hammerspoon/window-layouts.json (machine state — NOT in the dotfiles
-- repo).

local M = {}

-- Where saved layouts are persisted (outside the stow/git dir on purpose).
local layoutFile = os.getenv("HOME") .. "/.cache/hammerspoon/window-layouts.json"

-- Auto-restore when the display configuration changes (plug/unplug a monitor).
local AUTO_RESTORE_ON_DISPLAY_CHANGE = true
-- Auto-restore once shortly after Hammerspoon loads (i.e. after a reboot/login),
-- giving apps a few seconds to reopen their windows first.
local AUTO_RESTORE_ON_LOAD = true
local LOAD_RESTORE_DELAY = 6 -- seconds

-- ---------------------------------------------------------------------------
-- helpers
-- ---------------------------------------------------------------------------

local function ensureDir()
  os.execute('mkdir -p "' .. (layoutFile:match("(.*)/")) .. '"')
end

-- A stable key for the current set of connected screens. Built-in display has a
-- stable UUID; each external monitor has its own. One screen => laptop-only;
-- two => the monitor setup, etc.
local function configKey()
  local ids = {}
  for _, s in ipairs(hs.screen.allScreens()) do
    table.insert(ids, s:getUUID() or s:name() or "?")
  end
  table.sort(ids)
  return table.concat(ids, "|")
end

local function screenLabel()
  local n = #hs.screen.allScreens()
  if n == 1 then return "laptop-only (1 screen)" end
  return "monitor setup (" .. n .. " screens)"
end

local function loadAll()
  local data = hs.json.read(layoutFile)
  return data or {}
end

local function saveAll(data)
  ensureDir()
  hs.json.write(data, layoutFile, true, true) -- pretty, replace
end

-- ---------------------------------------------------------------------------
-- save / restore
-- ---------------------------------------------------------------------------

function M.save()
  local data = loadAll()
  local key = configKey()
  local wins = {}
  for _, win in ipairs(hs.window.allWindows()) do
    if win:isStandard() and win:isVisible() then
      local f = win:frame()
      local app = win:application()
      table.insert(wins, {
        app = app and app:name() or "?",
        title = win:title() or "",
        screen = win:screen() and win:screen():getUUID() or nil,
        x = f.x, y = f.y, w = f.w, h = f.h,
      })
    end
  end
  data[key] = {
    label = screenLabel(),
    screens = #hs.screen.allScreens(),
    windows = wins,
  }
  saveAll(data)
  hs.alert.show("Saved " .. #wins .. " windows for " .. screenLabel())
end

-- Find the best live window for a saved entry. Prefer an exact app+title match;
-- otherwise the first unused window belonging to the same app (handles apps with
-- several windows by mapping them in order).
local function findWindow(saved, used)
  local fallback
  for _, win in ipairs(hs.window.allWindows()) do
    if not used[win:id()] and win:isStandard() then
      local app = win:application()
      if app and app:name() == saved.app then
        if saved.title ~= "" and win:title() == saved.title then
          return win
        end
        if not fallback then fallback = win end
      end
    end
  end
  return fallback
end

function M.restore()
  local layout = loadAll()[configKey()]
  if not layout then
    hs.alert.show("No saved layout for " .. screenLabel())
    return
  end
  local used, count = {}, 0
  for _, saved in ipairs(layout.windows) do
    local win = findWindow(saved, used)
    if win then
      win:setFrame(hs.geometry.rect(saved.x, saved.y, saved.w, saved.h))
      used[win:id()] = true
      count = count + 1
    end
  end
  hs.alert.show("Restored " .. count .. "/" .. #layout.windows .. " windows")
end

function M.list()
  local data = loadAll()
  print("--- saved window layouts ---")
  local any = false
  for _, layout in pairs(data) do
    any = true
    print(string.format("  %-28s  %d windows", layout.label or "?", #layout.windows))
  end
  if not any then print("  (none yet — press ⌥⌘S to save the current one)") end
end

-- ---------------------------------------------------------------------------
-- auto behaviors
-- ---------------------------------------------------------------------------

if AUTO_RESTORE_ON_DISPLAY_CHANGE then
  -- Debounce: display changes fire several events; wait for things to settle.
  local pending
  M.screenWatcher = hs.screen.watcher.new(function()
    if pending then pending:stop() end
    pending = hs.timer.doAfter(2.5, function()
      if loadAll()[configKey()] then M.restore() end
    end)
  end):start()
end

if AUTO_RESTORE_ON_LOAD then
  hs.timer.doAfter(LOAD_RESTORE_DELAY, function()
    if loadAll()[configKey()] then M.restore() end
  end)
end

-- ---------------------------------------------------------------------------
-- hotkeys
-- ---------------------------------------------------------------------------

hs.hotkey.bind({ "alt", "cmd" }, "S", M.save)
hs.hotkey.bind({ "alt", "cmd" }, "R", M.restore)
hs.hotkey.bind({ "alt", "cmd" }, "L", function() M.list(); hs.openConsole() end)
hs.hotkey.bind({ "alt", "cmd" }, "C", hs.openConsole)

-- ---------------------------------------------------------------------------
-- auto-reload this config when the file changes
-- ---------------------------------------------------------------------------

M.configWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", function(files)
  for _, f in ipairs(files) do
    if f:sub(-4) == ".lua" then hs.reload(); return end
  end
end):start()

-- Launch at login so layouts can be restored after a reboot.
hs.autoLaunch(true)

hs.alert.show("Hammerspoon loaded — ⌥⌘S save, ⌥⌘R restore")

return M
