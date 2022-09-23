logger = require("hs.logger")
console = require("hs.console")
hotkey = require("hs.hotkey")
alert =require("hs.alert")
eventtap = require("hs.eventtap")
pasteboard = require("hs.pasteboard")

-- Hammerspoon console eyecandy
hs.console.darkMode(true)
hs.console.consoleFont{name="Menlo-Regular", size=16.0}
-- Nord theme colors
hs.console.windowBackgroundColor{hex="#242424", alpha=1.0}
hs.console.inputBackgroundColor{hex="#2E3440", alpha=1.0}
hs.console.outputBackgroundColor{hex="#2E3440", alpha=1.0}
hs.console.consoleCommandColor{hex="#B48EAD", alpha=1.0}
hs.console.consolePrintColor{hex="#D8DEE9", alpha=1.0}
hs.console.consoleResultColor{hex="#A3BE8C", alpha=1.0}

local log = hs.logger.new("init", "debug")

local hyper = {"ctrl", "alt", "cmd"}
local hyperShift = {"ctrl", "alt", "cmd", "shift"}

package.path = package.path .. ";" ..
    hs.configdir .. "/../Spoons/Source/?.spoon/init.lua;" ..
    hs.configdir .. "/../mySpoons/?.spoon/init.lua;" 
--    hs.configdir .. "/../hammerspoon-config-take2/_scratch/mcSpacesAxuielement.lua;"

hs.loadSpoon("AppWindowSwitcher")
    :setLogLevel("debug")
    :bindHotkeys({
        ["com.apple.Terminal"]        = {hyper, "t"},
        [{"com.apple.Safari",
          "com.google.Chrome",
          "com.kagi.kagimacOS",
          "com.microsoft.edgemac", 
          "org.mozilla.firefox"}]     = {hyper, "q"},
        ["com.tinyspeck.slackmacgap"] = {hyper, "s"},
        ["com.microsoft.Word"]        = {hyper, "w"},
        ["com.microsoft.Excel"]       = {hyper, "x"},
        ["com.apple.finder"]          = {hyper, "f"},
        --["com.apple.Preview"]         = {hyper, "p"},
        ["com.apple.Music"]           = {hyper, "m"},
    })

hs.loadSpoon("TilingWindowManager")
    :setLogLevel("debug")
    :bindHotkeys({
        --tile =             {hyper, "t"},
        incMainRatio =   {hyper, "p"},
        decMainRatio =   {hyper, "o"},
        incMainWindows = {hyper, "i"},
        decMainWindows = {hyper, "u"},
        focusNext =      {hyper, "k"},
        focusPrev =      {hyper, "j"},
        swapNext =       {hyper, "l"},
        swapPrev =       {hyper, "h"},
        toggleFirst =    {hyper, "return"},
        tall =           {hyper, ","},
        talltwo =        {hyper, "m"},
        fullscreen =     {hyper, "."},
        wide =           {hyper, "-"},
        display =        {hyper, "d"},
    })
    :start({
        menubar = true,
        dynamic = true,
        layouts = {
            spoon.TilingWindowManager.layouts.fullscreen,
            spoon.TilingWindowManager.layouts.tall,
            spoon.TilingWindowManager.layouts.talltwo,
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
            "com.zscaler.Zscaler",
            "com.runningwithcrayons.Alfred",
            "com.raycast.macos",
        }
    })

hs.loadSpoon("WindowInfo")
    :bindHotkeys({
        show = {hyper, "ö"}
    })

hs.loadSpoon("ReloadConfiguration")
    :start()

--hs.loadSpoon("MinimizedWindowsMenu")
--    :setLogLevel("debug")
--    :start()

--hs.loadSpoon("NamedSpacesMenu")
--    :setLogLevel("debug")
--    :start()
--:bindHotkeys({
--    showmenu =   {hyper, "space"}
--})

--hs.loadSpoon("MiroWindowsManager")
--    :bindHotkeys({
--        up =         {hyperShift, "up"},
--        right =      {hyperShift, "right"},
--        down =       {hyperShift, "down"},
--        left =       {hyperShift, "left"},
--        fullscreen = {hyperShift, "."}
--    })

hs.window.animationDuration = 0.0

--hs.hotkey.bind(hyper, "r", hs.reload())

hs.hotkey.bind(hyper, "tab", function()
    local windows = hs.window.orderedWindows()
    if #windows > 1 then
        window = windows[2]
        window:focus():raise()
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

hs.alert("Hammerspoon Config loaded")
