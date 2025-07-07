local mq = require("mq")
local me = mq.TLO.Me

-- Control flags
local paused = false
local running = true

-- Show startup toast
mq.cmd('/popupecho 13 20 Now clearing All Access windows when displayed')

-- Slash command to pause the script
mq.bind("/pausefree", function()
    paused = true
    print("FreeWindow script paused.")
end)

-- Slash command to resume the script
mq.bind("/resumefree", function()
    paused = false
    print("FreeWindow script resumed.")
end)

-- Slash command to stop the script entirely
mq.bind("/stopfree", function()
    running = false
    print("FreeWindow script stopping...")
end)

local function checkAndDismissAllAccess()
    if mq.TLO.Window("AlertWnd").Open() then
        print("AlertWnd is open — dismissing Become an All Access Member window.")
        mq.cmd("/notify AlertWnd ALW_Dismiss_Button leftmouseup")
        mq.delay(500)
        mq.cmd('/popupecho 13 20 Closed the begging window')
    end

    if me() and me.AFK() then
        mq.cmd('/quit')
    end
end

while running do
    if not paused then
        checkAndDismissAllAccess()
    end
    mq.doevents()
    mq.delay(1000)
end

print("FreeWindow script exited.")
