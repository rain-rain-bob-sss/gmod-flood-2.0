local PlayerMeta = FindMetaTable("Player")

function GM:PlayerInitialSpawn(ply)
	ply.Allow = false
 
	local data = { }
	data = ply:LoadData()

	ply:SetCash(data.cash)
	ply.Weapons = string.Explode("\n", data.weapons)
	
	ply:SetTeam(TEAM_PLAYER)

	local col = team.GetColor(TEAM_PLAYER)
	ply:SetPlayerColor(Vector(col.r / 255, col.g / 255, col.b / 255))

	if self:GetGameState() >= 2 then
		timer.Simple(0, function ()
			if IsValid(ply) then
				ply:KillSilent()
				ply:SetCanRespawn(false)
			end
		end)
	end
	ply.SpawnTime = CurTime()
	
	PrintMessage(HUD_PRINTCENTER, ply:Nick().." has joined the server!")
end

function GM:PlayerSpawn( ply )
	player_manager.SetPlayerClass( ply, "player_flood" ) -- USE THIS SHIT
	hook.Call( "PlayerLoadout", GAMEMODE, ply )
	hook.Call( "PlayerSetModel", GAMEMODE, ply )
	ply:UnSpectate()
	ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
 	ply:SetPlayerColor(ply:GetPlayerColor())
	--
	-- If the player doesn't have a team in a TeamBased game
	-- then spawn him as a spectator
	--
	local pl=ply
	player_manager.RunClass( pl, "Loadout" )
	player_manager.RunClass( pl, "SetModel" )
	if ( self.TeamBased && ( pl:Team() == TEAM_SPECTATOR || pl:Team() == TEAM_UNASSIGNED ) ) then

		self:PlayerSpawnAsSpectator( pl )
		return

	end

	-- Stop observer mode
	pl:UnSpectate()

	player_manager.OnPlayerSpawn( pl, transiton )
	player_manager.RunClass( pl, "Spawn" )

	-- If we are in transition, do not touch player's weapons
	if ( !transiton ) then
		-- Call item loadout function
		hook.Call( "PlayerLoadout", GAMEMODE, pl )
	end

	-- Set player model
	hook.Call( "PlayerSetModel", GAMEMODE, pl )

	pl:SetupHands()
end

function GM:ForcePlayerSpawn()
	for _, v in pairs(player.GetAll()) do
		if v:CanRespawn() then
			if v.NextSpawnTime && v.NextSpawnTime > CurTime() then return end
			if not v:Alive() and IsValid(v) then
				v:Spawn()	
			end
		end
	end
end

function GM:PlayerLoadout(ply)
	
end

function GM:PlayerSetModel(ply)
	--ply:SetModel("models/player/Group03/Male_06.mdl") No.
end

function GM:PlayerDeathSound()
	return true
end

function GM:PlayerDeathThink(ply)
end

function GM:PlayerDeath(ply, inflictor, attacker )
	ply.NextSpawnTime = CurTime() + 3
	ply.SpectateTime = CurTime() + 2

	if IsValid(inflictor) && inflictor == attacker && (inflictor:IsPlayer() || inflictor:IsNPC()) then
		inflictor = inflictor:GetActiveWeapon()
		if !IsValid(inflictor) then inflictor = attacker end
	end

	-- Don't spawn for at least 2 seconds
	ply.NextSpawnTime = CurTime() + 2
	ply.DeathTime = CurTime()
	
	if ( IsValid( attacker ) && attacker:GetClass() == "trigger_hurt" ) then attacker = ply end
	
	if ( IsValid( attacker ) && attacker:IsVehicle() && IsValid( attacker:GetDriver() ) ) then
		attacker = attacker:GetDriver()
	end

	if ( !IsValid( inflictor ) && IsValid( attacker ) ) then
		inflictor = attacker
	end

	-- Convert the inflictor to the weapon that they're holding if we can.
	-- This can be right or wrong with NPCs since combine can be holding a 
	-- pistol but kill you by hitting you with their arm.
	if ( IsValid( inflictor ) && inflictor == attacker && ( inflictor:IsPlayer() || inflictor:IsNPC() ) ) then
	
		inflictor = inflictor:GetActiveWeapon()
		if ( !IsValid( inflictor ) ) then inflictor = attacker end

	end

	if ( attacker == ply ) then
	
		net.Start( "PlayerKilledSelf" )
			net.WriteEntity( ply )
		net.Broadcast()
		
		MsgAll( attacker:Nick() .. " suicided!\n" )
		
	return end

	if ( attacker:IsPlayer() ) then
	
		net.Start( "PlayerKilledByPlayer" )
		
			net.WriteEntity( ply )
			net.WriteString( inflictor:GetClass() )
			net.WriteEntity( attacker )
		
		net.Broadcast()
		
		MsgAll( attacker:Nick() .. " killed " .. ply:Nick() .. " using " .. inflictor:GetClass() .. ' BUT HOW??!!?!!?!???! '.."\n" )
		
	return end
	
	net.Start( "PlayerKilled" )
	
		net.WriteEntity( ply )
		net.WriteString( inflictor:GetClass() )
		net.WriteString( attacker:GetClass() )

	net.Broadcast()
	
	MsgAll( ply:Nick() .. " was killed by " .. attacker:GetClass() .. "\n" )
	
