--[[
	Combo Berserker for ArchlightOnline
	By Mr Trala
]]

config = {
	ManaRune = 11604, -- ID of your manarune.
	ManaCAST = 80, -- x% mana to use manarune.
	SDID = 3154, -- ID of your sd.
	Soul = true, -- True if you want to use your soul rune between your kicks, false if not.
	
-- Prestige Config
	Prestige = 0, -- Put your prestige number here.
	
-- EXP Module config.
	ExpUS = 120, -- Time (in seconds) to Re-Use your scrolls (EXP MODULE).
}

-- This config aply only if you are using a character of lvl 8+
healers = {}
healers[1] = {Words = "Exura Ico", Exaus = "exura ico", Health = 90}

-- Don't touch anything below this line if you don't know what are you doing.
spells = {
	-- Exhausteds
	MinSBEX = 'exori min', -- Spinning Blades
	ExoriGEX = 'Exori Gran', -- Exori Gran	
	StrongSB = 'utori kor', -- Strong Spinning Blades
	FinalEX = 'exevo vis hur', -- Final Showdown
	ExoriIEX = 'exori gran ico', -- Exori Gran Ico
	
	-- Words	
	MinSBWD = 'Spinning Blades', -- lvl 45
	ExoriGWD = 'Exori Gran', -- lvl 90	
	ExoriIWD = 'exori gran ico', -- lvl 110
	StrongSBWD = 'Strong Spinning Blades', -- lvl 175
	FinalWD = 'Final Showdown' -- lvl 650
}

scrolls = {}
scrolls[1] = {ItemID = 8764} -- 10% Scroll.
scrolls[2] = {ItemID = 3020} -- 100% Boost.
scrolls[3] = {ItemID = 19109} -- EXP Elixir.
scrolls[4] = {ItemID = 5953} -- Marijuana.
scrolls[5] = {ItemID = 3232} -- 30% Scroll.
scrolls[6] = {ItemID = 8176} -- 50% Scroll.


--[[
	Change Log;

1.0 -- First stable version.
]]
names =
{
{Name = Self.Name()}
}
version = '1.0.0(FV)'
for _, name in ipairs(names) do
	if Self.Name() == name.Name then
		print('Welcome to the Berserker Combo Script '..name.Name..'.\n'..
		'You are using the version '..version..'.\n'..
		'If you find any bug report it in the GitHub or Arch Forum.\n'..
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
		'Combo -- THE combo for Berserkers, no need to check lvl, just turn it on.\n'..
		'ComboSD -- Same with Combo but it combo an SD.\n'..
		'Exp -- a module to use your exp scrolls (all of them) write "/list exp" for more info.\n'..
		'BPS -- Auto opens the main BP so you can keep looting after a kick (Enabled by Default, to stop it write /list BPS).\n'..
		'Healer -- This is your healer module (Enabled by default).\n'..
		'Focus -- A module to keep using Focused Art.\n'..
		'Train -- Use this one to start the training module (exura san + utana vid).\n')
	end
	
	-- Modules
	if (message == '/start Combo') or (message == 'Combo') or (message == 'combo') then
		Module.Start('Combo')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Combo" has been started.')
		
	elseif (message == '/stop Combo') or (message == '/stop combo') or (message == 'stop combo') or (message == '/Stop Combo') then
		Module.Stop('Combo')
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
		
	elseif (message == '/start EXP') or (message == 'EXP') or (message == 'exp') then
		Module.Start('EXP')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "EXP" has been started.')
		
	elseif (message == '/stop EXP') or (message == '/stop exp') then
		Module.Stop('EXP')
		channel:SendRedMessage('Mr Trala', 'The module with the name "EXP" has been stopped.')
		
	elseif (message == '/start ComboSD') or (message == 'ComboSD') or (message == 'combosd') then
		Module.Start('ComboSD')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "ComboSD" has been started.')
		
	elseif (message == '/stop ComboSD') or (message == '/stop combosd') then
		Module.Stop('ComboSD')
		channel:SendRedMessage('Mr Trala', 'The module with the name "ComboSD" has been stopped.')

	elseif (message == '/list exp') then
		channel:SendOrangeMessage('Mr Trala', 'The module will try to use your exp scroll only IF they are in an opened backpack, so\n'..
		'If you have 100% booster but you DONT want to use it, leave it in a closed BP, otherwise it will try to use it.\n')
	
	elseif (message == '/list BPS') or (message == '/list bps') then
		channel:SendRedMessage('Mr Trala', 'To stop this module you need to search in the script the followin: registerEventListener(TIMER_TICK, "BPS")\n'..
		'Then delete it, save and reaload the script.\n')
	end
