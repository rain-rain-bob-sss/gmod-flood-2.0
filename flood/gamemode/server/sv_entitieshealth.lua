local mhp={
  ['gmod_thruster']=50
}
local hp={
  ['gmod_thruster']=50
}
hook.Add('OnEntityCreated','Entity health',function(ent)
  ent:SetNWInt("CurrentPropHealth",hp[ent:getClass()] or 0)
	ent:SetNWInt("BasePropHealth",mhp[ent:getClass()] or 0)
end)
