--[[
	Combo Monk for ArchlightOnline
	(Public Version)
	By Mr Trala
]]

config = {
	ManaRune = 11607, -- ID of your manarune.
	ManaCAST = 80, -- x% mana to use manarune.
	SDID = 3155, -- ID of your sd.
-- Healing Config
    Quick = 90, -- x% health to use Quick Prayer.
    Pray = 80, -- x% health to use Prayer.
    BlessS = 50, -- x% health to use Strong Healing Spring.
	StrongB = 40 -- x% health to use Healing Spring.
}

--[[
	Change Log;

1.0 -- First version, added Combo punches module.
1.0.1 -- Added a healer.
1.0.2 -- First stable version (With healer and low lvl combo)
1.0.3 -- Made changes to the healer.
1.0.4 -- Added Focus module.
1.0.5 -- Fixed an error in the healer module.
1.0.6 -- Added a basic sd target module.
1.0.7 -- Added ComboN module. -- Realeased bcz alot of ppl is asking for it.
1.0.8 -- Fixed a bug in the healer (Thx to Erma for reporting it).
1.0.9 -- Fixed a bug in the healer (Thx Spheon for reporting it).
1.1.0 -- Added an Anty Paralz.
1.1.1 -- Fixed a little bug in the Combo Module.
]]

-- Don't touch anything below this line if you don't know what are you doing.
spells = {
	-- Exhausteds
	StrongFPEX = 'exura gran ico', -- Strong Flurry of Punches
	FlurryPEX = 'exori ico', -- Flurry of Punches
	MinFPEX = 'exori gran ico', -- Min Flurry of Punches
	KnockEX = 'exevo vis hur', -- Knockout
	
	-- Words
	StrongFPWD = 'Strong Flurry of Punches',
	FlurryPWD = 'Flurry of Punches',
	MinFPWD = 'Min Flurry of Punches',
	KnockWD = 'Knockout Punch',
	
	-- Healers
	QuickEX = 'exura san', -- Quick Pray
    PrayEX = 'exura ico', -- Prayer
    BlessEX = 'utura', -- Strong Healing Spring
	StrongBEX = 'exura gran mas res',-- Strong Blessing Spring
   
    QuickW = 'Quick Prayer',
    PrayW = 'Prayer',
    BlessW = 'Strong Healing Spring',
	StrongBEW = 'Healing Spring'
}
version = '1.1.0(Beta)'

names =
{
{Name = Self.Name()}
}

for _, name in ipairs(names) do
	if Self.Name() == name.Name then
		print('Welcome to the Monk Combo Script '..name.Name..'.\n'..
		'You are using the version '..version..'.\n'..
		'Since this is a Beta if you found any bugs please report it to Mr Trala.\n'..
		'Have fun!')
	end
end
-- Shorts
x = config
s = spells
Cool = Self.GetSpellCooldown


