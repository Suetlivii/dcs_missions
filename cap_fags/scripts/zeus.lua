-----------------------------------------------------------------------------------------------------------------------------------------------
-- FAKE_ZONE
--
-----------------------------------------------------------------------------------------------------------------------------------------------
FakeZone = {}

function FakeZone:New(vec3_pos)
    newObj = 
    {
        ClassName = "ZONE", 
        _vec3_pos = vec3_pos
    }
    self.__index = self
    return setmetatable(newObj, self)   
end

function FakeZone:GetRandomPointVec3()
    return self._vec3_pos
end

function FakeZone:GetCoordinate()
    return self._vec3_pos
end
-----------------------------------------------------------------------------------------------------------------------------------------------
-- MarkCommandController
--
-----------------------------------------------------------------------------------------------------------------------------------------------

MarkCommandController = {}

function MarkCommandController:New()
    newObj = 
    {
        spawners = {}, 
        count = 1
    }
    self.__index = self
    return setmetatable(newObj, self)   
end

function MarkCommandController:SetExplosion()
    local MarkRemovedEventHandler = EVENTHANDLER:New()
    MarkRemovedEventHandler:HandleEvent(EVENTS.MarkRemoved)
    function MarkRemovedEventHandler:OnEventMarkRemoved(EventData)
        if EventData.text:lower():find("-exp") then
            local markText = string.match(EventData.text, "-exp<(.-)>")
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):Explosion(tonumber(markText))
        end 
    end
end

function MarkCommandController:SetSpawn()
    local count = self.count
    local MarkRemovedEventHandler = EVENTHANDLER:New()
    MarkRemovedEventHandler:HandleEvent(EVENTS.MarkRemoved)
    function MarkRemovedEventHandler:OnEventMarkRemoved(EventData)
        if EventData.text:lower():find("-spawn") then
            local markText = string.match(EventData.text, "-spawn<(.-)>")
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3)
            if GROUP:FindByName(tostring(markText)) ~= nil then 
                SPAWN:NewWithAlias(tostring(markText), tostring(markText .. "-" .. count)):SpawnFromVec2(coord:GetVec2())
                count = count + 1
            end
        end 
    end
end

function MarkCommandController:SetSmoke()
    local MarkRemovedEventHandler = EVENTHANDLER:New()
    MarkRemovedEventHandler:HandleEvent(EVENTS.MarkRemoved)
    function MarkRemovedEventHandler:OnEventMarkRemoved(EventData)
        MESSAGE:New(tostring("SetSmoke: event detected"), 10, "DEBUG", false):ToAll()
        if EventData.text:lower():find("-smoke_w") then
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):SmokeWhite()
            MESSAGE:New(tostring("SetSmoke: white smoke"), 10, "DEBUG", false):ToAll()
        end 

        if EventData.text:lower():find("-smoke_r") then
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):SmokeRed()
            MESSAGE:New(tostring("SetSmoke: red smoke"), 10, "DEBUG", false):ToAll()
        end 

        if EventData.text:lower():find("-smoke_g") then
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):SmokeGreen()
            MESSAGE:New(tostring("SetSmoke: green smoke"), 10, "DEBUG", false):ToAll()
        end 

        if EventData.text:lower():find("-smoke_o") then
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):SmokeOrange()
            MESSAGE:New(tostring("SetSmoke: orange smoke"), 10, "DEBUG", false):ToAll()
        end 
    end
end

function MarkCommandController:SetIllum()
    local MarkRemovedEventHandler = EVENTHANDLER:New()
    MarkRemovedEventHandler:HandleEvent(EVENTS.MarkRemoved)
    function MarkRemovedEventHandler:OnEventMarkRemoved(EventData)
        MESSAGE:New(tostring("SetIllum: event detected"), 10, "DEBUG", false):ToAll()
        if EventData.text:lower():find("-illum") then
            local random_alt = math.random(450, 650)
            local vec3 = {y=(EventData.pos.y + random_alt), x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):IlluminationBomb(1500, 1)
            MESSAGE:New(tostring("SetIllum: illum spawned"), 10, "DEBUG", false):ToAll()
        end 
    end
end

function MarkCommandController:SetCSARBlue()
    local MarkRemovedEventHandler = EVENTHANDLER:New()
    MarkRemovedEventHandler:HandleEvent(EVENTS.MarkRemoved)
    function MarkRemovedEventHandler:OnEventMarkRemoved(EventData)
        if EventData.text:lower():find("-csar_b") then
            local markText = string.match(EventData.text, "-csar_b<(.-)>")
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local vec2 = {x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3)
            local spawn_zone = ZONE_RADIUS:New("csar_b_zone_" .. markText, vec3, 10, false)
            my_csar_blue:SpawnCSARAtZone(spawn_zone, coalition.side.BLUE, "CSAR", true, false, markText)
        end 
    end
end

function MarkCommandController:SetCSARRed()
    local MarkRemovedEventHandler = EVENTHANDLER:New()
    MarkRemovedEventHandler:HandleEvent(EVENTS.MarkRemoved)
    function MarkRemovedEventHandler:OnEventMarkRemoved(EventData)
        MESSAGE:New(tostring("SetCSARRed: event detected"), 10, "DEBUG", false):ToAll()
        if EventData.text:lower():find("-csar_r") then
            local markText = string.match(EventData.text, "-csar_r<(.-)>")
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local vec2 = {x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3)
            -- spawn_zone = ZONE_RADIUS:New("csar_r_zone_" .. markText, vec3, 10, false)
            local fake_zone = FakeZone:New(vec3)
            my_csar_red:SpawnCSARAtZone(fake_zone, coalition.side.RED, "CSAR", true, false, markText)
            MESSAGE:New(tostring("SetCSARRed: red csar spawned"), 10, "DEBUG", false):ToAll()
        end 
    end
end

mark_controller = MarkCommandController:New()
mark_controller:SetSpawn()
mark_controller:SetExplosion()
mark_controller:SetSmoke()
mark_controller:SetIllum()
mark_controller:SetCSARRed()
-----------------------------------------------------------------------------------------------------------------------------------------------