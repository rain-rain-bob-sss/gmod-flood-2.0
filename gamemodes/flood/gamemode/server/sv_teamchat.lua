local function NADMODISFRIEND(PLY1,PLY2)
	local friends = (NADMOD.Users[PLY1:SteamID()] or {Friends={}}).Friends
	return friends[PLY2:SteamID()]
end
local gr=Color(8,93,55)
hook.Add("PlayerSay","TeamChatTempFix!",function(ply,txt,ateam)
    if(ateam)then
        local friends=ply:CPPIGetFriends()
        local ct=ChatText()
        ct:AddText("[TEAM] ",gr)
        ct:AddText(ply:Nick(),team.GetColor(ply:Team()))
        ct:AddText(": ")
        ct:AddText(txt)
        ct:Send(ply)
        for _,v in pairs(friends)do
            if(v~=ply and NADMODISFRIEND(v,ply))then
                ct:Send(v)
            end
        end
        ct=nil collectgarbage("step", 64)
        return ""
    end 
end)
