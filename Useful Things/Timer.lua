exausSoul = 0
Module('test', function(mod)
local SoulShooter = os.time() - exausSoul -- first timer to shot first spell.
print('Time Left; '..SoulShooter..'.\n')

if Self.Mana() < 80 then
	exausSoul = os.time() -- Restart the timer to count again to X.
end
--[[
if SoulShooter >= math.random(20.5, 21.0) then
  doSomething()
end
]]
end)
