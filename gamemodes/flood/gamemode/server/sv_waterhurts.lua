local whTick = 0
local vec_zero=Vector(0,0,0)
function GM:WaterHurts()
	if GetConVar("flood_wh_enabled"):GetBool() then
		if whTick < CurTime() then
			for _, v in pairs(GAMEMODE:GetActivePlayers()) do
				if v:WaterLevel() >= 1 then
					local dmginfo = DamageInfo()
				    dmginfo:SetDamageType(16384)
					dmginfo:SetDamage(GetConVar("flood_wh_damage"):GetFloat())
				    dmginfo:SetAttacker(game.GetWorld())
				    dmginfo:SetInflictor(game.GetWorld())
					dmginfo:SetDamageForce(vec_zero)
					dmginfo:SetDamagePosition(v:GetShootPos())
				    v:TakeDamageInfo(dmginfo)
				end
			end	
			whTick = CurTime() + (GetConVar("flood_wh_tick"):GetFloat() or 0.5)
		end
	end
end
hook.Add("Tick", "flood waterhurt function",GM.WaterHurts)
