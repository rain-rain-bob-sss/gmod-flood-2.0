GM.ConstraintTools = GAMEMODE and GM.ConstraintTools or {}
GM.ConstructionTools = GAMEMODE and GM.ConstructionTools or {}
GM.PosingTools = GAMEMODE and GM.PosingTools or {}
GM.RenderTools = GAMEMODE and GM.RenderTools or {}

-- Tables are {"internal toolname", DonatorOnly bool, Enabled? bool},
GM.ConstraintTools = {
	{"axis", false,true,true}, 		{"ballsocket", false,true,true},
	{"elastic", false,true,true}, 	{"hydraulic", false,true,true},
	{"motor", false, true}, 	{"muscle", false, false,true}, 
	{"pulley", false,true,true}, 	{"rope", false, true}, 
	{"slider", false,true,true}, 	{"weld", false, true},
	{"winch", false,true,true},{"fm_nicesmartweld",false,true}
}

GM.ConstructionTools = {
	{"balloon", false,true,true},	{"button", false, true},
	{"duplicator", false,true,true},{"dynamite", false,true,true},
	{"emitter", false, true}, 	{"hoverball", false,true,true},
	{"lamp", false, true}, 		{"light", false, true},
	{"nocollide", false, true},	{"physprop", false, true},
	{"remover", false, true}, 	{"thruster", false, true},
	{"wheel", false, true}
}

GM.PosingTools = {
	{"eyeposer", false, true}, 	{"faceposer", false, true},
	{"finger", false, true}, 	{"inflator", false, true}
}

GM.RenderTools = {
	{"camera", false, true}, {"colour", false, true},
	{"material", false, true}, {"paint", false, true},
	{"trails", false, true}
}

function GM:CompileToolTable()
	local tools = {}

	for _, v in pairs(self.ConstraintTools) do
		table.insert(tools, v)
	end

	for _, v in pairs(self.ConstructionTools) do
		table.insert(tools, v)
	end

	for _, v in pairs(self.PosingTools) do
		table.insert(tools, v)
	end

	for _, v in pairs(self.RenderTools) do
		table.insert(tools, v)
	end

	return tools
end
