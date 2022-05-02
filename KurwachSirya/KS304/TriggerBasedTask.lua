TaskConfig = 
{
    name = "CommonTask",
    groupsPrefixes = { "Prefix1", "Prefix2" },
    coalition = 1,
    startTrigger = "101",
    goodEndTrigger = "102",
    badEndTrigeer = "103",
    cancelTrigger = "104",
    startMsgFriendly = "This is friendly start message",
    startMsgEnemy = "This is enemy start message",
    goodEndMsgFriendly = "This is good end message for friendly coalition",
    goodEndMsgEnemy = "This is good end message for enemy coalition",
    badEndMsgFriendly = "This is bad end message for friendly",
    badEndMsgEnemy = "This is bad end message for enemy",
    cancelEndMsgFriendly = "This is cancel message for friendly",
    cancelEndMsgEnemy = "This is cancel message for enemy",
    briefMsgFriendly = "This is brief message for friendly",
    briefMsgEnemy = "This is brief message for enemy",
    markZoneName = "",
    markText = ""
}

------------------------------------------------------------------------------------------------------
-- TriggerBasedTask
-- Trigger based task is a controller that will turn on and catch DCS mission editor flags
-- All mission logic is made in DCS ME, this object will controll main flags (triggers) and report task
-- How to use: 
-- Create new object with taskConfig structure 
-- Then start task with StartTask() function
-- Add listener, when task ends it will call listener with OnTaskEnd(taskConfig, taskState)
-- TaskStates
-- 0 - not starter
-- 1 - active
-- 2 - goodEnd
-- 3 - badEnd
-- 4 - canceled

MESSAGE_TIME_ON_SCREEN = 45

TriggerBasedTask = {}

-- PUBLIC METHODS
-- New()
-- StartTask()
-- AddOnEndEventListener()

function TriggerBasedTask:New(_taskConfig)
    newObj = 
    {
        taskConfig = _taskConfig,
        markID = nil,
        onEndListeners = {},
        taskState = 0
    }
    self.__index = self
    return setmetatable(newObj, self)
end

function TriggerBasedTask:StartTask()
    Debug:Log("StartTask called, task name is " .. self.taskConfig.name)
    self.taskState = 1

    -- Setting brief message if brief msg is nill (will be start)
    if self.taskConfig.briefMsgFriendly == nil then
        self.taskConfig.briefMsgFriendly = self.taskConfig.startMsgFriendly
    end

    if self.taskConfig.briefMsgEnemy == nil then
        self.taskConfig.briefMsgEnemy = self.taskConfig.startMsgEnemy
    end

    -- Setting Start DCS ME Flag to ON
    local startUserFlag = USERFLAG:New(self.taskConfig.startTrigger)
    startUserFlag:Set(1)

    self:MessageToFriendlyCoalition(self.taskConfig.startMsgFriendly, MESSAGE_TIME_ON_SCREEN)
    self:MessageToEnemyCoalition(self.taskConfig.startMsgEnemy, MESSAGE_TIME_ON_SCREEN)

    -- Adding UserFlagCathers for 3 end conditions
    -- If flag is ON, this object will be called with proper method
    local goodEndEvent = UserFlagCather:New(self.taskConfig.goodEndTrigger, true)
    goodEndEvent:AddListener(self, "OnGoodEndTrigger")

    local badEndEvent = UserFlagCather:New(self.taskConfig.badEndTrigeer, true)
    badEndEvent:AddListener(self, "OnBadEndTrigger")

    local cancelEndEvent = UserFlagCather:New(self.taskConfig.cancelTrigger, true)
    cancelEndEvent:AddListener(self, "OnCancelEndTrigger")

    Debug:Log("StartTask end successfully, task name is " .. self.taskConfig.name)

    -- Creating new mark on map 
    self:CreateMark()

    return true
end

-- When task ended, it will call listener with OnTaskEnd(taskConfig, taskState)
function TriggerBasedTask:AddOnEndEventListener(object)
    table.insert( self.onEndListeners, object )
end

-- PRIVATE METHODS

