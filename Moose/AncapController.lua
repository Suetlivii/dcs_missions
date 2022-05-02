
isDebugMode = true

---print debug info about players at DCS
function PrintTableToDCS()

    for key, val in pairs(AncapPlayers) do
        
        messageString = val.nickname .. " " .. val.money .. " " .. val.destroedObjects
        MESSAGE:NewType(messageString , MESSAGE.Type.Information ):ToAll()
     
    end

end


---Get Players Unit
function GetPlayerUnit(_PlayerName)

  local PlayerUnits = _DATABASE:GetPlayerUnits()
  for PlayerName, PlayerUnit in pairs( PlayerUnits ) do
  
      if PlayerName == _PlayerName then return PlayerUnit end
  
  end

end

---
--- ObjectWithCost class definition
---
ObjectTypeWithCost = {}

function ObjectTypeWithCost:New(_name, _cost, _flightHourCost, _fuelCostPerKg, _internalFuelMax)
  newObj = 
  {
    name = _name,
    cost = _cost,
    flightHourCost = _flightHourCost,
    fuelCostPerKg = _fuelCostPerKg,
    internalFuelMax = _internalFuelMax
  }               
  self.__index = self                      
  return setmetatable(newObj, self) 
end
---End definition


---
---ObjectsWithCost struct definition
---
ObjectTypesWithCost =
{
    F18 = ObjectTypeWithCost:New("FA-18C_hornet", 50000000, 23500, 7, 4900),
    Su27 = ObjectTypeWithCost:New("Su-27", 40000000),
    Ural375 = ObjectTypeWithCost:New("Ural-375 PBU", 25000),
    
    
    Aim120C = ObjectTypeWithCost:New("Aim120 C-5", 500000),
    R27ER = ObjectTypeWithCost:New("R27ER", 185000),
    mk82 = ObjectTypeWithCost:New("weapons.bombs.Mk_82", 2345)
}

---Get UnitTypeData by TypeName
function GetObjectTypeWithCost(objectTypeName)

  for key, val in pairs(ObjectTypesWithCost) do 
     if val.name == objectTypeName then return val end     
  end

end


---find objectType cost by DCSUnitName
function GetObjectCostByDCSObjectName(DCSObjectName)
  for key, val in pairs(ObjectTypesWithCost) do
  
     if val.name == DCSObjectName then return val.cost end
      
  end
end
---end Objects With Cost list


---calculate fuel and per flight hour cost
function CalculateFuelAndFlightTimeCost(_timeSpanInSeconds, _fuelKg, _flightHourCost, _fuelCostPerKg)
      
    local flightCost = _timeSpanInSeconds * (_flightHourCost / 3600)
    local fuelCost = _fuelKg * _fuelCostPerKg
    
    local resultCost = flightCost + fuelCost
    
    if isDebugMode == true then 
        local messageString = "Calculate flight: timeSpanSec = " .. _timeSpanInSeconds .. " FuelKG = " .. _fuelKg .. " _flightHourCost = " .. _flightHourCost .. " _fuelCostPerKg " .. _fuelCostPerKg .. "\n"
        local secondMessage = "Flight cost = " .. flightCost .. " fuel Cost = " .. fuelCost .. " result cost = " .. resultCost
        MESSAGE:NewType(messageString, MESSAGE.Type.Information ):ToAll() 
    end
    
    return resultCost

end

---
---AncapPlayers money class
---
AncapPlayer = {}

function AncapPlayer:New(_Nickname, _money, _destroedObjects, _takeOffTimeInSeconds, _takeOffFuel)
newObj = 
  {
    nickname = _Nickname,
    money = _money,
    destroedObjects = "",
    takeOffTimeInSeconds = _takeOffTimeInSeconds,
    takeOffFuel = _takeOffFuel
  }               
  self.__index = self                      
  return setmetatable(newObj, self) 
end
---end def

---
---AncapPlayersList
---
AncapPlayers = 
{
  HofksTheDeadMan = AncapPlayer:New("HofksTheDeadMan", 22500),
  SilverTheCarrierInstructor = AncapPlayer:New("SilverTheCarrierInstructor", 54680)
}

