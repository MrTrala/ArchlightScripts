--[[
    HealFriend for ArchlightOnline
    By Mr Trala
   
Thanks to:
 
Colandus from Otland for the string.explode function.
 
Instructions;
 
Load the script, the instructions are in the Sio Channel.

Change Log;

1.5.1 - First stable version.
1.5.2 - Fixed problem after Archlight HP/Mana Update.
1.5.3 - Reworked the Module for sio, the old one sometimes failed.
1.5.4 - Added the option 'Restart', you will reset the Module so you reset all your sios.
]]
 
 
 
-- You can keep adding permanent sios here, just keep adding +1 number like;
-- friends[2] = {Friend = "Another Dude", HealAt = 2}
friends = {}
friends[1] = {SioT = "Admin Knighter", HealAt = 10}
 
 
 
-- Don't touch anything if you don't know what are you doing.
function string.trim(str)
    return (str:gsub("^%s*(.-)%s*$", "%1"))
end
version = '1.5.4F'
function string.explode(str, sep, limit)
    if limit and type(limit) ~= 'number' then
        error("string.explode: limit must be a number", 2)
    end
 
    if #sep == 0 or #str == 0 then return end
    local pos, i, t = 1, 1, {}
    for s, e in function() return str:find(sep, pos) end do
        table.insert(t, str:sub(pos, s-1):trim())
        pos = e + 1
        i = i + 1
        if limit and i == limit then break end
    end
    table.insert(t, str:sub(pos):trim())
    return t
end
 
function onSpeak(channel, msg)
    if (msg == "start") or (msg == "Start") then
        channel:SendYellowMessage('Mr Trala', 'HealFriend Script has started.')
        Module.Start('HealF')
       
    elseif (msg == "stop") or (msg == "Stop")then
        Module.Stop('HealF')
        channel:SendRedMessage('Mr Trala', 'HealFriend Script has been stopped.')

    elseif (msg == "restart") or (msg == "Restart") or (msg == "reset") or (msg == "Reset") then
		channel:SendRedMessage('Mr Trala', 'Resetting your Module, please wait...')
		Module.Stop('HealF')
		wait(1500)
		friends = {}
        channel:SendRedMessage('Mr Trala', 'HealFriend Script has been restarted.')
		Module.Start('HealF')
	
    end
   
    if msg ~= "start" and msg ~= "stop" then
    local p = string.explode(msg, ",")
    local t = tonumber(p[2])
    local num = t
        if p[2] == '' or not string.find(msg, ",") then
            channel:SendRedMessage('Mr Trala', 'Please specify the name of the player and in wich X% to heal him, as follow: "Mr Trala, 95".')
           
        elseif num > 99 or num == 0 then
            channel:SendRedMessage('Mr Trala', 'You can only choose between 1-99 to heal someone.')
           
        else
            friends[#friends+1] = {SioT = ''..p[1]..'', HealAt = p[2]}
            channel:SendYellowMessage('Mr Trala', 'You have added the player: '..p[1]..' to heal at : '..p[2]..'% to the healing list.')
        end
    end        
end
 
function onClose(channel)
     print(channel:Name() .. ' has been closed.')
end
 
local customChannel = Channel.New('Sio Channel', onSpeak, onClose)

customChannel:SendRedMessage('Mr Trala', 'Welcome to the HealFriend Script, configured specifically for ArchlightOnline.\n'..
        'This Script has been made by Mr Trala, and you are using the Version '..version..'\n'..
        'If you found any bug send a message to Mr Trala or Mr Trolo in Archlight.\n')
customChannel:SendOrangeMessage('Instructions', '\n'..
        'To start the script just write "start" or "stop" to stop healing everyone - IT IS ON BY DEFAULT.\n')
customChannel:SendRedMessage('Mr Trala', 'Please specify the name of the player and in wich X% to heal him, as follow: "Mr Trala, 95".')
 
 
function HealF()
	for _, c in Creature.iPlayers() do
		for i = 1, #friends do
local f = friends[i]
local num = tonumber(f.HealAt)
			if c:Name() == f.SioT and c:HealthPercent() <= num and Self.GetSpellCooldown('exura sio') == 0 then
				Self.Say('exura sio "'..f.SioT)
			end
		end
	end
end

Module('HealF', HealF, true)
