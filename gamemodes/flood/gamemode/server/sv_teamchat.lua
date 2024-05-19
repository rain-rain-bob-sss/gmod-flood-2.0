local function PlayerIsFriend(ply, ply2)
  	if not IsValid(ply) or not IsValid(ply2) then return end
  
  	for k, v in pairs(ply:CPPIGetFriends()) do
  		if v == ply2 then return true end 
  	end
  
  	return false 
end
local gr=Color(8,93,55)
hook.Add("PlayerSay","TeamChatTempFix!",function(ply,txt,ateam)
    if(ateam)then
        local friends=ply:CPPIGetFriends()
        local ct=ChatText()
        ct:AddText("[TEAM]",gr)
        ct:AddText(ply:Nick(),team.GetColor(ply:Team()))
        ct:AddText(":")
        ct:AddText(txt)
        ct:Send(ply)
        for _,v in pairs(friends)do
            if(v~=ply and PlayerIsFriend(v,ply))then
                ct:Send(v)
            end
        end
        ct=nil collectgarbage("step", 64)
        return ""
    end 
end)
