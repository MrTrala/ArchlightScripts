local Hud_Clocks_Offset_Y = 0
local Hud_Clocks_Offset_X = -35
 
 
--init clock
local riftHoursLeft = 0
local riftMinutesLeft = 99
local nextRift = 99
--Get Rift Timer regex
GenericTextMessageProxy.OnReceive("RiftTimeReader2", function (_, speaker, level, text)
if string.match(speaker,'Time left to next rift: (.-) h') ~= nil then
	--print("GODZINY LEFT")
	riftHoursLeft = string.match(speaker,'%: (.-) h')
	riftMinutesLeft = string.match(speaker,', (.-) m')
	nextRift = tonumber((tonumber(riftHoursLeft)*60*60)+(tonumber(riftMinutesLeft)*60))+os.time()
elseif string.match(speaker,'Time left to next rift: (.-) m') ~= nil then
	--print("MUNUTY LEFT") 
	riftMinutesLeft = string.match(speaker,'%: (.-) m')
	nextRift = tonumber((tonumber(riftHoursLeft)*60*60)+(tonumber(riftMinutesLeft)*60))+os.time()
end
end)
wait(200)
Self.SayToNpc('!rift',1)
 
 
local RiftClock = HUD.New(50+Hud_Clocks_Offset_X,500+Hud_Clocks_Offset_Y,"Rift Timer: ",255,246,143)
local RiftClock_Hour = HUD.New(150+Hud_Clocks_Offset_X,500+Hud_Clocks_Offset_Y,"init",255,127,0)
local RiftClock_Minute = HUD.New(170+Hud_Clocks_Offset_X,500+Hud_Clocks_Offset_Y,"init",255,127,0)
 
--Event (Snowball, TDM, Dungenevent usw.)
 
local Hud_Event_Offset_X = 0
local Hud_Event_Offset_Y = 0
local eventHoursLeft = 99
local eventMinutesLeft = 99
 
local EventHud = HUD.New(15+Hud_Event_Offset_X,530+Hud_Event_Offset_Y,"Next Event in: ",235,246,143)
local EventHud_Hour = HUD.New(115+Hud_Event_Offset_X,530+Hud_Event_Offset_Y,"0H",255,127,0)
local EventHud_Minute = HUD.New(135+Hud_Event_Offset_X,530+Hud_Event_Offset_Y,"init",255,127,0)
 
local Rift_Arrow_Animation = 0
local Rift_Arrow_Pos_X = 230
local Rift_Arrow = HUD.New(230+Hud_Event_Offset_X,500+Hud_Event_Offset_Y,"<<<",50,220,0)
 
 
local Module_Rift_Arrow = Module.New('module1', function()
if Rift_Arrow_Animation == 1 and Rift_Arrow_Pos_X > 160 then
Rift_Arrow:SetPosition(Rift_Arrow_Pos_X-2,500)
Rift_Arrow_Pos_X = Rift_Arrow_Pos_X-5
elseif Rift_Arrow_Animation == 1 and Rift_Arrow_Pos_X <= 160 then
Rift_Arrow:SetPosition(230,500)
Rift_Arrow_Pos_X = 230
elseif Rift_Arrow_Animation == 0 and Rift_Arrow_Pos_X ~= 230 then
Rift_Arrow:SetTextColor(105,105,105)
Rift_Arrow:SetPosition(230,500)
Rift_Arrow_Pos_X = 230
 
if Rift_Arrow_Animation == 1 then
Rift_Arrow:SetTextColor(50,220,0)
else
Rift_Arrow:SetTextColor(105,105,105)
end
end
end)
 
Module_Rift_Arrow:Start()
 
local lastupdate = 0
 
--on tick
registerEventListener(TIMER_TICK, "onTimerTick")
function onTimerTick()
--transform time left to hour and minutes
local hLeft = math.floor((nextRift-os.time())/3600)
local mLeft = math.floor(((nextRift-os.time())-hLeft*3600)/60)
--check if negative, if so .!rift again
if hLeft < 0 or mLeft < 0 then
if (os.time() > (lastupdate+60)) then
wait(200)
Self.SayToNpc('!rift',1)
print(lastupdate)
lastupdate = os.time()
end
end
--update display
RiftClock_Hour:SetText(hLeft.."H")
RiftClock_Minute:SetText(mLeft.."M")
 
--color changer + arrow anim
if nextRift-os.time() < 120 then
Rift_Arrow_Animation = 1
Rift_Arrow:SetTextColor(50,220,0)
RiftClock_Hour:SetTextColor(math.random(0,255),math.random(0,255),math.random(0,255))
RiftClock_Minute:SetTextColor(math.random(0,255),math.random(0,255),math.random(0,255))
 
elseif nextRift-os.time() < 240 then
Rift_Arrow_Animation = 1
RiftClock_Hour:SetTextColor(255,0,0)
RiftClock_Minute:SetTextColor(255,0,0)
Rift_Arrow:SetTextColor(50,220,0)
else
Rift_Arrow_Animation = 0
RiftClock_Hour:SetTextColor(255,127,0)
RiftClock_Minute:SetTextColor(255,127,0)
Rift_Arrow:SetPosition(230+Hud_Event_Offset_X,500+Hud_Event_Offset_Y)
Rift_Arrow:SetTextColor(105,105,105)
end
 
--Calculate EventTimeLeft
local eventMinutesLeft = math.floor((math.ceil(os.time()/3600)*3600-os.time())/60)
--update display
EventHud_Minute:SetText(eventMinutesLeft.."M")
end