end

function ReOpen()
local customChannel = Channel.New('Zerker Channel', onSpeak, onClose)
customChannel:SendYellowMessage('Mr Trala', 'Welcome to the Berserker Combo Script, configured specifically for ArchlightOnline.\n'..
		'This Script has been made by Mr Trala, and you are using the Version '..version..'\n'..
		'If you found any bug send a message to Mr Trala in Archlight.\n')
customChannel:SendOrangeMessage('Instructions', '\n'..
		'Write /list if you want to see a list of the modules you can use\n'..
		'You can start or stop a Module with the command /start or /stop\n')
end

function onClose(channel)
     -- receives the channel object that called it
     print('To close '..channel:Name()..' you need to kill the script.')
	 ReOpen()
end

local customChannel = Channel.New('Zerker Channel', onSpeak, onClose)
customChannel:SendYellowMessage('Mr Trala', 'Welcome to the Berserker Combo Script, configured specifically for ArchlightOnline.\n'..
		'This Script has been made by Mr Trala, and you are using the Version '..version..'\n'..
		'If you found any bug send a message to Mr Trala in Archlight.\n')
customChannel:SendOrangeMessage('Instructions', '\n'..
		'Write /list if you want to see a list of the modules you can use\n'..
		'You can start or stop a Module with the command /start or /stop\n')
		
	
-- Functions
exausSoul = 0
exausSD = 0
function Soul()
	if x.Soul == true then
	local SoulShooter = os.time() - exausSoul -- first timer to shot first spell.
		if SoulShooter >= math.random(21.4, 22.0) then
			wait(500)
			Self.UseItemWithTarget(3193)
			wait(200)
			Self.UseItemWithTarget(3193)
			exausSoul = os.time()
		end
	end
end

function SD()
local SDShooter = os.time() - exausSoul -- first timer to shot first SD.
	if SDShooter >= math.random(2.1, 2.2) then
		wait(200)
		Self.UseItemWithTarget(x.SDID)
		wait(200)
		Self.UseItemWithTarget(x.SDID)
		exausSD = os.time()
	end
end

function ComboNWS() -- Combo lvl 650+
	if Cool(s.StrongSB) >= 1 and Cool(s.ExoriGEX) >= 1 and Cool(s.FinalEX) >= 1 and Cool(s.MinSBEX) == 0 then 
		Soul()
		Self.Say(s.MinSBWD) -- Spinning Blades
		Healer()
		
	elseif Cool(s.StrongSB) == 0 then
		Soul()
		Self.Say(s.StrongSBWD) -- Strong Spinning Blades
		Healer()
		
	elseif Cool(s.StrongSB) >= 1 and Cool(s.FinalEX) == 0 then
		Soul()
		Self.Say(s.FinalWD) -- Final Showdown
		Healer()
	
	elseif Cool(s.StrongSB) >= 1 and Cool(s.FinalEX) >= 1 and Cool(s.ExoriGEX) == 0 then
		Soul()
		Self.Say(s.ExoriGWD) -- Exori Gran
		Healer()
		
	elseif Cool(s.StrongSB) >= 1 and Cool(s.ExoriGEX) >= 1 and Cool(s.FinalEX) >= 1 and Cool(s.MinSBEX) >= 1 and Cool(s.ExoriIEX) == 0 then 
		Soul()
		Self.Say(s.ExoriIWD) -- Exori Gran Ico
		Healer()
	end
end


function ComboLOW() -- Combo For lvls 175
	if Cool(s.StrongSB) >= 1 and Cool(s.MinSBEX) == 0 then 
		Soul()
		Self.Say(s.MinSBWD) -- Spinning Blades
		Healer()
		
	elseif Cool(s.StrongSB) == 0 then
		Soul()
		Self.Say(s.StrongSBWD) -- Strong Spinning Blades
		Healer()
	
	elseif Cool(s.StrongSB) >= 1 and Cool(s.MinSBEX) >= 1 and Cool(s.ExoriGEX) == 0 then
		Soul()
		Self.Say(s.ExoriGWD) -- Exori Gran
		Healer()
		
	elseif Cool(s.StrongSB) >= 1 and Cool(s.ExoriGEX) >= 1 and Cool(s.MinSBEX) >= 1 and Cool(s.ExoriIEX) == 0 then 
		Soul()
		Self.Say(s.ExoriIWD) -- Exori Gran Ico
		Healer()
	end