-- MESSAGING TO PLAYERS
-- Message to group with name
function TriggerBasedTask:MessageToGroup(groupName, text, duration)
    local msgGroup = GROUP:FindByName( groupName )

    if msgGroup ~= nil and text ~= "" then
        local newMsg = MESSAGE:New(text, duration, nil, true):ToGroup(msgGroup)
    end
end

-- Messages to all groups with prefix with coalition
function TriggerBasedTask:MessageToGroupsWithPrefixWithCoalition(groupPrefix, coalition, text, duration)
    local coalName = self:GetCoalitionName(coalition)
    local groups = SET_GROUP:New():FilterPrefixes(groupPrefix):FilterCoalitions(coalName):FilterOnce()
    local groupsNames = groups:GetSetNames()
    for i, v in ipairs(groupsNames) do
        Debug:Log("TriggerBasedTask:MessageToGroupsWithPrefixWithCoalition(): Message to group " .. v)
        self:MessageToGroup( v, text, duration )
    end
end

-- Messge to all FRIENDLY groups (in the same coalition as task) and with prefixes
function TriggerBasedTask:MessageToFriendlyCoalition(text, duration)
    for i, v in ipairs(self.taskConfig.groupsPrefixes) do
        local coal = self.taskConfig.coalition
        self:MessageToGroupsWithPrefixWithCoalition(self.taskConfig.groupsPrefixes[i], coal, text, duration)
    end
end

-- Messge to all ENEMY groups (in the same coalition as task) and with prefixes
function TriggerBasedTask:MessageToEnemyCoalition(text, duration)
    for i, v in ipairs(self.taskConfig.groupsPrefixes) do
        local coal = self:ReverseCoalition(self.taskConfig.coalition)
        self:MessageToGroupsWithPrefixWithCoalition(self.taskConfig.groupsPrefixes[i], coal, text, duration)
    end
end

-- Brief message to group (coalition resolving automatically)
function TriggerBasedTask:BriefMessageToGroup(groupName, duration)
    local msgGroup = GROUP:FindByName( groupName )
    local groupCoal = msgGroup:GetCoalition()

    if self.taskState == 1 then 
        if self.taskConfig.coalition == groupCoal then
            self:MessageToGroup( groupName, self.taskConfig.briefMsgFriendly, duration )
        else
            self:MessageToGroup( groupName, self.taskConfig.briefMsgEnemy, duration )
        end
    end
end

-- TASK END LOGIC
-- EndTask() destroying mark and calling all onEnd liesteners
function TriggerBasedTask:EndTask()
    self:DestroyMark()
    for i, v in ipairs(self.onEndListeners) do
        v:OnTaskEnd(self.taskConfig, self.taskState)
    end
end

function TriggerBasedTask:OnGoodEndTrigger()
    if self.taskState ~= 1 then
        Debug:Log("LOGIC ERROR: OnGoodEndTrigger called with task state = " .. self.taskState .. " task name is " .. self.taskConfig.name)
        return 
    end

    Debug:Log("OnGoodEndTrigger called, task name is " .. self.taskConfig.name)
    self.taskState = 2
    self:MessageToFriendlyCoalition(self.taskConfig.goodEndMsgFriendly, MESSAGE_TIME_ON_SCREEN)
    self:MessageToEnemyCoalition(self.taskConfig.goodEndMsgEnemy, MESSAGE_TIME_ON_SCREEN)
    self:EndTask()
end

function TriggerBasedTask:OnBadEndTrigger()
    if self.taskState ~= 1 then
        Debug:Log("LOGIC ERROR: OnBadEndTrigger called with task state = " .. self.taskState .. " task name is " .. self.taskConfig.name)
        return 
    end

    Debug:Log("OnBadEndTrigger called, task name is " .. self.taskConfig.name)
    self.taskState = 3
    self:MessageToFriendlyCoalition(self.taskConfig.badEndMsgFriendly, MESSAGE_TIME_ON_SCREEN)
    self:MessageToEnemyCoalition(self.taskConfig.badEndMsgEnemy, MESSAGE_TIME_ON_SCREEN)
    self:EndTask()
