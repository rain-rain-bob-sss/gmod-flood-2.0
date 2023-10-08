function GetWaterControllers()
	local controllers = {}
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass()=="func_water_analog" or v:GetName()=="water" then
			controllers[#controllers + 1] = v
		end
	end

	return controllers
end

function GM:CheckForWaterControllers()
	if #GetWaterControllers() <= 0 then 
		--self.ShouldHaltGamemode = true
		print("Flood was unable to find a valid water controller on "..game.GetMap()..",but you still can try to play if map has water.", 2)
		PrintMessage(4,"Guys! pls tell server owner CHANGE MAP")
	end
end

function GM:RiseAllWaterControllers()
	for i,v in ipairs(player.GetAll())do
		v:SetHealth(100)
		v:SetArmor(0)
	end
	timer.Simple(5,function() --gave players time to ready
		for k,v in pairs(GetWaterControllers()) do
			v:Fire("open")
			v:Fire("setspeed",170)
			if(game.GetMap()=="flood_construct")then
				v:Fire("setspeed",190)
				v:SetKeyValue('MoveDistance','3200')
			end
		end
	end)
end

function GM:LowerAllWaterControllers()
	for k,v in pairs(GetWaterControllers()) do
		v:Fire("close")
		v:Fire("setspeed",600)
	end
	for i,v in ipairs(player.GetAll())do
		v:SetHealth(100)
		v:SetArmor(0)
	end
end

