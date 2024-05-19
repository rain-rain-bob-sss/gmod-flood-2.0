function GM:OnSpawnMenuOpen()
	if self.ShopMenu == nil or not self.ShopMenu:IsValid() then
		vgui.Create("Flood_ShopMenu")
	else
		self.ShopMenu:SetVisible(true)
	end
	gui.EnableScreenClicker(true)
	RestoreCursorPosition()	
end

function GM:OnSpawnMenuClose()
	if self.ShopMenu and self.ShopMenu:IsValid() and self.ShopMenu:IsVisible() then
		self.ShopMenu:SetVisible(false)
	end
	RememberCursorPosition()
	gui.EnableScreenClicker(false)
end
concommand.Add('fm_spawnmenureload',function()
	if GAMEMODE.ShopMenu then
		local sm=GAMEMODE.ShopMenuPanel
		sm.WeaponsSheet.Tab:Init()
		sm.PropsSheet.Tab:Init()
		sm.ToolsSheet.Tab:Init()
	end
end)
