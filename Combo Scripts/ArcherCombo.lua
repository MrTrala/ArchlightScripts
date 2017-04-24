--[[
	Combo Archer for ArchlightOnline
	By Mr Trala
	
Thanks to:
Colandus from Otland for the string.explode function.

Instructions;
Config your ManaRune, your HealCast and your ManaCast just below here, then
load the script, the rest of the instructions are in the Archer Channel.

	Change Log;
	
2.0.0 -- First stable full version. -- Public released.
2.0.1 -- Fixed the bug in "ComboAOE" where it wasn't counting correctly the monsters around (was using an old method, now #Self.GetTargets).
2.0.2 -- Added the module "AlarmL" a module to sound an alarm if you see a legendary monster.
2.0.3 -- Fixed problem after Archlight HP/Mana Update.
2.0.4 -- Added the module "ComboSD" a module to combo Gran Con, Cannon, Focused and SD.
2.0.5 -- Fixed a bug in the healer (Thx to Erma for reporting it).
2.0.6 -- Fixed a bug in the shooters.
2.0.7 -- Added the PickUP Module, useful to auti pick your MC tokens, etc.
2.0.8 -- Reworked the PickUP Module.
2.0.9 -- Fixed an error in the ComboAOE module.
2.1.0 -- Fixed an error in the Aim and Life Steal module.
2.1.1 -- ReWorked the ComboSD to work how it was supposed to.
2.1.2 -- Added EXP boosters Module, a module to use all EXP boost (Thanks Starkovonic for the idea).
2.1.3 -- Added Loot module, will pause cavebot when you're looting a monster (you need Shadow speed looter).
2.1.4 -- Added a ReOpener BP module, so you can keep looting after a kick.
2.1.5 -- Fixed some errors with Loot and BP module.
2.1.6 -- ReWorked BP Module.
2.1.7 -- Added an Anti Para.
2.1.8 -- ReWorked Life Steal.
2.1.9 -- Finished EXP MODULE.
2.2.0 -- Fixed a problem in Para Module.
2.2.1 -- Fixed a problem in EXP and Loot module.
2.2.2 -- Fixed a problem in the EXP Module.
2.2.3 -- Added the ComboPS and ComboP, which is the Prestige 3 combo with and without sd respectivelly.
2.2.4 -- Changed some things in Anti PARA module to Use if X prestige.
2.2.5 -- Fixed Life Steal no more available for archers(changed for Archers Grace) + cure paral fixed
]]



version = '2.2.4(PV)'

config = {
	ManaRune = 11632, -- ID of your manarune.
	HealCAST = 95, -- x% hp to cast exura san.
	ManaCAST = 90, -- x% mana to use manarune.
	SDID = 3154, -- ID of your SD, you NEED the donor SD or holyshock to use ComboSD, otherwise isnt gonna work.
	
	--Prestige Config
	PrestigeNum = 3, -- Put your prestige here, 0 if you're not prestiged.
	
	-- EXP Module config.
	ExpUS = 120, -- Time (in seconds) to Re-Use your scrolls (EXP MODULE).
	
	-- Config for PickUP module.
	itemID = {11455, 8828, 8829, 
	21747, 9697, 12803, 
	3154, 5785, 9222, 
	2856, 3580, 16129, 3232, 
	5785, 9586, 939, 
	20270, 2968, 5922, 
	942, 5953, 8764, 
	12724, 20138, 9586, 
	19216, 19218},   -- ItemIDs to be picked up
	containerName = "backpack",  -- Ex. "Purple Backpack", "Backpack of holding", "Bag" etc
	CheckPOS = 1 -- The SQM from your character to check if theres an item.
	
}

spells = {
	-- Exaus
	ArchGraEX = 'exura sio', -- Archers Grace
	FocusedEX = 'exevo gran mas flam', -- Focused shot
	CannoEX = 'exevo vis hur', -- Energy Cannon
	WavesEX = 'exevo dis flam hur', -- Sprays Exaus
	PinPoEX = 'exevo gran mas flam', -- Pinpoint Shot
	PerfectEX = 'utori pox', -- Perfect Shot
	
	-- Words
	FocusedWD = 'Focused Shot',
	GranConWD = 'Exori Gran Con',
	ConWD = 'Energy Cannon',
	PinWD = 'Pinpoint Shot',
	PerfectWD = 'Perfect Shot',
	
	--Sprays
	ESpray = 'Earth Arrow Spray',
	ISpray = 'Ice Arrow Spray',
	FSpray = 'Flame Arrow Spray',
	ENSpray =  'Energy Arrow Spray'
}

