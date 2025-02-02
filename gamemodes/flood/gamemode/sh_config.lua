--Unused until mass update
FM_ShouldOverrideGameDescription=false
FM_GetGameDescription="Flood 2.2"
--FM_FallDamageType=0
function GM:GetGameDescription()
  return FM_ShouldOverrideGameDescription and FM_GetGameDescription or ""
end
