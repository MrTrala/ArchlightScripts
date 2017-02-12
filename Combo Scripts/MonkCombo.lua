--[[
	Combo Monk for ArchlightOnline
	By Mr Trala
]]

config = {
	ManaRune = 11607, -- ID of your manarune.
	ManaCAST = 80, -- x% mana to use manarune.
	SDID = 3154, -- ID of your sd.
	Soul = true, -- True if you want to use your soul rune between your kicks, false if not.
	
-- Prestige Config
	PrestigeNum = 0, -- Put your prestige number here.
}

-- This config aply only if you are using a character of lvl 90+
healers = {}
healers[1] = {Words = "Strong Healing Spring", Exaus = "utura", Health = 100}
healers[2] = {Words = "Healing Spring", Exaus = "exura gran mas res", Health = 100}
healers[3] = {Words = "Prayer", Exaus = "exura ico", Health = 70}
healers[4] = {Words = "exura san", Exaus = "exura san", Health = 90}

kick = {} -- HOW-TO; Put 1, 2 and 3 to the 3 kicks you want to use YOU'RE NOT going to use kick 4 and 5, so make sure you config it RIGHT.
kick[1] = {Words = "Ultimate Energy Kick", Exaus ="exori max vis"}
kick[2] = {Words = "Ultimate Ice kick", Exaus ="exori max frigo"}
kick[3] = {Words = "Ultimate Earth Kick", Exaus ="exori max tera"}
kick[4] = {Words = "Ultimate Death Kick", Exaus ="exori max vis"}
kick[5] = {Words = "Ultimate Fire Kick", Exaus ="exori max flam"}