---add new player to list
function AddAncapPlayerToList(ancapPlayerNickname, ancapPlayerMoney)
  
  if GetAncapPlayerByNickname(ancapPlayerNickname) == nil then 
      if ancapPlayerMoney ~= nil then
      AncapPlayers.newKey = AncapPlayer:New(ancapPlayerNickname, ancapPlayerMoney)
      else
      AncapPlayers.newKey = AncapPlayer:New(ancapPlayerNickname, 0)
      end
      
      if isDebugMode == true then 
          PrintTableToDCS()
      end
      
  end

end


---get player 
function GetAncapPlayerByNickname(playerNickname)
    for key, val in pairs(AncapPlayers) do
        if val.nickname == playerNickname then return val end
    end
end

---add money to player
function AddMoneyToAncapPlayerByNickname(playerNickname, moneyAdd)
    
    if moneyAdd == nil then moneyAdd = 0 end
    
    if GetAncapPlayerByNickname(playerNickname) ~= nil then 
        GetAncapPlayerByNickname(playerNickname).money = GetAncapPlayerByNickname(playerNickname).money + moneyAdd
        
       local messageString = "Added money " .. moneyAdd .. " to player " .. playerNickname .. " now player have " .. GetAncapPlayerByNickname(playerNickname).money
       if isDebugMode == true then 
           MESSAGE:NewType(messageString , MESSAGE.Type.Information ):ToAll() 
       end
    end 

end
---end AncapsList



---
---Unit Complex Hit Event
---
UnitLastHitEventData = {}

function UnitLastHitEventData:New(_hittedUnitID, _hittedUnitType, _hitIniciatorName, _hitWeaponType, _hitIniciatorNameUnitName)
  newObj = 
  {
      hittedUnitID = _hittedUnitID,
      hittedUnitType = _hittedUnitType,
      hitIniciatorName = _hitIniciatorName,
      hitWeaponType = _hitWeaponType,
      hitIniciatorNameUnitName = _hitIniciatorNameUnitName
  }               
  self.__index = self                      
  return setmetatable(newObj, self) 
end

---list with last hits
UnitLastHitsEventData = 
{
    testHit = UnitLastHitEventData:New("Unit #0eer01", "T55", "ZarThePirojok", "GBU-12", "Pilot #034ddd")
}


---get last hit of unit with ID
function GetUnitLastHitEventDataByHittedUnitID(_hittedUnitID)
    
    for key, val in pairs(UnitLastHitsEventData) do
        if val.hittedUnitID == _hittedUnitID then return val end   
    end
    
end

function RemoveUnitLastHitEventDataByHittedUnitID(_hittedUnitID)
    for key, val in pairs(UnitLastHitsEventData) do
        if val.hittedUnitID == _hittedUnitID then key = nil end   
    end
end


---add unit hit, replace old hit with new
function AddLastHitToHitsList(_hittedUnitID, _hittedUnitType, _hitIniciatorName, _hitWeaponType, _hitIniciatorNameUnitName)
    
    local tempHitEvent = GetUnitLastHitEventDataByHittedUnitID(_hittedUnitID)  
    
    if tempHitEvent ~= nil then 
        RemoveUnitLastHitEventDataByHittedUnitID(_hittedUnitID) 
    end
    
    UnitLastHitsEventData.newKey = UnitLastHitEventData:New(_hittedUnitID, _hittedUnitType, _hitIniciatorName, _hitWeaponType, _hitIniciatorNameUnitName)
    
end
---complex hit event end



---
---UNIT Functions
---
function GetUnitTypeByUnitID(_unitID)
    local findUnit = UNIT:FindByName(_unitID)
    local typeName
    
    if findUnit ~= nil then
        typeName = findUnit:GetTypeName()
        return typeName    
    else
        return nil
    end
end


---
---DCS Mission OnEvent functions
---

function OnEventPlayerEnter(ancapPlayerNickname, ancapPlayerMoney)
    AddAncapPlayerToList(ancapPlayerNickname, ancapPlayerMoney)
end

function OnEventShotTakeMoneyFromAncapPlayer(_iniciatorName, _weaponType)

    local weaponCost = GetObjectCostByDCSObjectName(_weaponType)
    
    if weaponCost ~= nil then 
        AddMoneyToAncapPlayerByNickname(_iniciatorName, -weaponCost)
    end
    
end


function OnEventHitRegisterNewHit(_hittedUnitID, _hittedUnitType, _hitIniciatorName, _hitWeaponType, _hitIniciatorNameUnitName)

    AddLastHitToHitsList(_hittedUnitID, _hittedUnitType, _hitIniciatorName, _hitWeaponType, _hitIniciatorNameUnitName)

