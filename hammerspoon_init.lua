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
    hs.configdir .. "/../mySpoons/?.spoon/init.lua"


hs.loadSpoon("TilingWindowManager")
    :setLogLevel("debug")
    :bindHotkeys({
        tile =        {hyper, "t"},
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
        tilingModes = {
            spoon.TilingWindowManager.tilingMode.fullscreen,
            spoon.TilingWindowManager.tilingMode.tall,
            spoon.TilingWindowManager.tilingMode.wide,
            spoon.TilingWindowManager.tilingMode.floating,
        },
        displayMode = true,
        fullscreenRightApps = {
            "Slack",
            "WhatsApp",
            "Google Chat",
            "Hammerspoon",
            "Nachrichten",
        },
        floatApps = {
            "Cisco AnyConnect Secure Mobility Client",
            "Aktivitätsanzeige",
            "Notizzettel",
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
hs.loadSpoon("MiroWindowsManager")
    :bindHotkeys({
        up =         {hyperShift, "up"},
        right =      {hyperShift, "right"},
        down =       {hyperShift, "down"},
        left =       {hyperShift, "left"},
        fullscreen = {hyperShift, "."}
    })

hs.loadSpoon("ReloadConfiguration"):
start()

--hs.window.highlight.ui.overlayColor = {0.5,0.5,0.5,0.25}
--hs.window.highlight.ui.overlay=true
--hs.window.highlight.start()

--local function trim(string, chars)
--    local string_trim = ""
--    string:gsub("."), function
--end

-- type pasteboard, remove formatting
hs.hotkey.bind({"cmd", "shift"}, "v", function() 
    local pb = hs.pasteboard.readString()
    local msApp = hs.pasteboard.readAllData()["com.microsoft.appbundleid"] 
    if msApp == "com.microsoft.Excel" then 
        local pb_clean = ""
        pb:gsub(".", function()
        end)
    end
    hs.eventtap.keyStrokes(pb)
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
