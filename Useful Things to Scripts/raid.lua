--[[
	Raid Boss Alert for ArchlightOnline
	By Wrona96
	
Thanks to:
forums.xenobot

Instructions;
Add massage befor apear boss

	Change Log:
	
1.0.0(Final) -- Full wroking script just add more raid boss info below :)
]]
--Add to list your warings of bosses
listedMessages = {
	"An ancient evil is awakening in the mines beneath Hrodmir.", 
}

--Your hotkey ID(needed) and Name
hotkeyName = "DEL"
hotkeyID = 46
--Home = 36, PGUP = 33, PGDOWN = 34, END = 35, DELETE = 46

local channel = Channel.New("Raid Messages", onSpeak, onClose)
GenericTextMessageProxy.OnReceive("GenericTextMessageProxy", function(proxy, message)
if table.contains(listedMessages, message) then
	channel:SendOrangeMessage("Raid Catcher", message)
	alerting = true
end
--print("Massage: %s", message) Only for test
end)

function onClose(channel)
	print(channel .. " was closed.")
end

if not Hotkeys.Register(hotkeyID) then
    print("Failed to register raid disable hotkey")
end

function pressHandler(key, control, shift)
    if alerting then
        alerting = false
        print("Alarm disabled.")
    end
end

Hotkeys.AddPressHandler(pressHandler)

Module.New('checkAlerting', function(checkAlerting)
    if alerting then
        alert()
        print("Press " .. hotkeyName .. " to disable alarm and move your ass to BOSS.")
    end
    checkAlerting:Delay(4000)
end)
