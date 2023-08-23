local mhp={
  ['gmod_thruster']=50
}
local hp={
  ['gmod_thruster']=50
}
hook.Add('OnEntityCreated','Entity health',function(ent)
	if(not IsValid(ent))then return end
  	ent:SetNWInt("CurrentPropHealth",hp[ent:GetClass()] or 0)
	ent:SetNWInt("BasePropHealth",mhp[ent:GetClass()] or 0)
end)