-- Don't touch anything below this line if you don't know what are you doing.
spells = {
	-- Exhausteds
	StrongFPEX = 'exura gran ico', -- Strong Flurry of Punches
	FlurryPEX = 'exori ico', -- Flurry of Punches
	MinFPEX = 'exori gran ico', -- Min Flurry of Punches
	KnockEX = 'exevo vis hur', -- Knockout
	
	-- Words
	StrongFPWD = 'Strong Flurry of Punches', -- lvl 250
	FlurryPWD = 'Flurry of Punches', -- lvl 80
	MinFPWD = 'Min Flurry of Punches', -- lvl 8
	KnockWD = 'Knockout Punch', -- lvl 650
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

1.0 -- First version, added Combo punches module.
1.0.1 -- Added a healer.
1.0.2 -- First stable version (With healer and low lvl combo)
1.0.3 -- Made changes to the healer.
1.0.4 -- Added Focus module.
1.0.5 -- Fixed an error in the healer module.
1.0.6 -- Added a basic sd target module. -- REMOVED.
1.0.7 -- Added ComboN module. -- Realeased bcz alot of ppl is asking for it.
1.0.8 -- Fixed a bug in the healer (Thx to Erma for reporting it).
1.0.9 -- Fixed a bug in the healer (Thx Spheon for reporting it).
1.1.0 -- Added an Anty Paralz.
1.1.1 -- Fixed a little bug in the Combo Module.
2.0.0 -- Added the Soul Rune, ReWork on the Combo module, Fixed some shit in the Focus; Added EXP USER Module.
2.0.1 -- Added the ANTI Para Module; Added the Prestige config -- You still cannot use this script if you are Prestige > 3.
2.0.2 -- ReWorked the healer completely.
2.0.3 -- Added ComboSD, same as Combo but this one combo with SD.
2.0.4 -- Added Kicks module, it cycles between 3 kicks (read instructions) - IDEA; Destripador.
2.0.5 -- Added Auto BP Timer.
]]
names =
{
{Name = Self.Name()}
}
version = '2.0.5(FV)'
for _, name in ipairs(names) do
	if Self.Name() == name.Name then
		print('Welcome to the Monk Combo Script '..name.Name..'.\n'..
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
		'Combo -- THE combo for Monks, no need to check lvl, just turn it on.\n'..
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
		
	elseif (message == '/start Kicks') or (message == 'Kicks') or (message == 'kicks') then
		Module.Start('KicksIN')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Kicks" has been started.')
		
	elseif (message == '/stop Kicks') or (message == '/stop Kicks') then
		Module.Stop('KicksIN')
		channel:SendRedMessage('Mr Trala', 'The module with the name "Kicks" has been stopped.')
		
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
local customChannel = Channel.New('Monk Channel', onSpeak, onClose)
customChannel:SendYellowMessage('Mr Trala', 'Welcome to the Monk Combo Script, configured specifically for ArchlightOnline.\n'..
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

local customChannel = Channel.New('Monk Channel', onSpeak, onClose)
customChannel:SendYellowMessage('Mr Trala', 'Welcome to the Monk Combo Script, configured specifically for ArchlightOnline.\n'..
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
			Self.UseItemWithTarget(3167)
			wait(200)
			Self.UseItemWithTarget(3167)
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

function KicksIN()
	for i = 1, #kick do
local s = kick[i]
local c = Creature.GetByID(Self.TargetID())
		if c:isValid() and c:isAlive() and c:isTarget() and c:DistanceFromSelf() == 1 then
			if Self.GetSpellCooldown(s.Exaus) == 0 then
				Soul()
				SD()
				Self.Say(s.Words)
			end
		end
	end
end

function ComboNWS() -- Combo lvl 650+
	if Cool(s.StrongFPEX) >= 1 and Cool(s.FlurryPEX) >= 1 and Cool(s.KnockEX) >= 1 and Cool(s.MinFPEX) == 0 then 
		Soul()
		Self.Say(s.MinFPWD) -- Min Flurry of Punches 
		Healer()
		
	elseif Cool(s.StrongFPEX) == 0 then
		Soul()
		Self.Say(s.StrongFPWD) -- Strong Flurry of Punches
		Healer()
		
	elseif Cool(s.StrongFPEX) >= 1 and Cool(s.KnockEX) == 0 then
		Soul()
		Self.Say(s.KnockWD) -- Knockout Punch
		Healer()
	
	elseif Cool(s.StrongFPEX) >= 1 and Cool(s.KnockEX) >= 1 and Cool(s.FlurryPEX) == 0 then
		Soul()
		Self.Say(s.FlurryPWD) -- Flurry of Punches
		Healer()
	end
end


function ComboLOW() -- Combo For lvls 250+
	if Cool(s.StrongFPEX) >= 1 and Cool(s.FlurryPEX) >= 1 and Cool(s.MinFPEX) == 0 then 
		Soul()
		Self.Cast(s.MinFPWD) -- Min Flurry of Punches 
		Healer()
		
	elseif Cool(s.StrongFPEX) == 0 then
		Soul()
		Self.Cast(s.StrongFPWD) -- Strong Flurry of Punches
		Healer()
	
	elseif Cool(s.StrongFPEX) >= 1  and Cool(s.FlurryPEX) == 0 then
		Soul()
		Self.Cast(s.FlurryPWD) -- Flurry of Punches
		Healer()
	end
end


function ComboLOWS() -- Combo for Lvls 80-249
	if Cool(s.FlurryPEX) == 0 then
		Soul()
		Self.Cast(s.FlurryPWD)
		Healer()
	
	elseif Cool(s.FlurryPEX) >= 1  and Cool(s.MinFPEX) == 0 then
		Soul()
		Self.Cast(s.MinFPWD)
		Healer()
	end
end


function ComboLVLE() -- Combo for lvls 8-79
	if Cool(s.MinFPEX) == 0 then
		Soul()
		Self.Cast(s.MinFPWD)
		Healer()
	end
end

function Combo()
local lvl = Self.Level()
local c = Creature.GetByID(Self.TargetID())
	if c:isValid() and c:isAlive() and c:isTarget() and c:DistanceFromSelf() == 1 then
		if lvl >= 8 and lvl <= 79 then
			ComboLVLE() -- 8-79
			
		elseif lvl >= 80 and lvl <= 249 then
			ComboLOWS() -- 80-249
			
		elseif lvl >= 250 and lvl <= 649 then
			ComboLOW() -- 250-649
			
		elseif lvl >= 650 then
			ComboNWS()
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
	if Self.isParalyzed() == true and Self.Mana() >= 5 and x.PrestigeNum >= 2	then
		Self.Say("Improved Utani Hur")
		
	elseif Self.isParalyzed() == true and Self.Mana() >= 5 and PrestigeNum <= 1	then
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
Mod:Delay((config.ExpUS * 1000), (config.ExpUS * 1000) + 200)
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
Module('KicksIN', KicksIN, false)
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
		Healer()
		Mod:Delay((exaus * 1000), (exaus * 1000) + 200)
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
