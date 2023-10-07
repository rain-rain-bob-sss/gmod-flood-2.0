wepdmgtoply={
  weapon_stunstick=50
}
concommand.Add('flood_wepdmgtoplychange',function(p,c,a,as)
    if(p:IsSuperAdmin() or p==NULL or not p:IsValid())then
        if(not wepdmgtoply[a[1]])then return end
      if(not wepdmgtoply[a[2]])then return end
          local result=tonumber[a[2]] or wepdmgtoply[a[1]] or 0
          wepdmgtoply[a[1]]=result
          if(result==0)then
              RunConsoleCommand('flood_candmg',a[1],"0")
          else
              RunConsoleCommand('flood_candmg',a[1],"1")
          end
      end
end)
hook.Add("EntityTakeDamage", "Weapon dmg to ply", function(ent, dmgInfo)
  	local attacker = dmgInfo:GetAttacker()
  	  if (attacker:IsPlayer()) then
  		  local weapon = attacker:GetActiveWeapon()
  		  if (attacker:IsPlayer() && weapon:IsValid() && dmgInfo:GetDamageType() == 128) then
  			  if (wepdmgtoply[weapon:GetClass()]) then
  				    dmgInfo:SetDamage(wepdmgtoply[weapon:GetClass()])
  			  end
  		  end
  	end
end)