function onSpeak(channel, message)
	-- receives the channel object that called it and the message that was inputted.
	if (message == '/list') then
		channel:SendYellowMessage('List of Modules', '\n'..
		'Combo -- A normal combo for Monks (The 4 punches).\n'..
		'Healer -- This is your healer module (Enabled by default).\n'..
		'Focus -- A module to keep using Focused Art and Anti Paraz (enabled by default).\n'..
		'ComboW -- The same as Combo but without the 650 spell.\n'..
		'Train -- Use this one to start the training module (exura san + utana vid).\n')
	end
	
	-- Modules
	if (message == '/start Combo') or (message == 'Combo') or (message == 'combo') then
		Module.Start('ComboNWS')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Combo" has been started.')
		
	elseif (message == '/stop Combo') or (message == '/stop combo') then
		Module.Stop('ComboNWS')
		channel:SendRedMessage('Mr Trala', 'The module with the name "Combo" has been stopped.')	
		
	elseif (message == '/start Focus') or (message == 'Focus') or (message == 'focus') then
		Module.Start('Focus')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Focus" has been started.')
		
	elseif (message == '/stop Focus') or (message == '/stop focus') then
		Module.Stop('Focus')
		channel:SendRedMessage('Mr Trala', 'The module with the name "Focus" has been stopped.')
		
	elseif (message == '/start Healer') or (message == 'Healer') or (message == 'healer') then
		Module.Start('Healer')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Healer" has been started.')
		
	elseif (message == '/stop Healer') or (message == '/stop healer') then
		Module.Stop('Healer')
		channel:SendRedMessage('Mr Trala', 'The module with the name "Healer" has been stopped.')
		
	elseif (message == '/start SD') or (message == 'SD') or (message == 'sd') then
		Module.Start('SDT')
		channel:SendRedMessage('Mr Trala', 'The module with the name "SDT" has been started.')
	
	elseif (message == '/stop SD') or (message == '/stop sd') then
		Module.Stop('SDT')
		channel:SendRedMessage('Mr Trala', 'The module with the name "SDT" has been stopped.')
		
	elseif (message == '/start ComboW') or (message == 'ComboW') or (message == 'combow') then
		Module.Start('Combo')
		channel:SendRedMessage('Mr Trala', 'The module with the name "ComboW" has been started.')
	
	elseif (message == '/stop ComboW') or (message == '/stop combow') then
		Module.Stop('Combo')
		channel:SendRedMessage('Mr Trala', 'The module with the name "ComboW" has been stopped.')

		
	end
end

function ReOpen()
local customChannel = Channel.New('Monk Channel', onSpeak, onClose)
customChannel:SendYellowMessage('Mr Trala', 'Welcome to the Monk Combo Script, configured specifically for ArchlightOnline.\n'..
		'This Script has been made by Mr Trala, and you are using the Version '..version..'\n'..
		'If you found any bug or give a suggestion send a message to Mr Trolo in Archlight.\n')
customChannel:SendOrangeMessage('Instructions', '\n'..
		'Write /list if you want to see a list of the modules you can use\n'..
		'You can start or stop a Module with the command /start or /stop\n')
end

function onClose(channel)
     -- receives the channel object that called it
     print('To close '..channel:Name()..' you need to kill the script.')
	 ReOpen()
end

local customChannel = Channel.New('Monk Channel', onSpeak, onClose)
customChannel:SendYellowMessage('Mr Trala', 'Welcome to the Monk Combo Script, configured specifically for ArchlightOnline.\n'..
		'This Script has been made by Mr Trala, and you are using the Version '..version..'\n'..
		'If you found any bug send a message to Mr Trolo in Archlight.\n')
customChannel:SendOrangeMessage('Instructions', '\n'..
		'Write /list if you want to see a list of the modules you can use\n'..
		'You can start or stop a Module with the command /start or /stop\n')
		
-- Functions
function ComboNWS()
local c = Creature.GetByID(Self.TargetID())
	if c:isValid() and c:isAlive()  and c:isTarget() and c:DistanceFromSelf() == 1 then
		if Cool(s.StrongFPEX) >= 1 and Cool(s.FlurryPEX) >= 1 and Cool(s.KnockEX) >= 1 and Cool(s.MinFPEX) == 0 then 
			Self.Say(s.MinFPWD)
			Healer2()
			
		elseif Cool(s.StrongFPEX) == 0 then
			Self.Say(s.StrongFPWD)
			Healer2()
			
		elseif Cool(s.StrongFPEX) >= 1 and Cool(s.KnockEX) == 0 then
			Self.Say(s.KnockWD)
			Healer2()
		
		elseif Cool(s.StrongFPEX) >= 1 and Cool(s.KnockEX) >= 1 and Cool(s.FlurryPEX) == 0 then
			Self.Say(s.FlurryPWD)
			Healer2()
		end
	end
end