scrolls = {}
scrolls[1] = {ItemID = 8764} -- 10% Scroll.
scrolls[2] = {ItemID = 3020} -- 100% Boost.
scrolls[3] = {ItemID = 19109} -- EXP Elixir.
scrolls[4] = {ItemID = 5953} -- Marijuana.
scrolls[5] = {ItemID = 3232} -- 30% Scroll.
scrolls[6] = {ItemID = 8176} -- 50% Scroll.

names =
{
{Name = Self.Name()}
}

for _, name in ipairs(names) do
	if Self.Name() == name.Name then
		print('Welcome to the Archer Combo Script '..name.Name..'.\n'..
		'You are using the version '..version..'.\n'..
		'Have fun!')
		wait(5000)
	end
end

function string.trim(str)
    return (str:gsub("^%s*(.-)%s*$", "%1"))
end

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

spray = {}
x = config
sc = Self.GetSpellCooldown
function onSpeak(channel, message)
	-- receives the channel object that called it and the message that was inputted.
	if (message == '/list') then
		channel:SendYellowMessage('List of Modules', '\n'..
		'Combo -- Use this one to start the basic combo script, "focused shot, exori gran con and energy cannon".\n'..
		'ComboW -- Same as combo but without Energy Cannon (not "new" spell).\n'..
		'ComboA -- This one will shot an Arrow Spray spell, config which one like this "ComboA, earth" (earth, ice, flame and energy).\n'..
		'Aim -- Auto Aim spell (enabled by default).\n'..
		'Manarune -- Auto use your manarune (enabled by default).\n'..
		'LifeSteal -- LifeSteal renew (enabled by default, to stop it write /list LifeSteal).\n'..
		'AlarmL -- a module to sound an alarm if you see a legendary monster.\n'..
		'ComboSD -- a module to combo with cannon, gran con, focused and sd.\n'..
		'PickUP -- a module to pick up everything you want, useful to pick the tokens from your MCS.\n'..	
		'Exp -- a module to use your exp scrolls (all of them) write "/list exp" for more info(BETA).\n'..
		'Loot -- a module that will pause cavebot when you are looting a monster (you need Shadow speed looter).\n'..
		'BPS -- Auto opens the main BP so you can keep looting after a kick (Enabled by Default, to stop it write /list BPS).\n'..
		'ComboP -- Prestige 3 Combo (only for archers with prestige 3 or more) WITHOUT SD!.\n'..
		'ComboPS -- Prestige 3 Combo (only for archers with prestige 3 or more) WITH SD!.\n'..
		'Train -- Use this one to start the training module (exura san + utana vid).\n')
	end
	
	-- Modules
	if (message == '/start Combo') or (message == 'Combo') or (message == 'combo') then
		Module.Start('Combo')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Combo" has been started.')
		
	elseif (message == '/stop Combo') or (message == '/stop combo') then
		Module.Stop('Combo')
		channel:SendRedMessage('Mr Trala', 'The module with the name "Combo" has been stopped.')
		
	elseif (message == '/start ComboW') or (message == 'ComboW') or (message == 'combow') then
		Module.Start('ComboW')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "ComboW" has been started.')
	
	elseif (message == '/stop ComboW') or (message == '/stop combow') then
		Module.Stop('ComboW')
		channel:SendRedMessage('Mr Trala', 'The module with the name "ComboW" has been stopped.')
		
	elseif (message == '/start Aim') or (message == 'Aim') or (message == 'aim') then
		Module.Start('Aim')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Aim" has been started.')
	
	elseif (message == '/stop Aim') or (message == '/stop aim')then
		Module.Stop('Aim')
		channel:SendRedMessage('Mr Trala', 'The module with the name "Aim" has been stopped.')

	elseif (message == '/start Train') or (message == 'Train') or (message == 'train') then
		Module.Start('Train')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Train" has been started.')
		
	elseif (message == '/stop Train') or (message == '/stop train') then
		Module.Stop('Train')
		channel:SendRedMessage('Mr Trala', 'The module with the name "Train" has been stopped.')
		
	elseif (message == '/start Manarune') or (message == 'manarune') or (message == 'mr') then
		Module.Start('Manarune')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Manarune" has been started.')
		
	elseif (message == '/stop Manarune') or (message == '/stop train') then
		Module.Stop('Manarune')
		channel:SendRedMessage('Mr Trala', 'The module with the name "Manarune" has been stopped.')
		
	elseif (message == '/stop ComboA') or (message == '/stop comboa') then
		Module.Stop('ComboAOE')
		channel:SendRedMessage('Mr Trala', 'The module with the name "ComboAOE" has been stopped.')
		
		
	elseif (message == '/start AlarmL') or (message == 'AlarmL') or (message == 'alarml') then
		Module.Start('AlarmL')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "AlarmL" has been started.')
		
	elseif (message == '/stop AlarmL') or (message == '/stop alarml') then
		Module.Stop('AlarmL')
		channel:SendRedMessage('Mr Trala', 'The module with the name "AlarmL" has been stopped.')
		
	elseif (message == '/start ComboSD') or (message == 'ComboSD') or (message == 'combosd') then
		Module.Start('ComboSD')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "ComboSD" has been started.')
		
	elseif (message == '/stop ComboSD') or (message == '/stop combosd') then
		Module.Stop('ComboSD')
		channel:SendRedMessage('Mr Trala', 'The module with the name "ComboSD" has been stopped.')
		
	elseif (message == '/start PickUP') or (message == 'PickUP') or (message == 'pickup') then
		Module.Start('PickUP')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "PickUP" has been started.')
		
	elseif (message == '/stop PickUP') or (message == '/stop pickup') then
		Module.Stop('PickUP')
		channel:SendRedMessage('Mr Trala', 'The module with the name "PickUP" has been stopped.')	
		
	elseif (message == '/start EXP') or (message == 'EXP') or (message == 'exp') then
		Module.Start('EXP')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "EXP" has been started.')
		
	elseif (message == '/stop EXP') or (message == '/stop exp') then
		Module.Stop('EXP')
		channel:SendRedMessage('Mr Trala', 'The module with the name "EXP" has been stopped.')

	elseif (message == '/start Loot') or (message == 'Loot') or (message == 'loot') then
		Module.Start('Looting')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "Looting" has been started.')
		
	elseif (message == '/stop Loot') or (message == '/stop loot') then
		Module.Stop('Looting')
		channel:SendRedMessage('Mr Trala', 'The module with the name "Looting" has been stopped.')
		
	elseif (message == '/start ComboPS') or (message == 'ComboPS') or (message == 'combops') then
		Module.Start('ComboPS')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "ComboPS" has been started.')
		
	elseif (message == '/stop ComboPS') or (message == '/stop combops') then
		Module.Stop('ComboPS')
		channel:SendRedMessage('Mr Trala', 'The module with the name "ComboPS" has been stopped.')
		
	elseif (message == '/start ComboP') or (message == 'ComboP') or (message == 'combop') then
		Module.Start('ComboP')
		channel:SendYellowMessage('Mr Trala', 'The module with the name "ComboP" has been started.')
		
	elseif (message == '/stop ComboP') or (message == '/stop combop') then
		Module.Stop('ComboP')
		channel:SendRedMessage('Mr Trala', 'The module with the name "ComboP" has been stopped.')
				
	elseif (message == '/list BPS') or (message == '/list bps') then
		channel:SendRedMessage('Mr Trala', 'To stop this module you need to search in the script the followin: registerEventListener(TIMER_TICK, "BPS")\n'..
		'Then delete it, save and reaload the script.\n')
		
	elseif (message == '/list LifeSteal') or (message == '/list lifesteal') then
		channel:SendRedMessage('Mr Trala', 'To stop this module you need to search in the script the followin: registerEventListener(TIMER_TICK, "LifeSteal")\n'..
		'Then delete it, save and reaload the script.\n')
		
	elseif (message == '/list exp') then
		channel:SendOrangeMessage('Mr Trala', 'The module will try to use your exp scroll only IF they are in an opened backpack, so\n'..
		'If you have 100% booster but you DONT want to use it, leave it in a closed BP, otherwise it will try to use it.\n')
	end
	
	-- ComboAOE Module
	if (message >= 'ComboA') and string.find(message, "ComboA") then
	local p = string.explode(message, ",")
		if p[2] == '' or not string.find(message, ",") then
			channel:SendRedMessage('Mr Trala', 'Please config which Spray to use like this "ComboA, earth" (earth, ice, flame and energy).')
			
		elseif p[2] == '' or string.find(message, "%d") then
			channel:SendRedMessage('Mr Trala', 'Please config which Spray to use like this "ComboA, earth" (earth, ice, flame and energy).')
			
		else	
			spray = {}
			spray[#spray+1] = {SioT = p[2]}
			Module.Start('ComboAOE')
			channel:SendYellowMessage('Mr Trala', 'The module with the name "ComboAOE" has been started and is going to use '..p[2]..' spray.')
		end
	end
	
	-- Spray Module
end

function ReOpen()
local customChannel = Channel.New('Archer Channel', onSpeak, onClose)
customChannel:SendYellowMessage('Mr Trala', 'Welcome to the Archer Combo Script, configured specifically for ArchlightOnline.\n'..
		'This Script has been made by Mr Trala, and you are using the Version '..version..'\n'..
		'If you found any bug send a message to Mr Trolo or Mr Ponid in Archlight.\n')
customChannel:SendOrangeMessage('Instructions', '\n'..
		'Write /list if you want to see a list of the modules you can use\n'..
		'You can start or stop a Module with the command /start or /stop\n')
end


function onClose(channel)
     -- receives the channel object that called it
     print('To close '..channel:Name()..' you need to kill the script.')
	 ReOpen()
end


local customChannel = Channel.New('Archer Channel', onSpeak, onClose)
customChannel:SendYellowMessage('Mr Trala', 'Welcome to the Archer Combo Script, configured specifically for ArchlightOnline.\n'..
		'This Script has been made by Mr Trala, and you are using the Version '..version..'\n'..
		'If you found any bug send a message to Mr Trolo or Mr Ponid in Archlight.\n')
customChannel:SendOrangeMessage('Instructions', '\n'..
		'Write /list if you want to see a list of the modules you can use\n'..
		'You can start or stop a Module with the command /start or /stop\n')
		
-- Functions of the script.
function PickUP()
local p = Self.Position()
local Cont = Container.New(x.containerName)
    if (Self.Cap() >= 1) then
        for y = -x.CheckPOS, x.CheckPOS do
            for x = -x.CheckPOS, x.CheckPOS do
				if table.contains(config.itemID, Map.GetTopUseItem(p.x + x, p.y + y, p.z).id) then
					Map.PickupItem(p.x+x, p.y+y, p.z, Cont:Index(), 0)
				end
				
				if (Cont:ItemCount() == Cont:ItemCapacity()) then
						local openAt = Cont:ItemCount() - 1
					if (Item.isContainer(Cont:GetItemData(openAt).id)) then
						Cont:UseItem(openAt, true)
					end
				end
			end
		end
	end
end

function Combo()
local creature = Creature.GetByID(Self.TargetID())
	if creature:isValid() and creature:isAlive()  and creature:isTarget() and creature:DistanceFromSelf() <= 6 and Self.Mana() >= 1 then
		if Self.GetSpellCooldown(spells.FocusedEX) >= 1 and Self.GetSpellCooldown(spells.GranConWD) >= 1 and Self.GetSpellCooldown(spells.CannoEX) == 0 then 
			Self.Cast(spells.ConWD)
			Manarune2()
			
		elseif Self.GetSpellCooldown(spells.FocusedEX) == 0 then
			Self.Cast(spells.FocusedWD)
			Manarune2()
		
		elseif Self.GetSpellCooldown(spells.FocusedEX) >= 1  and Self.GetSpellCooldown(spells.GranConWD) == 0 then
			Self.Cast(spells.GranConWD)
			Manarune2()
		end
	end
end

function ComboW()
local creature = Creature.GetByID(Self.TargetID())
	if creature:isValid() and creature:isAlive()  and creature:isTarget() and creature:DistanceFromSelf() <= 6 and Self.Mana() >= 1 then			
		if Self.GetSpellCooldown(spells.FocusedEX) == 0 then
			Self.Cast(spells.FocusedWD)
			Manarune2()
		
		elseif Self.GetSpellCooldown(spells.FocusedEX) >= 1  and Self.GetSpellCooldown(spells.GranConWD) == 0 then
			Self.Cast(spells.GranConWD)
			Manarune2()
		end
	end
end

exaus = 0

function ComboAOE()
	for i = 1, #spray do
local f = spray[i]
local shot = f.SioT
local earth = spells.ESpray
local ice = spells.ISpray
local flame = spells.FSpray
local energy = spells.ENSpray
local creature = Creature.GetByID(Self.TargetID())
		if creature:isValid() and creature:isAlive()  and creature:isTarget() and creature:DistanceFromSelf() <= 6 and (#Self.GetTargets(3)) <= 2 and Self.Mana() >= 1 then			
			if Self.GetSpellCooldown(spells.FocusedEX) == 0 then
				Self.Cast(spells.FocusedWD)
				Manarune2()
			
			elseif Self.GetSpellCooldown(spells.FocusedEX) >= 1  and Self.GetSpellCooldown(spells.GranConWD) == 0 and (#Self.GetTargets(3)) <= 2 then
				Self.Cast(spells.GranConWD)
				Manarune2()
			end
		end

		if (#Self.GetTargets(3)) >= 3 and string.find(shot, "flame") and os.time() - exaus >= math.random(2.03, 2.1) and Self.Mana() >= 1 and creature:isTarget() then
			Self.Cast(flame)
			exaus = os.time()	
			
		elseif (#Self.GetTargets(3)) >= 3 and string.find(shot, "ice") and os.time() - exaus >= math.random(2.03, 2.1) and Self.Mana() >= 1 and creature:isTarget() then
			Self.Cast(ice)
			exaus = os.time()
			
		elseif (#Self.GetTargets(3)) >= 3 and string.find(shot, "energy") and os.time() - exaus >= math.random(2.03, 2.1) and Self.Mana() >= 1 and creature:isTarget() then
			Self.Cast(energy)
			exaus = os.time()
			
		elseif (#Self.GetTargets(3)) >= 3 and string.find(shot, "earth") and os.time() - exaus >= math.random(2.03, 2.1) and Self.Mana() >= 1 and creature:isTarget() then
			Self.Cast(earth)
			exaus = os.time()
		end
	end
end

function ComboSD()
local creature = Creature.GetByID(Self.TargetID())
	if creature:isValid() and creature:isAlive()  and creature:isTarget() and creature:DistanceFromSelf() <= 6 and Self.Mana() >= 1 then
		if Self.GetSpellCooldown(spells.FocusedEX) >= 1 and Self.GetSpellCooldown(spells.GranConWD) >= 1 and Self.GetSpellCooldown(spells.CannoEX) == 0 then
			wait(500, 1050)
			Self.UseItemWithTarget(x.SDID)
			Self.Say(spells.ConWD)
			Manarune2()
			wait(1000)
			
		elseif Self.GetSpellCooldown(spells.FocusedEX) == 0 then
			wait(500, 1050)
			Self.UseItemWithTarget(x.SDID)
			Self.Say(spells.FocusedWD)
			Manarune2()
			wait(1000)
		
		elseif Self.GetSpellCooldown(spells.FocusedEX) >= 1  and Self.GetSpellCooldown(spells.GranConWD) == 0 then
			wait(500, 1050)
			Self.UseItemWithTarget(x.SDID)
			Self.Cast(spells.GranConWD)
			Manarune2()
			wait(1000)
		end
	end
end

function ComboPS()
local c = Creature.GetByID(Self.TargetID())
	if c:isValid() and c:isAlive() and c:isTarget() and c:DistanceFromSelf() <= 6 and Self.Mana() >= 5 then
		if sc(spells.PinPoEX) == 0 then
			Self.UseItemWithTarget(x.SDID)
			Manarune2()
			Self.Say(spells.PinWD)
			
			
		elseif sc(spells.PinPoEX) >= 1 and sc(spells.PerfectEX) == 0 then
			Self.UseItemWithTarget(x.SDID)
			Manarune2()
			Self.Say(spells.PerfectWD)
			
		elseif sc(spells.PinPoEX) >= 1 and sc(spells.PerfectEX) >= 1 and sc(spells.GranConWD) == 0 then
			Self.UseItemWithTarget(x.SDID)
			Manarune2()
			Self.Say(spells.GranConWD)
		end
	end
end

function ComboP()
local c = Creature.GetByID(Self.TargetID())
	if c:isValid() and c:isAlive() and c:isTarget() and c:DistanceFromSelf() <= 6 and Self.Mana() >= 5 then
		if sc(spells.PinPoEX) == 0 then
			Manarune2()
			Self.Say(spells.PinWD)
					
		elseif sc(spells.PinPoEX) >= 1 and sc(spells.PerfectEX) == 0 then
			Manarune2()
			Self.Say(spells.PerfectWD)
			
		elseif sc(spells.PinPoEX) >= 1 and sc(spells.PerfectEX) >= 1 and sc(spells.GranConWD) == 0 then
			Manarune2()
			Self.Say(spells.GranConWD)
		end
	end
end

function Train()
	local spell = "exura san"
	local spell2 = "utana vid"
		if Self.GetSpellCooldown(spell) == 0 and (Self.Mana()>= 10) then
			Self.Say(spell)
		end
		
		if Self.GetSpellCooldown(spell2) == 0 and (Self.Mana()>= 10) then
			Self.Say(spell2)
		end
end

function Manarune2()
	if Self.Health() <= config.HealCAST then
		Self.UseItem(config.ManaRune)
		if Self.GetSpellCooldown(spells.ArchGraEX) == 0 and (Self.Level() >= 250 or config.Prestige > 0) and Self.Health() < 80 then
			Self.Say('Archers Grace')
		else 
			Self.Say('exura san')
		end
		wait(200, 400)
	end
	
	if Self.Mana() <= config.ManaCAST and Self.Health() >= config.HealCAST then
		Self.UseItem(config.ManaRune)
		wait(400, 600)
	end
end

function AlarmL()
local am = 0
	for name, c in Creature.iMonsters(3) do
		if c:isValid() and c:isAlive() and not Self.isInPz() and c:isOnScreen() and c:Skull() == 4 then
			am = am +1
		end
		
		if am >= 1 then
			alert()
			wait(1000)
		end
	end
end

Module('EXP', function(Mod)
	for i = 1, #scrolls do
	local t = scrolls[i]
		if Self.ItemCount(t.ItemID) >= 1 then
			Self.UseItemWithMe(t.ItemID)
			wait(100)
			Self.UseItem(t.ItemID)
			Manarune2()
		end
	end
Mod:Delay((config.ExpUS * 1000), (config.ExpUS * 1000) + 200)
end, false)


Module.New('Looting', function(Mod)
local exaus = 2
	if (#Self.GetTargets(3)) >= 1 then
		Walker.Stop()
	else
		wait(3000)
		Walker.Start()
	end
Mod:Delay((exaus * 1000), (exaus * 1000) + 200)
end, false)

function BPS()
local Op = Container(0)
	if not Op:isOpen() then
		Self.OpenMainBackpack(false) 
	end
end

function Paraz()
	if Self.isParalyzed() == true and Self.Mana() >= 5 and config.PrestigeNum >= 2	then
		Self.Say("Improved Utani Hur")
		
	elseif Self.isParalyzed() == true and Self.Mana() >= 5 and config.PrestigeNum <= 1 then
		Self.Say("Utani Hur")
	end
end

registerEventListener(TIMER_TICK, "Paraz")
registerEventListener(TIMER_TICK, "BPS")
Module('Combo', Combo, false)
Module('ComboW', ComboW, false)
Module('Train', Train, false)
Module('ComboAOE', ComboAOE, false)
Module('AlarmL', AlarmL, false)
Module('ComboSD', ComboSD, false)
Module('PickUP', PickUP, false)
Module('ComboPS', ComboPS, false)
Module('ComboP', ComboP, false)

function AimT()
local mana = 5
		if(Self.Mana() >= mana) then
			Self.Cast("Aim")
		end
end

Module.New('Aim', function(Mod)
local exaus = 9
		if Self.CanCastSpell('Utani Hur') then
			AimT()
			Manarune2()
			Mod:Delay((exaus * 1000), (exaus * 1000) + 200)
		end
end, true)

Module('Manarune', function(mod)
		if Self.Health() <= config.HealCAST then
			Self.UseItem(config.ManaRune)
			if Self.GetSpellCooldown(spells.ArchGraEX) == 0 and (Self.Level() >= 250 or config.Prestige > 0) and Self.Health() < 80 then
				Self.Say('Archers Grace')
			else
				Self.Say('exura san')
			end
			wait(200, 400)
		end
		
		if Self.Mana() <= config.ManaCAST and Self.Health() >= config.HealCAST then
			Self.UseItem(config.ManaRune)
			wait(400, 600)
		end
end, true)