end

function GM:PlayerSwitchWeapon(ply, oldwep, newwep)
end

function GM:PlayerSwitchFlashlight(ply)
	return true
end

function GM:PlayerShouldTaunt( ply, actid )
	return true --You may taunt.
end

function GM:CanPlayerSuicide(ply)
	return false --????
end

-----------------------------------------------------------------------------------------------
----                                 Give the player their weapons                         ----
-----------------------------------------------------------------------------------------------
function GM:GivePlayerWeapons()
	for _, v in pairs(self:GetActivePlayers()) do
		-- Because the player always needs a pistol
		v:Give("weapon_pistol")
		timer.Simple(0, function() 
			v:GiveAmmo(9999, "Pistol") 
		end)


		if v.Weapons and Weapons then
			for __, pWeapon in pairs(v.Weapons) do
				for ___, Weapon in pairs(Weapons) do
					if pWeapon == Weapon.Class then
						v:Give(Weapon.Class)
						timer.Simple(0, function() 
							v:GiveAmmo(Weapon.Ammo, Weapon.AmmoClass)
						end)
					end
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------
----                                 Player Data Loading                                   ----
-----------------------------------------------------------------------------------------------
function PlayerMeta:LoadData()
	local data = {}
	if file.Exists("flood/"..self:UniqueID()..".txt", "DATA") then
		data = util.KeyValuesToTable(file.Read("flood/"..self:UniqueID()..".txt", "DATA"))
		self.Allow = true
		return data
	else
		self:Save()
		data = util.KeyValuesToTable(file.Read("flood/"..self:UniqueID()..".txt", "DATA"))
		
		-- Initialize cash to a value
		data.cash = 5000
		-- Weapons are initialized elsewhere

		self:Save()
		self.Allow = true
		return data
	end
end

function PlayerLeft(ply)
	ply:Save()
end
hook.Add("PlayerDisconnected", "PlayerDisconnect", PlayerLeft)

function ServerDown()
	for k, v in pairs(player.GetAll()) do
		v:Save()
	end
end
hook.Add("ShutDown", "ServerShutDown", ServerDown)

