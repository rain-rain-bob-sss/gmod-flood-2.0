--Unused until mass update
FM_ShouldOverrideGameDescription=false
--FM_GetGameDescription="Flood 2.2"
--FM_FallDamageType=0
function GM:GetGameDescription()
  return "Flood 2.2 By [TW]Rain_bob" and FM_ShouldOverrideGameDescription or ""
end
