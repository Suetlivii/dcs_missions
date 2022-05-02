

local unitsTypeString = ""

local planes = ""
local helis = ""
local ships = ""
local airdef = ""
local arty = ""
local armor = ""
local inf = ""
local train = ""
local fort = ""

function SortTypesForGroupPrefix(_groupPrefix, _stringToWrite)
    
    local setGroup = SET_GROUP:New():FilterPrefixes(_groupPrefix):FilterOnce()
    local groupsList = setGroup:GetSetObjects()
    MESSAGE:New(tostring(#groupsList), 10, "DEBUG", false):ToAll()
    for i in ipairs(groupsList) do 
        SortGroup(groupsList[i], _stringToWrite)
    end

end

function SortGroup(_group, _stringToWrite)
    local units = _group:GetUnits()

    for k, v in pairs(units) do
        unitsTypeString = unitsTypeString .. v:GetTypeName() .. "\n"
        MESSAGE:New(tostring(v:GetTypeName()), 10, "DEBUG", false):ToAll()
    end
end

SortTypesForGroupPrefix("train", planes)

BASE:E(unitsTypeString)