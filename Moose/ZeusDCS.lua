
isDebugMode = false

function PrintDebug(text)
    if isDebugMode == true then
        MESSAGE:NewType(tostring(text), MESSAGE.Type.Information ):ToAll()
    end
end

MarkRemovedEventHandler = EVENTHANDLER:New()

MarkRemovedEventHandler:HandleEvent(EVENTS.MarkRemoved)


function MarkRemovedEventHandler:OnEventMarkRemoved(EventData)

    PrintDebug(EventData.text)
    
    if EventData.text:lower():find("-create") then
        PrintDebug("Create found")
        local groupName = string.match(EventData.text, "*(%a+)*")
        PrintDebug(groupName)
        local vec3 = {y=EventData.pos.y, x=EventData.pos.z, z=EventData.pos.x}
        local coord = COORDINATE:NewFromVec3(vec3)
        SpawnGroupToCoord(groupName,coord)
    end 

end
 
local spawnedGroupsID = 0
local spawnGroups = {}
local spawnControllers = {}

function SpawnGroupToCoord(groupName, coord)

    if spawnControllers[groupName] == nil then
        spawnControllers[groupName] = SPAWN:New(groupName)
        PrintDebug("Added " .. groupName)
        PrintDebug(#spawnControllers)
    end
    
    if spawnControllers[groupName] ~= nil then
        spawnGroups.newKey = {spawnedGroupsID, nil}
        spawnGroups[spawnedGroupsID] = spawnControllers[groupName]:SpawnFromVec2(coord:GetVec2())
        spawnedGroupsID = spawnedGroupsID + 1
        PrintDebug(spawnedGroupsID)
    end

end
