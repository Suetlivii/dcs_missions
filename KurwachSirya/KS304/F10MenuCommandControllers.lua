-- GroupF10CommandController
-- Used for group-based F-10 radio menu commands
-- Will be linked for this particular unit and will invoke OnCommand funtion for subscribed object
-- How to use:
-- Create new instance with groupname. This object will be linked for this unit
-- Then CreateMenuCommand() for this group
-- Then add listener(s) with AddListener()
-- Every time client using command, every listener will be called with OnCommand() with eventData 
-- EventData is groupName and commandName

GroupF10CommandController = {}

-- PUBLIC METHODS --
-- New()
-- CreateMenuCommand()
-- AddListener()

function GroupF10CommandController:New(_groupName)
    newObj = 
    {
        groupName = _groupName,
        menuCommandName = nil,
        menuCommandParent = nil,
        eventData = {},
        onCommandListeners = {}
    }
    self.__index = self
    return setmetatable(newObj, self)
end

-- Object that will be linked to the unit, and will catch units command
function GroupF10CommandController:CreateMenuCommand(_menuCommandParent, _menuCommandName)
    if _menuCommandName == nil then 
        return
    else
        self.menuCommandName = _menuCommandName
    end

    if _menuCommandParent ~= nil then
        self.menuCommandParent = _menuCommandParent
    end

    local function callFunc()
        self:Call()
    end

    local PlaneGroup = GROUP:FindByName( self.groupName )
    if PlaneGroup and PlaneGroup:IsAlive() then
        if self.menuCommandParent ~= nil then
            local MenuManage = MENU_GROUP:New( PlaneGroup, self.menuCommandParent )
            MENU_GROUP_COMMAND:New( PlaneGroup, self.menuCommandName, MenuManage, callFunc )
        else
            MENU_GROUP_COMMAND:New( PlaneGroup, self.menuCommandName, nil, callFunc )
        end
    end

    self.eventData.groupName = self.groupName
    self.eventData.commandName = _menuCommandName
end

-- Add listener object, object will be called with OnCommand(eventData)
function GroupF10CommandController:AddListener(_obj)
    table.insert( self.onCommandListeners, _obj )
end


-- PRIVATE METHODS
-- Call()
-- Function will be called when player using command
function GroupF10CommandController:Call()
    for i, v in ipairs(self.onCommandListeners) do
        v:OnCommand(self.eventData)
    end
end

------------------------------------------------------------------------------------------------------

-- GroupPrefixF10CommandController
-- Used for prefix-based F-10 commands
-- Will create GroupF10CommandController for each group with prefix
-- Then will catch command used by player if it's added with this controller
-- How to use:
-- Create new instance of object
-- Use AddMenuCommandForGroupsWithPrefix with prefix, commandParent and commandName
-- Add listeners, every listener will be called with OnCommand(eventData), where eventData is list [groupName, commandName]

GroupPrefixF10CommandController = {
    commandListeners = {},
    GroupF10CommandControllers = {},
    _sheduler = nil,
    alreadyInitializedGroups = {},
    _prefix = nil,
    _menuCommandParent = nil,
    _menuCommandName = nil,
    _isInit = false
}

-- PUBLIC METHODS
-- New()
-- AddMenuCommandForGroupsWithPrefix()
-- AddListener()

function GroupPrefixF10CommandController:New()
    local self = BASE:Inherit( self, BASE:New() ) -- #DATABASE

    self:HandleEvent( EVENTS.Birth, self._EventOnBirth )

    return self
end

function GroupPrefixF10CommandController:AddMenuCommandForGroupsWithPrefix(_prefix, _menuCommandParent, _menuCommandName)
    self._prefix = _prefix
    self._menuCommandParent = _menuCommandParent
    self._menuCommandName = _menuCommandName
    self._isInit = true
end

function GroupPrefixF10CommandController:AddListener(_object)
    table.insert( self.commandListeners, _object )
end

-- PRIVATE METHODS
-- OnEventBirth()
-- InitCommands()
-- OnCommand()

function GroupPrefixF10CommandController:OnEventBirth(EventData)
    if self._isInit == true then 
        self:InitCommands()
    end
end

function GroupPrefixF10CommandController:InitCommands()

    _prefix = self._prefix
    _menuCommandParent = self._menuCommandParent
    _menuCommandName = self._menuCommandName

    local setGroup = SET_GROUP:New()
    setGroup:FilterPrefixes( { _prefix } )
    setGroup:FilterStart()

    local set = setGroup:GetSetNames()

    for i, v in ipairs(set) do
        if self.alreadyInitializedGroups[v] ~= true then
            Debug:Log("GroupPrefixF10CommandController:AddMenuCommandForGroupsWithPrefix adding command for group named " .. v)
            local newController = GroupF10CommandController:New(v)
            newController:CreateMenuCommand(_menuCommandParent, _menuCommandName)
            newController:AddListener(self)
            table.insert( self.GroupF10CommandControllers, newController )
            table.insert( self.alreadyInitializedGroups, v )
            self.alreadyInitializedGroups[v] = true
        end
    end
end

function GroupPrefixF10CommandController:OnCommand(_eventData)
    Debug:Log("GroupPrefixF10CommandController:OnCommand, group name is " .. _eventData.groupName .. ", command name is " .. _eventData.commandName)
    for i, v in ipairs(self.commandListeners) do
        v:OnCommand(_eventData)
    end
end
