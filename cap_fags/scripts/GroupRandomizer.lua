GroupRandomizer = {
        _percentKillWord = nil,
        _unitCountKillWord = nil,
        eventHandler = nil,
        _alreadyFoundGroupsNames = {},
        _isInit = false,
        _isStarted = false
}

function GroupRandomizer:New()
    local self = BASE:Inherit( self, BASE:New() ) -- #DATABASE
    return self
end

function GroupRandomizer:SetKeyWords(_percentKillWord, _unitCountKillWord)
    self._percentKillWord = _percentKillWord
    self._unitCountKillWord = _unitCountKillWord
    self._isInit = true
end

function GroupRandomizer:RandomizeOnce(_isActiveOnly)
    local groupsSet = SET_GROUP:New():FilterActive(_isActiveOnly):FilterOnce()
    local groupSetNames = groupsSet:GetSetNames()

    for k, v in pairs(groupSetNames) do 
        local eventData = {}
        eventData['IniDCSGroupName'] = v
        Debug:Log("GroupRandomizer:RandomizeOnce: trying to randomize group with name " .. eventData.IniDCSGroupName)
        self:OnBirth(eventData)
    end
end

function GroupRandomizer:Start()
    self:HandleEvent( EVENTS.Birth, self._EventOnBirth )
    self._isStarted = true
    Debug:Log("GroupRandomizer:Start started")
end

function GroupRandomizer:OnEventBirth(EventData)
    if self._isInit == true and self._isStarted == true then
        self:OnBirth(EventData)
    end
end

function GroupRandomizer:OnBirth(EventData)
    local percentKillWord = self._percentKillWord .. "<(.-)>"
    local percent = string.match(EventData.IniDCSGroupName, percentKillWord)

    local countKillWord = self._unitCountKillWord .. "<(.-)>"
    local killCount = string.match(EventData.IniDCSGroupName, countKillWord)

    if percent ~= nil then 
        self:KillPercent(EventData.IniDCSGroupName, tonumber(percent))
    end

    if killCount ~= nil then 
        self:KillUnits(EventData.IniDCSGroupName, tonumber(killCount))
    end
end

function GroupRandomizer:KillPercent(_groupName, _percent)
    _percent = tonumber(_percent)
    if _percent <= 0 or _percent >= 1 then 
        return false
    end

    local groupName = _groupName
    local group = GROUP:FindByName(groupName)
    if group == nil then 
        return false
    end
    Debug:Log("GroupRandomizer:KillPercent found group with percent kill key word, group name is " .. groupName .. " percent is " .. _percent)

    local unitsList = group:GetUnits()

    local unitsToKill = #unitsList * _percent
    self:KillUnits(_groupName, unitsToKill)

end

function GroupRandomizer:FindValueInTable(_table, _value)
    for i, v in ipairs(_table) do 
        if v == _value then 
            return i
        end
    end
    return false
end

function GroupRandomizer:KillUnits(_groupName, _unitsCount)
    if self._alreadyFoundGroupsNames[_groupName] == true then 
        return false
    end

    _unitsCount = tonumber(_unitsCount)
     if _unitsCount <= 0 then 
        return false
    end
    _unitsCount = math.floor( _unitsCount )

    local groupName = _groupName
    local group = GROUP:FindByName(groupName)
    if group == nil then 
        return false
    end
    table.insert( self._alreadyFoundGroupsNames, groupName )
    self._alreadyFoundGroupsNames[groupName] = true
    Debug:Log("GroupRandomizer:Kill count is started for " .. groupName .. " alive units count is " .. _unitsCount )

    local unitsList = group:GetUnits()

    if #unitsList < 2 then 
        return false
    end

    if _unitsCount >= #unitsList + 1 then 
        return false
    end

    local unitsToKillKeys = {}
    for i = 1, #unitsList do 
        table.insert(unitsToKillKeys, i)
        unitsToKillKeys[i] = i
    end

    for i = 1, _unitsCount do 
        local rng = math.random( 1, #unitsToKillKeys )
        table.remove(unitsToKillKeys, rng)
    end

    for i = 1, #unitsList do 
        if self:FindValueInTable(unitsToKillKeys, i) == false then 
            unitsList[i]:Destroy()
        end
    end
end

