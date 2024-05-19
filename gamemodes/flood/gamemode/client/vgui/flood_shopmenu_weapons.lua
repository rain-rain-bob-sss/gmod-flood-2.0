local PANEL = {}
function PANEL:Init()
	self.FloodWeaponIconList = {}
	self.FloodWeaponIconList_Collapse = {}

	self.TabList = vgui.Create("DPanelList", self)
	self.TabList:Dock(FILL)
	self.TabList:EnableVerticalScrollbar(true)

	if WeaponCategories then
		for k,v in pairs (WeaponCategories) do
			self.FloodWeaponIconList[k] = vgui.Create("DPanelList", self)
			self.FloodWeaponIconList[k]:SetAutoSize(true) 
		 	self.FloodWeaponIconList[k]:EnableHorizontal(true) 
		 	self.FloodWeaponIconList[k]:SetPadding(4) 
			self.FloodWeaponIconList[k]:SetVisible(true) 
			self.FloodWeaponIconList[k].OnMouseWheeled = nil
			
			self.FloodWeaponIconList_Collapse[k] = vgui.Create("DCollapsibleCategory", self)
			self.FloodWeaponIconList_Collapse[k]:SizeToContents()
			self.FloodWeaponIconList_Collapse[k]:SetLabel(v) 
			self.FloodWeaponIconList_Collapse[k]:SetVisible(true) 
			self.FloodWeaponIconList_Collapse[k]:SetContents(self.FloodWeaponIconList[k])
			self.FloodWeaponIconList_Collapse[k].Paint = function(self, w, h) 
				draw.RoundedBox(0, 0, 1, w, h, Color(0, 0, 0, 0)) 
				draw.RoundedBox(0, 0, 0, w, self.Header:GetTall(), Color(24, 24, 24, 255)) 
			end

			self.TabList:AddItem(self.FloodWeaponIconList_Collapse[k])
		end
	else
		LocalPlayer():ChatPrint([[Failed to load weapon categories table - please notify the server operator.]])
	end

	if Weapons then
		for k, v in pairs(Weapons) do	
			local ItemIcon = vgui.Create("SpawnIcon", self)
			ItemIcon:SetModel(v.Model)
			ItemIcon:SetSize(150,150)
			ItemIcon.DoClick = function(self) 
				local menu = DermaMenu(false,self) 
				menu:AddOption( "Purchase", function() surface.PlaySound("ui/buttonclick.wav") RunConsoleCommand("FloodPurchaseWeapon", k) end )
				menu:AddOption( "Sell", function() surface.PlaySound("ui/buttonclick.wav") chat.AddText(Color( 100, 100, 255 ),"[Flood]This is a wip option!") end ) 
				menu:AddOption( "Close", function()  surface.PlaySound("ui/buttonclick.wav") end ) -- The menu will remove itself, we don't have to do anything.
				menu:Open()
				surface.PlaySound("ui/buttonclick.wav")		
			end

			if v.Name and v.Price then ItemIcon:SetToolTip(Format("%s", "Name: "..v.Name.."\nPrice: $"..v.Price.."\nDamage: "..(v.Damage or "???").."\nAmmo: "..v.Ammo or 'No Ammo'.."\nDescription:"..(v.Description or "No description."))) 
			else ItemIcon:SetToolTip(Format("%s", "Failed to load tooltip - Missing Description")) end

			if v.Group then	self.FloodWeaponIconList[v.Group]:AddItem(ItemIcon) end
			ItemIcon:InvalidateLayout(true) 
		end
	else
		LocalPlayer():ChatPrint([[Failed to load weapon table - please notify the server operator.]])
	end
end
vgui.Register("Flood_ShopMenu_Weapons", PANEL)