end

function OnEventDeadAddMoneyToAncapPlayer(_deadUnitID)
    
    local lastHitOfUnit = GetUnitLastHitEventDataByHittedUnitID(_deadUnitID)
        
    if lastHitOfUnit ~= nil then
    
        local coalitionMultiplier = 1
    
        local AncapPlayerUnit = UNIT:FindByName(lastHitOfUnit.hitIniciatorNameUnitName)
        local DeadUnit = UNIT:FindByName(lastHitOfUnit.hittedUnitID)
    
        if isDebugMode == true then 
            local messageString = "Killer unit is " .. AncapPlayerUnit:GetName() .. " coalition is " .. AncapPlayerUnit:GetCoalitionName() .. "\n" .. "Dead unit is " .. DeadUnit:GetName() .. " coalition is " .. DeadUnit:GetCoalitionName()
           
            MESSAGE:NewType(messageString, MESSAGE.Type.Information ):ToAll() 
        end
    
        if AncapPlayerUnit:GetCoalitionName() == DeadUnit:GetCoalitionName() then coalitionMultiplier = -1 end
    
        AddMoneyToAncapPlayerByNickname(lastHitOfUnit.hitIniciatorName, coalitionMultiplier * GetObjectCostByDCSObjectName(lastHitOfUnit.hittedUnitType))
    end
    
    RemoveUnitLastHitEventDataByHittedUnitID(_deadUnitID)
    
end


function OnEventTakeOffSaveFuelAndTime(_playerNickname)
    
    BASE:T("Base T")
    local player = GetAncapPlayerByNickname(_playerNickname)
    local playerUnit = GetPlayerUnit(_playerNickname)
    
    if player ~= nil then
        player.takeOffTimeInSeconds = timer.getTime()
        player.takeOffFuel = playerUnit:GetFuel()
        
        if isDebugMode == true then 
            local messageString = "Player took off, fuel = " .. player.takeOffFuel .. " time = " .. player.takeOffTimeInSeconds 
            MESSAGE:NewType(messageString, MESSAGE.Type.Information ):ToAll() 
        end
        
    end
    
end


function OnEventLandCalculateFuelAndFlightCostForAncapPlayer(_playerNickname, _playerUnitType)

    local player = GetAncapPlayerByNickname(_playerNickname)
    local playerUnit = GetPlayerUnit(_playerNickname)
    
    local playerUnitType = GetObjectTypeWithCost(_playerUnitType)
    
    local timeSpanSeconds = timer.getTime() - player.takeOffTimeInSeconds
    local fuelDelta = (player.takeOffFuel - playerUnit:GetFuel()) * player.internalFuelMax
    
    local finalCost = CalculateFuelAndFlightTimeCost(timeSpanSeconds, fuelDelta, playerUnitType.flightHourCost, playerUnitType.fuelCostPerKg)
    
    if isDebugMode == true then 
        local messageString = "Player land, flight calculator started" 
        MESSAGE:NewType(messageString, MESSAGE.Type.Information ):ToAll() 
    end

end

---end DCS Mission OnEvent functions



---
---DCS Event Handlers
---
--
--EventData - IniUnitName, IniPlayerName, WeaponName, IniTypeName, TgtTypeName, 
--

PlayerEnterUnitEventHandler = EVENTHANDLER:New()
PlayerCrashEventHandler = EVENTHANDLER:New()
ShotEventHandler = EVENTHANDLER:New()
HitEventHandler = EVENTHANDLER:New()
DeadEventHandler = EVENTHANDLER:New()
PlayerTakeoff = EVENTHANDLER:New()
PlayerLand = EVENTHANDLER:New()

PlayerEnterUnitEventHandler:HandleEvent(EVENTS.PlayerEnterUnit)
PlayerCrashEventHandler:HandleEvent(EVENTS.Crash)
ShotEventHandler:HandleEvent(EVENTS.Shot)
HitEventHandler:HandleEvent(EVENTS.Hit)
DeadEventHandler:HandleEvent(EVENTS.Dead)
PlayerTakeoff:HandleEvent(EVENTS.Takeoff)
PlayerLand:HandleEvent(EVENTS.Land)

