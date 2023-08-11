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
		self.ShouldHaltGamemode = true
		error("Flood was unable to find a valid water controller on "..game.GetMap()..", gamemode halting.", 2)
	end
end

function GM:RiseAllWaterControllers()
	for k,v in pairs(GetWaterControllers()) do
		v:Fire("open")
		if(game.GetMap()=="flood_construct")then
			v:Fire("setspeed",150)
			v:SetKeyValue('MoveDistance','3100')
		end
	end
end

function GM:LowerAllWaterControllers()
	for k,v in pairs(GetWaterControllers()) do
		v:Fire("close")
		v:Fire("setspeed",600)
	end
end

