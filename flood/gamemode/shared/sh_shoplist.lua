PropCategories = {}
Pcp={}
Props = {}
WeaponCategories = {}
Weapons = {}

-- Prop categories
PropCategories[1] = "Bouyant Props"
PropCategories[2] = "Armor Props"
PropCategories[3] = "Free Props"
-- Prop catergories price
Pcp[3]=0
-- Weapon categories
WeaponCategories[1] = "Basic Weapons"
WeaponCategories[2] = "Xdefm fishing mod"
WeaponCategories[3] = "Dev only"
function GM:AddProp(tbl)
    if(tbl.Price==nil)then
        if(Pcp[tbl.Group])then
            tbl.Price=Pcp[tbl.Group]
        else
            tbl.Price=100
        end
    end
    if(tbl.Name)then
        tbl.Description=tbl.Name
    end
    Props[#Props+1]=tbl
end
function GM:AddWeapon(tbl)
    Weapons[#Weapons+1]=tbl
end
-- Props
Props[1] = {Model = "models/props_c17/FurnitureTable002a.mdl", Group = 1, Price = 50, Health = 25, DonatorOnly = false, Description = "Wooden Table"}
Props[2] = {Model = "models/props_c17/gravestone003a.mdl", Group = 2, Price = 160, Health = 80, DonatorOnly = false, Description = "Gravestone"}
Props[3] = {Model = "models/props_c17/oildrum001.mdl", Group = 2, Price = 60, Health = 100, DonatorOnly = false, Description = "Oil Drum"}
Props[4] = {Model = "models/props_c17/concrete_barrier001a.mdl", Group = 2, Price = 150, Health = 200, DonatorOnly = false, Description = "Concrete Barrier"}
Props[5] = {Model = "models/props_c17/gravestone_coffinpiece002a.mdl", Group = 2, Price = 160, Health = 80, DonatorOnly = false, Description = "Coffin Piece"}
Props[6] = {Model = "models/props_c17/display_cooler01a.mdl", Group = 2, Price = 860, Health = 430, DonatorOnly = false, Description = "Display Case"}
Props[7] = {Model = "models/props_c17/bench01a.mdl", Group = 1, Price = 40, Health = 70, DonatorOnly = false, Description = "Wooden Bench"}
Props[8] = {Model = "models/props_c17/FurnitureCouch001a.mdl", Group = 2, Price = 400, Health = 200, DonatorOnly = false, Description = "Red Couch"}
Props[9] = {Model = "models/Combine_Helicopter/helicopter_bomb01.mdl", Group = 1, Price = 30, Health = 80, DonatorOnly = false, Description = "HeliBomb"}
Props[10] = {Model = "models/props_c17/shelfunit01a.mdl", Group = 1, Price = 180, Health = 90, DonatorOnly = false, Description = "Wooden Shelf 1"}
Props[11] = {Model = "models/props_c17/FurnitureShelf001a.mdl", Group = 1, Price = 200, Health = 100, DonatorOnly = false, Description = "Wooden Shelf 2"}
Props[12] = {Model = "models/props_interiors/Furniture_shelf01a.mdl", Group = 1, Price = 450, Health = 225, DonatorOnly = false, Description = "Wooden Shelf 3"}
Props[13] = {Model = "models/props_c17/Lockers001a.mdl", Group = 2, Price = 700, Health = 350, DonatorOnly = false, Description = "Metal Locker"}
Props[14] = {Model = "models/props_debris/metal_panel02a.mdl", Group = 2, Price = 100, Health = 50, DonatorOnly = false, Description = "Metal Panel 1"}
Props[15] = {Model = "models/props_debris/metal_panel01a.mdl", Group = 2, Price = 200, Health = 100, DonatorOnly = false, Description = "Metal Panel 2"}
Props[16] = {Model = "models/props_c17/canister_propane01a.mdl", Group = 2, Price = 150, Health = 75, DonatorOnly = false, Description = "Gas Canister 1"}
Props[17] = {Model = "models/props_c17/canister01a.mdl", Group = 2, Price = 100, Health = 50, DonatorOnly = false, Description = "Gas Canister 2"}
Props[18] = {Model = "models/props_doors/door03_slotted_left.mdl", Group = 1, Price = 250, Health = 125, DonatorOnly = false, Description = "Door"}
Props[19] = {Model = "models/props_docks/dock03_pole01a_256.mdl", Group = 1, Price = 400, Health = 200, DonatorOnly = false, Description = "Wooden Pole 1"}
Props[20] = {Model = "models/props_docks/dock01_pole01a_128.mdl", Group = 1, Price = 200, Health = 100, DonatorOnly = false, Description = "Wooden Pole 2"}
Props[21] = {Model = "models/props_interiors/BathTub01a.mdl", Group = 2, Price = 800, Health = 400, DonatorOnly = false, Description = "Bathtub"}
Props[22] = {Model = "models/props_interiors/Furniture_Desk01a.mdl", Group = 1, Price = 160, Health = 150, DonatorOnly = false, Description = "Wooden Desk"}
Props[23] = {Model = "models/props_interiors/refrigerator01a.mdl", Group = 2, Price = 600, Health = 300, DonatorOnly = false, Description = "Refrigerator"}
Props[24] = {Model = "models/props_interiors/refrigeratorDoor01a.mdl", Group = 2, Price = 300, Health = 150, DonatorOnly = false, Description = "Refrigerator Door"}
Props[25] = {Model = "models/props_interiors/VendingMachineSoda01a.mdl", Group = 1, Price = 1200, Health = 300, DonatorOnly = false, Description = "Vending Machine"}
Props[26] = {Model = "models/props_interiors/VendingMachineSoda01a_door.mdl", Group = 1, Price = 600, Health = 300, DonatorOnly = false, Description = "Vending Machine Door"}
Props[27] = {Model = "models/props_building_details/Storefront_Template001a_Bars.mdl", Group = 2, Price = 300, Health = 350, DonatorOnly = false, Description = "Window Bars"}
Props[28] = {Model = "models/props_borealis/bluebarrel001.mdl", Group = 1, Price = 50, Health = 120, DonatorOnly = false, Description = "Blue barrel"}
Props[29] = {Model = "models/props_wasteland/cafeteria_table001a.mdl",Group=1,Price=120,Health=150,Description="Cafeteria Table",rdescription="Just a Cafeteria tbl.",}
-- Weapons
-- OMFG,STOP ADDING SOME DONATOR ONLY WEAPON,IF YOU WANT JUST MAKE IT BALANCE DAMN.
Weapons[1] = {Model = "models/weapons/w_crossbow.mdl", Group = 1, Class = "weapon_crossbow", Name = "Crossbow", Price = 15000, Ammo = 1000, AmmoClass = "XBowBolt", Damage = 50, DonatorOnly = false}
Weapons[2] = {Model = "models/weapons/w_rocket_launcher.mdl", Group = 1, Class = "weapon_rpg", Name = "RPG", Price = 37500, Ammo = 3, AmmoClass = "RPG_Round", Damage = 20, DonatorOnly = false}
Weapons[3] = {Model = "models/weapons/W_357.mdl", Group = 1, Class = "weapon_357", Name = "357 Magnum", Price = 10000, Ammo = 1000, AmmoClass = "357", Damage = 12.5, DonatorOnly = false}
Weapons[4] = {Model = "models/weapons/w_grenade.mdl", Group = 1, Class = "weapon_frag", Name = "Frag Grenade", Price = 11250, Ammo = 3, AmmoClass = "Grenade", Damage = 15, DonatorOnly = false}
Weapons[6] = {Model = "models/weapons/w_crowbar.mdl", Group = 1, Class = "weapon_crowbar", Name = "Crowbar", Price = 5000, Ammo = 0, AmmoClass = "Pistol", Damage = 60, DonatorOnly = false}
Weapons[7] = {Model = "models/weapons/w_shotgun.mdl", Group = 1, Class = "weapon_shotgun", Name = "Shotgun", Price = 40000, Ammo = 100, AmmoClass = "Buckshot", Damage = 8, DonatorOnly = false}
Weapons[8] = {Model = "models/weapons/w_slam.mdl", Group = 1, Class = "weapon_slam", Name = "SLAM", Price = 1250, Ammo = 8, AmmoClass = "slam", Damage = 15, DonatorOnly = false}
Weapons[9] = {Model = "models/weapons/w_smg1.mdl", Group = 1, Class = "weapon_smg1", Name = "SMG", Price = 2500, Ammo = 500, AmmoClass = "SMG1", Damage = 5, DonatorOnly = false}
Weapons[10] = {Model = "models/weapons/w_irifle.mdl", Group = 1, Class = "weapon_ar2", Name = "AR2", Price = 7500, Ammo = 1000, AmmoClass = "AR2", Damage = 8, DonatorOnly = false}
Weapons[11] = {Model = "models/weapons/w_Physics.mdl",Group=1,Class='weapon_physcannon',Name="Pusher",Price=1500,Ammo=0,AmmoClass="",Damage=-0.1}
Weapons[12] = {Model = "models/weapons/w_stunbaton.mdl",Group=3,Class='weapon_stunstick',Name="Super stick",Price=0,Ammo=0,AmmoClass="",DevOnly=true}
Weapons[13] = {Model = "models/Gibs/HGIBS.mdl",Group=1,Class="weapon_fists",Name='Fist',Price=0,Ammo=0,AmmoClass="",Damage=6}
if(istable(weapons.Get('weapon_xdefm_rod')))then
  Weapons[#Weapons+1]={description="Model from oc_diving_v9 huh?",Model="models/oc_diving/rod.mdl",Group=2,Class="weapon_xdefm_rod",Name="Fishing rod",Price=-1,Ammo=0,AmmoClass="",Damage=0}
  Weapons[#Weapons+1]={description="THE INVENTORY",Model="models/weapons/w_package.mdl",Group=2,Class="weapon_xdefm_inventory",Name="Fishing Inventory",Price=-5,Ammo=0,AmmoClass="",Damage=0}
  Weapons[#Weapons+1]={description="LETS GO TRADE!",Model="models/weapons/w_suitcase_passenger.mdl",Group=2,Class="weapon_xdefm_trade",Name="Fishing Trace",Price=-10,Ammo=0,AmmoClass="",Damage=0}
end
GM:AddProp({Model="models/props_c17/FurnitureDrawer001a.mdl",Group=3,Description="Furniture Drawer",Health=40,Price=0})
GM:AddProp({Model="models/Items/item_item_crate.mdl",Group=3,Description="BOX",Health=25,Price=0})
GM:AddProp({Model="models/props_junk/watermelon01.mdl",Group=3,Description="MELON",Health=50,Price=0})
GM:AddProp({Model="models/props_trainstation/trainstation_ornament002.mdl",Health=80,Group=3,Description="I dont know",Price=0,rdescription="You think this is a tesla tower?"})
GM:AddProp({Model="models/props_phx/construct/wood/wood_panel1x1.mdl",Group=3,Description="Wooden panel.",Price=0,Health=35})