function PlayerCrashEventHandler:OnEventCrash(EventData)

    if isDebugMode == true then 
       MESSAGE:NewType("Crash event invoke" , MESSAGE.Type.Information ):ToAll() 
    end

    if EventData.IniPlayerName ~= nil then 
    
        if isDebugMode == true then 
            local messageString = "Player " .. EventData.IniPlayerName .. " crashed his plane " .. EventData.IniTypeName
            MESSAGE:NewType(messageString , MESSAGE.Type.Information ):ToAll() 
        end
    
        AddMoneyToAncapPlayerByNickname(EventData.IniPlayerName, -GetObjectCostByDCSObjectName(EventData.IniTypeName))
    
    end

end

function PlayerEnterUnitEventHandler:OnEventPlayerEnterUnit(EventData)
    
    if EventData.IniPlayerName ~= nil then 
        OnEventPlayerEnter(EventData.IniPlayerName, 0)
        
        local messageString = "Player " .. EventData.IniPlayerName .. " entered unit"
        if isDebugMode == true then MESSAGE:NewType(messageString , MESSAGE.Type.Information ):ToAll() end
     end
    
end

function ShotEventHandler:OnEventShot(EventData)

    if EventData.IniPlayerName ~= nil then
       OnEventShotTakeMoneyFromAncapPlayer(EventData.IniPlayerName, EventData.WeaponName)
   
       local messageString = "Player " .. EventData.IniPlayerName .. " shot the " .. EventData.WeaponName
       if isDebugMode == true then 
           MESSAGE:NewType(messageString , MESSAGE.Type.Information ):ToAll() 
       end
    end

end


function HitEventHandler:OnEventHit( EventData )
    OnEventHitRegisterNewHit(EventData.TgtUnitName, EventData.TgtTypeName, EventData.IniPlayerName, EventData.WeaponName, EventData.IniUnitName)
    
    local messageString = "Player " .. EventData.IniPlayerName .. " hit the unit " .. EventData.TgtUnitName .. " of type " .. EventData.TgtTypeName .. " with weapon " .. EventData.WeaponName
    if isDebugMode == true then  MESSAGE:NewType(messageString , MESSAGE.Type.Information ):ToAll() end

end


function DeadEventHandler:OnEventDead(EventData)
    OnEventDeadAddMoneyToAncapPlayer(EventData.IniUnitName)
    
    local messageString = "Unit " .. EventData.IniUnitName .. " died"
    if isDebugMode == true then  MESSAGE:NewType(messageString , MESSAGE.Type.Information ):ToAll() end

end


function PlayerTakeoff:OnEventTakeoff(EventData)

    if isDebugMode == true then  
        local messageString = "Takeoff event Invoke! PlayerName = " .. EventData.IniPlayerName
        MESSAGE:NewType(messageString, MESSAGE.Type.Information ):ToAll() 
    end

    OnEventTakeOffSaveFuelAndTime(EventData.IniPlayerName)

end



---End DCS Events Handler



---
---Test
---
function SimpleTest()
AddAncapPlayerToList("PiksTheSunShine", 18900)
AddMoneyToAncapPlayerByNickname("PiksTheSunShine", 1000)
printName = "PiksTheSunShine Money = " .. GetAncapPlayerByNickname("PiksTheSunShine").money
print(printName)

AddLastHitToHitsList(5, "BubsTheFlankerFag", "FAB500")
lastTestHit = GetUnitLastHitEventDataByHittedUnitID(5)
print("Last Hit Of Unit With UnitID = 5 is done by weapon " .. lastTestHit.hitWeaponType)
AddLastHitToHitsList(5, "OctoCatTheRespected", "AGM-65G")
lastTestHit = GetUnitLastHitEventDataByHittedUnitID(5)
print("Last Hit Of Unit With UnitID = 5 is done by weapon " .. lastTestHit.hitWeaponType)


AddAncapPlayerToList("EinTheBoss", 6000)
UnitLastHitsEventData.newKey = UnitLastHitEventData:New("Unit #056", "Ural-375", nil, nil, nil)
OnEventShotTakeMoneyFromAncapPlayer("EinTheBoss", "R27ER")
OnEventHitRegisterNewHit("Unit #056", "EinTheBoss", "R27ER")
OnEventDeadAddMoneyToAncapPlayer("Unit #056")

EinPlayer = GetAncapPlayerByNickname("EinTheBoss")
print("Ein Name is " .. GetAncapPlayerByNickname("EinTheBoss").nickname .. ", Ein money is " .. GetAncapPlayerByNickname("EinTheBoss").money)
end
---end Tests


--SimpleTest()