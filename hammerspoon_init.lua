logger = require("hs.logger")
console = require("hs.console")
hotkey = require("hs.hotkey")
alert =require("hs.alert")
eventtap = require("hs.eventtap")
pasteboard = require("hs.pasteboard")

local log = hs.logger.new("init", "debug")

local hyper = {"ctrl", "alt", "cmd"}
local hyperShift = {"ctrl", "alt", "cmd", "shift"}

package.path = package.path .. ";" ..
    hs.configdir .. "/../Spoons/Source/?.spoon/init.lua;" ..
    hs.configdir .. "/../mySpoons/?.spoon/init.lua;" 
--    hs.configdir .. "/../hammerspoon-config-take2/_scratch/mcSpacesAxuielement.lua;"

--window_filter_test = hs.window.filter.new()
--  window_filter_test:setDefaultFilter()
--    :setOverrideFilter({
--      fullscreen = false,
--      currentSpace = true,
--      allowRoles = {'AXStandardWindow'}
--    })
--    :subscribe({
--      hs.window.filter.windowsChanged,
--      hs.window.filter.windowMinimized,
--      hs.window.filter.windowVisible,
--      hs.window.filter.windowCreated,
--      hs.window.filter.windowDestroyed,
--      hs.window.filter.windowHidden,
--    }, function(_, app_name, event) 
--        print("Window filter event " .. event .. " for application " .. app_name)
--    end)


hs.loadSpoon("TilingWindowManager")
    --:setLogLevel("debug")
    :bindHotkeys({
        tile =        {hyper, "t"},
        incMainRatio = {hyper, "p"},
        decMainRatio = {hyper, "o"},
        focusNext =   {hyper, "k"},
        focusPrev =   {hyper, "j"},
        swapNext =    {hyper, "l"},
        swapPrev =    {hyper, "h"},
        toggleFirst = {hyper, "return"},
        tall =        {hyper, ","},
        fullscreen =  {hyper, "."},
        wide =        {hyper, "-"},
        display =     {hyper, "i"},
    })
    :start({
        menubar = false,
        dynamic = true,
        layouts = {
            spoon.TilingWindowManager.layouts.fullscreen,
            spoon.TilingWindowManager.layouts.tall,
            spoon.TilingWindowManager.layouts.wide,
            spoon.TilingWindowManager.layouts.floating,
        },
        displayLayout = true,
        fullscreenRightApps = {
            "com.tinyspeck.slackmacgap", -- Slack
            "WhatsApp",
            "org.hammerspoon.Hammerspoon",
            "com.apple.MobileSMS", -- Messages
        },
        floatApps = {
            "com.apple.systempreferences",
            "com.apple.ActivityMonitor",
            "com.dmitrynikolaev.numi",
            "com.apple.Stickies",
            "com.cisco.anyconnect.gui",
        }
    })

hs.loadSpoon("MinimizedWindowsMenu")
--    :setLogLevel("debug")
    :start()

hs.loadSpoon("NamedSpacesMenu")
--    :setLogLevel("debug")
    :start()
--:bindHotkeys({
--    showmenu =   {hyper, "space"}
--})

hs.window.animationDuration = 0.0

--hs.loadSpoon("MiroWindowsManager")
--    :bindHotkeys({
--        up =         {hyperShift, "up"},
--        right =      {hyperShift, "right"},
--        down =       {hyperShift, "down"},
--        left =       {hyperShift, "left"},
--        fullscreen = {hyperShift, "."}
--    })

hs.loadSpoon("ReloadConfiguration"):
start()

--hs.hotkey.bind(hyper, "r", hs.reload())

--hs.window.highlight.ui.overlayColor = {0.5,0.5,0.5,0.25}
--hs.window.highlight.ui.overlay=true
--hs.window.highlight.start()

--local function trim(string, chars)
--    local string_trim = ""
--    string:gsub("."), function
--end

hs.hotkey.bind(hyper, "t", function()
    local w = hs.window.focusedWindow()
    if w then
        local a = w:application()
        if a then
            n = a:name()
            id = a:bundleID()
            hs.alert.show(id)
            hs.pasteboard.setContents(id)
        end
    end
end)

-- paste pasteboard, remove formatting
hs.hotkey.bind({"cmd", "shift"}, "v", function() 
    local pb = hs.pasteboard.readString()
    --hs.eventtap.keyStrokes(pb)
    if pb then
        hs.pasteboard.setContents(pb)
        hs.timer.doAfter(0.3, function() 
            hs.eventtap.keyStroke({"cmd"}, "v")
        end)
    else
        hs.alert.show("No text in pasteboard")
    end
end)

-- disable cmd-q
hs.hotkey.bind("cmd", "q", function()
    hs.alert.show("Cmd+Q is disabled", 1)
end)

-- Hammerspoon console eyecandy
hs.console.darkMode(true)
if hs.console.darkMode() then
    hs.console.outputBackgroundColor{ white = 0 }
    hs.console.consoleCommandColor{ white = 1 }
else
    hs.console.windowBackgroundColor({red=.6,blue=.7,green=.7})
    hs.console.outputBackgroundColor({red=.8,blue=.8,green=.8})
end

hs.alert("Hammerspoon Config loaded")