end

function ComboLOWSS() -- Combo for Lvls 110
	if Cool(s.ExoriGEX) == 0 then
		Soul()
		Self.Say(s.ExoriGWD)
		Healer()
	
	elseif Cool(s.ExoriGEX) >= 1  and Cool(s.MinSBEX) == 0 then
		Soul()
		Self.Say(s.MinSBWD)
		Healer()
		
	elseif Cool(s.ExoriGEX) >= 1  and Cool(s.MinSBEX) >= 1 and Cool(s.ExoriIEX) == 0 then
		Soul()
		Self.Say(s.ExoriIWD)
		Healer()
	end
end

function ComboLOWS() -- Combo for Lvls 90
	if Cool(s.ExoriGEX) == 0 then
		Soul()
		Self.Say(s.ExoriGWD)
		Healer()
	
	elseif Cool(s.ExoriGEX) >= 1  and Cool(s.MinSBEX) == 0 then
		Soul()
		Self.Say(s.MinSBWD)
		Healer()
	end
end


function ComboLVLE() -- Combo for lvls 45-89
	if Cool(s.MinSBEX) == 0 then
		Soul()
		Self.Say(s.MinSBWD)
		Healer()
	end
end


function Combo()
local lvl = Self.Level()
local c = Creature.GetByID(Self.TargetID())
	if c:isValid() and c:isAlive() and c:isTarget() and c:DistanceFromSelf() == 1 then
		if lvl >= 45 and lvl <= 89 then
			ComboLVLE() -- 45-89
			
		elseif lvl >= 90 and lvl <= 109 then
			ComboLOWS() -- 90-109
			
		elseif lvl >= 110 and lvl <= 174 then
			ComboLOWSS() -- 110-175
			
		elseif lvl >= 175 and lvl <= 649 then
			ComboLOW() -- 175-649
			
		elseif lvl >= 650 then
			ComboNWS() -- Final Combo
		end
	end
end

function ComboSD()
local lvl = Self.Level()
local c = Creature.GetByID(Self.TargetID())
	if c:isValid() and c:isAlive() and c:isTarget() and c:DistanceFromSelf() == 1 then
		if lvl >= 8 and lvl <= 79 then
			SD()
			ComboLVLE() -- 8-79
			
		elseif lvl >= 80 and lvl <= 249 then
			SD()
			ComboLOWS() -- 80-249
			
		elseif lvl >= 250 and lvl <= 649 then
			SD()
			ComboLOW() -- 250-649
			
		elseif lvl >= 650 then
			SD()
			ComboNWS()
		end
	end
end


function Paraz()
	if Self.isParalyzed() == true and Self.Mana() >= 5 and x.Prestige >= 2	then
		Self.Say("Improved Utani Hur")
		
	elseif Self.isParalyzed() == true and Self.Mana() >= 5 and x.Prestige <= 1	then
		Self.Say("Utani Hur")
	end
end

Module('EXP', function(Mod)
	for i = 1, #scrolls do
	local t = scrolls[i]
		if Self.ItemCount(t.ItemID) >= 1 then
			Self.UseItemWithMe(t.ItemID)
			wait(100)
			Self.UseItem(t.ItemID)
			Healer()
		end
	end
Mod:Delay((x.ExpUS * 1000), (x.ExpUS * 1000) + 200)
end, false)

function BPS()
local Op = Container(0)
	if not Op:isOpen() then
		Self.OpenMainBackpack(false) 
	end
end

registerEventListener(TIMER_TICK, "BPS")
registerEventListener(TIMER_TICK, "Paraz")
Module('Combo', Combo, false)
Module('ComboSD', ComboSD, false)
Module('SDT', SDT, false)

Module.New('LifeSteal', function(Mod)
	if Cool("exura gran ico") == 0 then
		Self.Say("Life Steal")
		Healer()
	end
end, true)

function Healer()
	for i = 1, #healers do
local h = healers[i]
		if Self.Health() <= h.Health and Cool(h.Exaus) == 0 then
			Self.UseItem(x.ManaRune)
			Self.Say(h.Words)
		end
		
		if Self.Mana() <= x.ManaCAST and Self.Health() >= h.Health then
			Self.UseItem(x.ManaRune)
		end
	end
end
Module('Healer', Healer, true)
