--[[
    Farming for ArchLightOnline
    Version 3.0.4 - ReWorked Version
    Created by Mr Trala
	
Instructions;
Configure Seed, WaterTO, FinalT and PlantID and add the respective ID of your plants (Config to marijuana plating by default).
Close your main door; just in case someone wants to troll you.

For perfect config you can see:
http://i64.tinypic.com/293ktia.png
Have fun!

Change log;
3.0.1 -- Fixed ALOT of wrong things.
3.0.2 -- Added a ReOpen bps, in case you get disconected.
3.0.3 -- ReWorked it again.
3.0.4 -- And again.
3.0.5 -- AND AGAIN.
]]

config = {
	Seed = 5953, -- Id of the plant you want to grow (the seed).
	WaterTO = 331, -- Id of the middle plant (the one who needs water).
	FinalT = 14033, -- Id of the pot to use scythe (the final plant).
	PlantID = {5953}, -- Id of the final plant (the one that will be planted again)	
	Dirts = {950, 4822, 952, 4821, 952} -- Don't Change this.
}


pos = Self.Position()

function WaterIT()
local WBP = Container.GetFirst()
	for y = -7, 7 do
		for x = -7, 7 do
			for spot = 0, WBP:ItemCount() do
				local item = WBP:GetItemData(spot)
				if Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z).id == config.WaterTO and (item.id == 2901) then
					WBP:UseItemWithGround(spot, pos.x + x, pos.y + y, pos.z)
				end
			end
		end
	end
end

function Plant()
local WBP = Container(0)
	for y = -5, 5 do
		for x = -5, 5 do
			if Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z).id == config.Seed then
				Self.UseItemWithGround(3455, pos.x + x, pos.y + y, pos.z)
				wait(3000, 3100)
			
			elseif Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z).id == config.FinalT then		 
				Self.UseItemWithGround(3453, pos.x + x, pos.y + y, pos.z)
				wait(3000, 3100)		
			end
			
			if Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z).id == config.WaterTO then	
				WaterIT()			
			end
		end
	end
	sleep(math.random(1400, 1500))
end

Module('BP', function(mod)
local Op = Container(0)
	if not Op:isOpen() then
		Self.OpenMainBackpack(false) 
	end
mod:Delay((50 * 1000), (50 * 1000) + 200)
end, true)

function Drop()
MainBP = Container(0)
	for y = -5, 5 do
		for x = -5, 5 do
			for spot, item in MainBP:iItems() do
				if table.contains(config.Dirts, Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z).id) and (table.contains(config.PlantID, item.id)) then
						MainBP:MoveItemToGround(spot, pos.x + x, pos.y + y, pos.z, 1)
				end		
			end
		end
	end
end

registerEventListener(TIMER_TICK, "Plant")
registerEventListener(TIMER_TICK, "Drop")
Module('BP', BP, true)