-----------------------------------------------------------------------------------------------
----                                 Prop/Weapon Purchasing                                ----
-----------------------------------------------------------------------------------------------
function GM:PurchaseProp(ply, cmd, args)
	if not ply.PropSpawnDelay then ply.PropSpawnDelay = 0 end
	if not IsValid(ply) or not args[1] then return end
	
	local Prop = Props[math.floor(args[1])]
	local tr = util.TraceLine(util.GetPlayerTrace(ply))
	local ct = ChatText()

	if ply.Allow and Prop and self:GetGameState() <= 1 then
		if Prop.DonatorOnly == true and not ply:IsDonator() then 
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText(Prop.Description.." is a donator only item!")
			ct:Send(ply)
			return 
		else
			if ply.PropSpawnDelay <= CurTime() then
				
				-- Checking to see if they can even spawn props.
				if(ply:IsSuperAdmin())then
					if ply:GetCount("flood_props") >= GetConVar("flood_max_sadmin_props"):GetInt() then
						ct:AddText("[Flood] ", Color(158, 49, 49, 255))
						ct:AddText("You have reached the admin's prop spawning limit!")
						ct:Send(ply)
						return
					end 
				elseif ply:IsAdmin() then
					if ply:GetCount("flood_props") >= GetConVar("flood_max_admin_props"):GetInt() then
						ct:AddText("[Flood] ", Color(158, 49, 49, 255))
						ct:AddText("You have reached the admin's prop spawning limit!")
						ct:Send(ply)
						return
					end 
				elseif ply:IsDonator() then
					if ply:GetCount("flood_props") >= GetConVar("flood_max_donator_props"):GetInt() then
						ct:AddText("[Flood] ", Color(158, 49, 49, 255))
						ct:AddText("You have reached the donator's prop spawning limit!")
						ct:Send(ply)
						return
					end
				else
					if ply:GetCount("flood_props") >= GetConVar("flood_max_player_props"):GetInt() then 
						ct:AddText("[Flood] ", Color(158, 49, 49, 255))
						ct:AddText("You have reached the player's prop spawning limit!")
						ct:Send(ply)
						return
					end
				end
				local pp=Prop.Price --Faster
				if ply:CanAfford(pp) then
					ply:SubCash(pp)

					local ent = ents.Create("prop_physics")
					if(not ent)then return end
					ent:SetModel(Prop.Model)
					local ea=ply:EyeAngles()
					ea[1]=0
					ea[3]=0
					ent:SetAngles(ea)
					ent:SetPos(tr.HitPos + Vector(0, 0, (ent:OBBCenter():Distance(ent:OBBMins()) + 5)))
					ent:CPPISetOwner(ply)
					ent:Spawn()
					ent:Activate()
					ent:SetHealth(Prop.Health)
					ent:SetNWInt("CurrentPropHealth", math.floor(Prop.Health))
					ent:SetNWInt("BasePropHealth", math.floor(Prop.Health))
					local undofunc=function(t,money)
						if(ent:IsValid())then
							ply:AddCash(money)
							ent:EmitSound("garrysmod/save_load1.wav")
							ent:Remove()
							return true
						else
							return false --You may not undo.
						end
					end
					undo.Create("Prop["..ent:EntIndex().."]".." $"..tostring(pp))
					--undo.AddEntity(ent)
					undo.AddFunction(undofunc,pp)
					undo.SetPlayer(ply)
					undo.Finish("Prop["..ent:EntIndex().."]".." $"..tostring(pp))
					ct:AddText("[Flood] ", Color(132, 199, 29, 255))
					ct:AddText("You have purchased a(n) "..Prop.Description..".")
					ct:Send(ply)
						
					hook.Call("PlayerSpawnedProp", gmod.GetGamemode(), ply, ent:GetModel(), ent)
					ply:AddCount("flood_props", ent)
				else
					ct:AddText("[Flood] ", Color(158, 49, 49, 255))
					ct:AddText("You do not have enough cash to purchase a(n) "..Prop.Description..".")
					ct:Send(ply)
				end
			else
				ct:AddText("[Flood] ", Color(158, 49, 49, 255))
				ct:AddText("You are attempting to spawn props too quickly.")
				ct:Send(ply)
			end
			ply.PropSpawnDelay = CurTime() + 0.25
		end
	else
		ct:AddText("[Flood] ", Color(158, 49, 49, 255))
		ct:AddText("You can not purcahse a(n) "..Prop.Description.." at this time.")
		ct:Send(ply)
	end
end
concommand.Add("FloodPurchaseProp", function(ply, cmd, args) hook.Call("PurchaseProp", GAMEMODE, ply, cmd, args) end)

function GM:PurchaseWeapon(ply, cmd, args)
	if not ply.PropSpawnDelay then ply.PropSpawnDelay = 0 end
	if not IsValid(ply) or not args[1] then return end
	
	local Weapon = Weapons[math.floor(args[1])]
	local ct = ChatText()
	if(Weapon==nil)then 
		ct:AddText('[Anti Exploit]',Color(255,0,0,255))
		ct:AddText('A r e y o u.. e x p l o i t i n g ?')
		ct:Send(ply)
		return
	end
	if ply.Allow and Weapon and self:GetGameState() <= 1 then
		if table.HasValue(ply.Weapons, Weapon.Class) then
			ct:AddText("[Flood] ", Color(158, 49, 49, 255))
			ct:AddText("You already own a(n) "..Weapon.Name.."!")
			ct:Send(ply)
			return
		else
			if Weapon.DonatorOnly == true and not ply:IsDonator() then 
				ct:AddText("[Flood] ", Color(158, 49, 49, 255))
				ct:AddText(Weapon.Name.." is a donator only item!")
				ct:Send(ply)
				return 
			else
				if ply:CanAfford(Weapon.Price) then
					ply:SubCash(Weapon.Price)
					table.insert(ply.Weapons, Weapon.Class)
					ply:Save()

					ct:AddText("[Flood] ", Color(132, 199, 29, 255))
					ct:AddText("You have purchased a(n) "..Weapon.Name..".")
					ct:Send(ply)
				else
					ct:AddText("[Flood] ", Color(158, 49, 49, 255))
					ct:AddText("You do not have enough cash to purchase a(n) "..Weapon.Name..".")
					ct:Send(ply)
				end
			end
		end
	else
		ct:AddText("[Flood] ", Color(158, 49, 49, 255))
		ct:AddText("You can not purcahse a(n) "..Weapon.Name.." at this time.")
		ct:Send(ply)
	end
end
concommand.Add("FloodPurchaseWeapon", function(ply, cmd, args) hook.Call("PurchaseWeapon", GAMEMODE, ply, cmd, args) end)
