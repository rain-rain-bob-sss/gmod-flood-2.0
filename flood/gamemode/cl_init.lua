-- Include everything
include("shared.lua")
 
MsgN("_-_-_-_- Flood Client Side -_-_-_-_")
MsgN("Loading Clientside Files")
for _, file in pairs(file.Find("flood/gamemode/client/*.lua", "LUA")) do
	MsgN("-> "..file)
	include("flood/gamemode/client/"..file)
end

MsgN("Loading Clientside VGUI Files")
for _, file in pairs(file.Find("flood/gamemode/client/vgui/*.lua", "LUA")) do
	MsgN("-> "..file)
	include("flood/gamemode/client/vgui/"..file)
end
local no=function()
	return false
end
--function GM:SpawnMenuOpen(ply)
--	return false
--end
--function GM:ContextMenuOpen(ply)
--	return false
--end
GM.SpawnMenuOpen=no
GM.ContextMenuOpen=no
--Thanks for Sulfito reporting i used wrong var!
hook.Add("Think","No you dumbass",function()
	if(GAMEMODE.SpawnMenuOpen~=no)then
		GM.SpawnMenuOpen=no
	elseif(GAMEMODE.ContextMenuOpen~=no)then
		GM.ContextMenuOpen=no
	end
end)
function GM:CanProperty(ply, property, ent)
	return false
end
