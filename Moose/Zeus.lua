function spv(groupName, coord)
    group = SPAWN:New(groupName)
    group:SpawnFromVec2(coord:GetVec2())
end

function handleSpawnRequest(text, coord)

if text:find("groupnamehere") then
    spv("groupnamehere", coord)
    trigger.action.outText("UNIT on your MAP MARKER succesfully CREATED.", 10)

    end
end

function handleDebugRequest(text, coord)

end

local destroyZoneCount = 0
function handleDestroyRequest(text, coord)
    local destroyZoneName = string.format("destroy %d", destroyZoneCount)
    local zoneRadiusToDestroy = ZONE_RADIUS:New(destroyZoneName, coord:GetVec2(), 1000)
    destroyZoneCount = destroyZoneCount + 1
    trigger.action.outText("UNIT(S) on your MAP MARKER succesfully DESTROYED.", 10)
    local function destroyUnit(unit)
        unit:Destroy()
        return true
    end

    zoneRadiusToDestroy:SearchZone( destroyUnit , Object.Category.UNIT)
end

function markRemoved(Event)
    if Event.text~=nil and Event.text:lower():find("-") then 
        local text = Event.text:lower()
        local vec3 = {y=Event.pos.y, x=Event.pos.z, z=Event.pos.x}
        local coord = COORDINATE:NewFromVec3(vec3)
        coord.y = coord:GetLandHeight()

        if Event.text:lower():find("-create") then
            handleSpawnRequest(text, coord)
        elseif Event.text:lower():find("-debug") then
            handleDebugRequest(text, coord) 
        elseif Event.text:lower():find("-destroy") then
            handleDestroyRequest(text, coord)
        end
    end
end

function SupportHandler:onEvent(Event)
    if Event.id == world.event.S_EVENT_MARK_ADDED then

    elseif Event.id == world.event.S_EVENT_MARK_CHANGE then

    elseif Event.id == world.event.S_EVENT_MARK_REMOVED then
         markRemoved(Event)
    end
end

world.addEventHandler(SupportHandler)