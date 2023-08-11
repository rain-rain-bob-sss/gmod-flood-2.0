local function PlayerIsFriend(ply, ply2)
	if not IsValid(ply) or not IsValid(ply2) then return end

	for k, v in pairs(ply:CPPIGetFriends()) do
		if v == ply2 then return true end 
	end

	return false 
end

timer.Create("Flood:OffProps", 0.08, 0, function() 
	if GAMEMODE:GetGameState() == 2 or GAMEMODE:GetGameState() == 3 then
		for _, v in ipairs(player.GetAll()) do 
			local ent = v:GetGroundEntity()
			if ent and IsValid(ent) and ent:GetClass() == "prop_physics" and ent:CPPIGetOwner() != v and PlayerIsFriend(ent:CPPIGetOwner(), v) == false then 
				local dmginfo=DamageInfo()
				dmginfo:SetDamage(10)
				dmginfo:SetAttacker(ent)
				dmginfo:SetDamageType(DMG_DISSOLVE)
				v:TakeDamageInfo(dmginfo)
			        v:SetVelocity(v:GetVelocity()*1.2+Vector(0,0,600))
			end
		end
	end
end)