end

function TriggerBasedTask:OnCancelEndTrigger()
    if self.taskState ~= 1 then
        Debug:Log("LOGIC ERROR: OnCancelEndTrigger called with task state = " .. self.taskState .. " task name is " .. self.taskConfig.name)
        return 
    end

    Debug:Log("OnCancelEndTrigger called, task name is " .. self.taskConfig.name)
    self.taskState = 4
    self:MessageToFriendlyCoalition(self.taskConfig.cancelEndMsgFriendly, MESSAGE_TIME_ON_SCREEN)
    self:MessageToEnemyCoalition(self.taskConfig.cancelEndMsgEnemy, MESSAGE_TIME_ON_SCREEN)
    self:EndTask()
end

-- MARKS LOGIC
-- Creating mark
function TriggerBasedTask:CreateMark()
    if self.taskConfig.markZoneName == nil or self.taskConfig.markZoneName == "" then 
        Debug:Log("TriggerBasedTask:CreateMark markZoneName is nill or empty, task name is " .. self.taskConfig.name)
        return nil
    end

    if self.taskConfig.markText == nil or self.taskConfig.markText == "" then 
        Debug:Log("TriggerBasedTask:CreateMark markText is nill or empty, task name is " .. self.taskConfig.name)
        return nil
    end

    local markZone = ZONE:FindByName(self.taskConfig.markZoneName)

    if markZone == nil then 
        Debug:Log("TriggerBasedTask:CreateMark zone not found, returning nil " .. self.taskConfig.name)
        return nil
    end

    local markZoneVec2 = markZone:GetVec2()
    local markZoneCoord = COORDINATE:NewFromVec2(markZoneVec2)
    local markID = markZoneCoord:MarkToCoalition(self.taskConfig.markText, self.taskConfig.coalition, true)
    self.markID = markID
end

-- Destroying mark
function TriggerBasedTask:DestroyMark()
    if self.markID ~= nil then 
        COORDINATE:RemoveMark(self.markID)
    end
end

-- UTILITY

--Reversing coalition, returning enemy coalition number
function TriggerBasedTask:ReverseCoalition(coalition)
    if coalition == 1 then 
        return 2 
    else
        return 1 
    end
end

-- Getting coalition of a group with group name
function TriggerBasedTask:GetCoalitionOfGroup(groupName)
    local group = GROUP:FindByName( groupName )
    return group:GetCoalition()
end

-- Getting coalition name
function TriggerBasedTask:GetCoalitionName(coalitionNum)
    local coals = { "red", "blue" }
    return coals[coalitionNum]
end

------------------------------------------------------------------------------------------------------

UserFlagCather = {}

function UserFlagCather:New(_userFlag, _isCallOnce)
    newObj = 
    {
        userFlag = _userFlag,
        isCallOnce = _isCallOnce,
        _flag = nil,
        _userFlagObj = nil,
        _objToCall = nil,
        _callFuncName = nil,
        _objArgs = nil,
        _sheduler = nil
    }
    self.__index = self
    return setmetatable(newObj, self)
end

function UserFlagCather:AddListener(object, funcName)
    self._objToCall = object
    self._callFuncName = funcName

    self._sheduler = SCHEDULER:New( nil, 
    function()
        self:Check()
    end, {}, 1, 1
    )
end

function UserFlagCather:Check()
    if self._userFlagObj == nil then
        self._userFlagObj = USERFLAG:New(self.userFlag)
    end

    if self._flag == nil then
        self._flag = self._userFlagObj:Get()
    end

    local newFlag = self._userFlagObj:Get()
    if self._flag ~= newFlag then
        self:Call(newFlag)
        self._flag = newFlag
    end

    if self._objToCall == nil then 
        self._sheduler = nil
        self = nil
    end
end

function UserFlagCather:Call(newValue)
    self._objToCall[self._callFuncName](self._objToCall)

    if self.isCallOnce == true then
        self._sheduler = nil
        self = nil
    end
end
