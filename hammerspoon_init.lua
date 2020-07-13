log = hs.logger.new("init", "debug")
hs.console.darkMode(true)

hyper = {"ctrl", "alt", "cmd"}

--
-- open applications
--

function open(name)
    return function()
        if hs.application.title(hs.application.frontmostApplication()) == name then
            hs.eventtap.keyStroke('cmd', '<')
        else
            hs.application.launchOrFocus(name)
            if name == 'Finder' then
                hs.appfinder.appFromName(name):activate()
            end
        end
    end
end

hs.hotkey.bind(hyper, "F", open("Finder"))
hs.hotkey.bind(hyper, "C", open("Google Chrome"))
hs.hotkey.bind(hyper, "T", open("Terminal"))
hs.hotkey.bind(hyper, "X", open("Microsoft Excel"))
hs.hotkey.bind(hyper, "P", open("Microsoft Powerpoint"))
hs.hotkey.bind(hyper, "W", open("WhatsApp"))
hs.hotkey.bind(hyper, "H", open("Chat"))
hs.hotkey.bind(hyper, "N", open("Nachrichten"))
hs.hotkey.bind(hyper, "L", open("Slack"))
hs.hotkey.bind(hyper, "S", open("Spotify"))
hs.hotkey.bind(hyper, "M", open("Mail"))
hs.hotkey.bind(hyper, "K", open("Google Calendar"))


--
-- clipboard
--

-- ctrl-v pasteboard, remove formatting
hs.hotkey.bind({"cmd", "shift"}, "V", function() 
    -- hs.eventtap.keyStrokes(hs.pasteboard.getContents()) 
    hs.eventtap.keyStroke({"cmd"}, "v")
end)

-- type pasteboard, remove formatting
hs.hotkey.bind({"cmd", "alt"}, "V", function() 
    hs.eventtap.keyStrokes(hs.pasteboard.getContents()) 
end)


--
-- window management
--

function win_size(size, win)
    if size == nil then
        size = "full"
    end
    if win == nil then
        win = hs.window.focusedWindow()
    end

    local gap = 0
    local animation_duration = 0

    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    if size == "full" then
        f.x = max.x + gap
        f.y = max.y + gap
        f.w = max.w - (2 * gap)
        f.h = max.h - (2 * gap)
    elseif size == "left50" then 
        f.x = max.x + gap
        f.y = max.y + gap
        f.w = (max.w / 2) - (1.5 * gap)
        f.h = max.h - (2 * gap )
    elseif size == "right50" then 
        f.x = max.x + (max.w / 2) + (0.5 * gap)
        f.y = max.y + gap
        f.w = (max.w / 2) - (1.5 * gap) 
        f.h = max.h - (2 * gap)
    elseif size == "top50" then 
        f.x = max.x + gap
        f.y = max.y + gap
        f.w = max.w - (2 * gap)
        f.h = (max.h / 2) - (1.5 * gap)
    elseif size == "bottom50" then 
        f.x = max.x + gap
        f.y = max.y + (max.h / 2) + (0.5 * gap)
        f.w = max.w - (2 * gap)
        f.h = max.h / 2 - (1.5 * gap)
    end

    win:setFrame(f, animation_duration)
end

hs.hotkey.bind(hyper, ".", function() win_size("full") end)
hs.hotkey.bind(hyper, "Left", function() win_size("left50") end)
hs.hotkey.bind(hyper, "Right", function() win_size("right50") end)
hs.hotkey.bind(hyper, "Up", function() win_size("top50") end)
hs.hotkey.bind(hyper, "Down", function() win_size("bottom50") end)


-- Special window management for Apple Mail.
-- Whenever creating a new mail or responding to a mail,
-- move Mail's main window to the left half and place the compose 
-- window in the right half of the screen.
-- When sending the new mail (or discarding), make Mail's main window 
-- full size again. This is similar to what Mail does in fullscreen
-- mode.

mail_main_window = nil -- remember the mail main window across callbacks

function mail_window_created(window, app_name, event)
    -- find out which window is Mail's main window, by by getting a list 
    -- of Mail windows, sorted by creation date. First window is
    -- Mail's main window
    f = hs.window.filter.new(false):setAppFilter("Mail")
    mail_windows = f:getWindows(hs.window.filter.sortByCreated)
    mail_main_window = mail_windows[1] -- first window is main window
    if window ~= mail_main_window then -- at least two windows
        win_size("left50", mail_main_window)
        win_size("right50", window)
    end
end

function mail_window_destroyed(window, app_name, event)
    if mail_main_window == nil then -- we don't know the main window
        return
    end

    if window == mail_main_window then -- we do not close main window
        return
    end

    local screen = mail_main_window:screen()
    local max = screen:frame()
    if max.w > 1680 then -- do not fullscreen again on big screen
        return
    end

    win_size("full", mail_main_window)
end

-- register callbacks for create and destroy of all Mail windows
mail_window_filter = hs.window.filter.new(false):setAppFilter("Mail")
mail_window_filter:subscribe(
    hs.window.filter.windowCreated, 
    mail_window_created)
mail_window_filter:subscribe(
    hs.window.filter.windowDestroyed, 
    mail_window_destroyed)


-- convenience function for splitting two windows horizontally or 
-- vertically. Remembers previous window and uses that to position 
-- current and previous window.

previous_window = nil
current_window = nil

hs.hotkey.bind(hyper, "-", function()
    if previous_window and current_window then
        win_size("top50", current_window)
        win_size("bottom50", previous_window)
    else
        hs.alert.show("Did not yet remember windows", 1)
    end
end)

hs.hotkey.bind(hyper, ",", function()
    if previous_window and current_window then
        win_size("left50", current_window)
        win_size("right50", previous_window)
    else
        hs.alert.show("Did not yet remember windows", 1)
    end
end)

function previous_window_remember(window, app_name, event)
    previous_window = current_window
    current_window = window
end

previous_window_filter = hs.window.filter.new(true)
previous_window_filter:subscribe(
    hs.window.filter.windowFocused,
    previous_window_remember)


--    
-- disable cmd-q
--

hs.hotkey.bind("cmd", "Q", function()
    hs.alert.show("Cmd+Q is disabled", 1)
end)


--
-- automatically reload hammerspoon config
--

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

reload_watcher = hs.pathwatcher.new(os.getenv("HOME") .. "/dotfiles/", reloadConfig):start()
hs.alert.show("Hammerspoon config loaded")