function Combo()
local c = Creature.GetByID(Self.TargetID())
	if c:isValid() and c:isAlive()  and c:isTarget() and c:DistanceFromSelf() == 1  and Self.Level() >= 250 then
		if Cool(s.StrongFPEX) >= 1 and Cool(s.FlurryPEX) >= 1 and Cool(s.MinFPEX) == 0 then 
			Self.Cast(s.MinFPWD)
			Healer2()
			
		elseif Cool(s.StrongFPEX) == 0 then
			Self.Cast(s.StrongFPWD)
			Healer2()
		
		elseif Cool(s.StrongFPEX) >= 1  and Cool(s.FlurryPEX) == 0 then
			Self.Cast(s.FlurryPWD)
			Healer2()
		end
	end
	
	if c:isValid() and c:isAlive()  and c:isTarget() and c:DistanceFromSelf() == 1  and Self.Level() <= 249 then	
		if Cool(s.FlurryPEX) == 0 then
			Self.Cast(s.FlurryPWD)
			Healer2()
		
		elseif Cool(s.FlurryPEX) >= 1  and Cool(s.MinFPEX) == 0 then
			Self.Cast(s.MinFPWD)
			Healer2()
		end
	end
end

function Healer2()
	if Self.Health() < x.StrongB and Cool(s.StrongBEX) == 0 and Self.Level() >= 1500 then
		Self.UseItem(x.ManaRune)
		Self.Say(s.StrongBEW)
    end
	
    if Self.Health() < x.BlessS and Cool(s.BlessEX) == 0 and Self.Level() >= 1000 then
        Self.UseItem(x.ManaRune)
        Self.Say(s.BlessW)
     end
	 
    if Self.Health() < x.Pray and Cool(s.PrayEX) == 0 then
        Self.UseItem(x.ManaRune)
        Self.Say(s.PrayW)
	end
	
	if Self.Health() < x.Quick and Cool(s.QuickEX) == 0 then
        Self.UseItem(x.ManaRune)
        Self.Say(s.QuickW)
	end	
	
	if Self.Mana() <= x.ManaCAST and Self.Health() >= x.Quick then
		Self.UseItem(x.ManaRune)
	end
end

function SDT()
local c = Creature.GetByID(Self.TargetID())
	if c:isValid() and c:isAlive() and c:DistanceFromSelf() >= 2 then
		Self.UseItemWithTarget(x.SDID)
	end
end

function Paraz()
	if Self.isParalyzed() == true and Self.Mana() >= 5	then
		Self.Say("Focused Art")
	end
end

registerEventListener(TIMER_TICK, "Paraz")
Module('Combo', Combo, false)
Module('ComboNWS', ComboNWS, false)
Module('SDT', SDT, false)

function FocusT()
local mana = 5
	if(Self.Mana() >= mana) then
		Self.Cast("Focused Art")
	end
end

Module.New('Focus', function(Mod)
local exaus = 20
	if Self.CanCastSpell('Utani Hur') then
		FocusT()
		Healer2()
		Mod:Delay((exaus * 1000), (exaus * 1000) + 200)
	end
end, true)

Module('Healer', function(mod)
	if Self.Health() < x.StrongB and Cool(s.StrongBEX) == 0 and Self.Level() >= 100 then
		Self.UseItem(x.ManaRune)
		Self.Say(s.StrongBEW)
    end
	
    if Self.Health() < x.BlessS and Cool(s.BlessEX) == 0 and Self.Level() >= 100 then
        Self.UseItem(x.ManaRune)
        Self.Say(s.BlessW)
     end
	 
    if Self.Health() < x.Pray and Cool(s.PrayEX) == 0 then
        Self.UseItem(x.ManaRune)
        Self.Say(s.PrayW)
	end
	
	if Self.Health() < x.Quick and Cool(s.QuickEX) == 0 then
        Self.UseItem(x.ManaRune)
        Self.Say(s.QuickW)
	end	
	
	if Self.Mana() <= x.ManaCAST and Self.Health() >= x.Quick then
		Self.UseItem(x.ManaRune)
	end
end, true)
