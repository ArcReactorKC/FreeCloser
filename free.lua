local mq = require("mq")
local me = mq.TLO.Me

local function checkAndDismissAllAccess()
    if mq.TLO.Window("AlertWnd").Open() then
        print("AlertWnd is open — dismissing Become an All Access Member window.")
        -- Trying notify instead of clickwnd
        mq.cmd("/notify AlertWnd ALW_Dismiss_Button leftmouseup")
        mq.delay(500)
		mq.cmd('/popupecho 13 20 Closed the begging window ')
    end
if me() and me.AFK() then
    mq.cmd('/quit')
end
end

while true do
    checkAndDismissAllAccess()
    mq.doevents()
    mq.delay(1000)
end
