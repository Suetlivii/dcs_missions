------------------------------------------------------------------------------------------------------------------------------------------------
-- MapMark
--
------------------------------------------------------------------------------------------------------------------------------------------------
MapMark = {}

function MapMark:New()
    newObj = 
    {
        markCoalition = nil,
        markID = nil,
        destroyGroup = nil
    }
    self.__index = self
    return setmetatable(newObj, self)
end

function MapMark:CreateMark(_coalition, _textString, _vec2Coords)
    if _coalition ~= nil and _textString ~= nil and _vec2Coords ~= nil then

        if _coalition == coalition.side.RED then 
            local markID = _vec2Coords:MarkToCoalitionRed( _textString, true)
            self.markID = markID
        end

        if _coalition == coalition.side.BLUE then 
            local markID = _vec2Coords:MarkToCoalitionBlue( _textString, true)
            self.markID = markID
        end

    end
end

function MapMark:Destroy()
    if self.markID ~= nil then 
        COORDINATE:RemoveMark(self.markID)
    end
end

function MapMark:SetDestroyGroup(_group)
    _group:HandleEvent(EVENTS.Dead)
    function _group:OnEventDead( EventData )
        self:Destroy()
    end
end
------------------------------------------------------------------------------------------------------------------------------------------------

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
    MarkRemovedEventHandler = EVENTHANDLER:New()
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
    MarkRemovedEventHandler = EVENTHANDLER:New()
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
    MarkRemovedEventHandler = EVENTHANDLER:New()
    MarkRemovedEventHandler:HandleEvent(EVENTS.MarkRemoved)
    function MarkRemovedEventHandler:OnEventMarkRemoved(EventData)
        if EventData.text:lower():find("-smoke_w") then
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):SmokeWhite()
        end 

        if EventData.text:lower():find("-smoke_r") then
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):SmokeRed()
        end 

        if EventData.text:lower():find("-smoke_g") then
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):SmokeGreen()
        end 

        if EventData.text:lower():find("-smoke_o") then
            local vec3 = {y=EventData.pos.y, x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):SmokeOrange()
        end 
    end
end

function MarkCommandController:SetIllum()
    MarkRemovedEventHandler = EVENTHANDLER:New()
    MarkRemovedEventHandler:HandleEvent(EVENTS.MarkRemoved)
    function MarkRemovedEventHandler:OnEventMarkRemoved(EventData)
        if EventData.text:lower():find("-illum") then
            local random_alt = math.random(450, 650)
            local vec3 = {y=(EventData.pos.y + random_alt), x=EventData.pos.x, z=EventData.pos.z}
            local coord = COORDINATE:NewFromVec3(vec3):IlluminationBomb(1500, 1)
        end 
    end
end


mark_controller = MarkCommandController:New()
mark_controller:SetSpawn()
mark_controller:SetExplosion()
mark_controller:SetSmoke()
mark_controller:SetIllum()
-----------------------------------------------------------------------------------------------------------------------------------------------