RandomGroupSpawner = {}

function RandomGroupSpawner:New(is_debug)
    newObj = 
    {
        _is_debug = is_debug or false,
        _random_route_waypoint_offset_m = 30000,
        _random_route_add_alt_m = 10000
    }
    self.__index = self
    return setmetatable(newObj, self)   
end

function RandomGroupSpawner:StartGroupNameParsing(group_prefix)
    if self._is_debug == true then 
        MESSAGE:New(tostring("Starting parsing groups with prefix "..group_prefix), 25, "DEBUG", false):ToAll()
    end
    local _group_prefix = group_prefix
    local groupsSet = SET_GROUP:New():FilterPrefixes(_group_prefix):FilterOnce()
    local groupSetNames = groupsSet:GetSetNames()

    for k, v in pairs(groupSetNames) do 
        if self._is_debug == true then 
            MESSAGE:New(tostring("Found group "..v), 25, "DEBUG", false):ToAll()
        end
        self:_parse_group_name_and_schedule(v)
    end
end

function RandomGroupSpawner:Activate(group_name, chance, min_time, max_time, randomize_route, set_trigger_on_activated)
    local _group_name = group_name
    local _chance = chance or 0.5
    local _min_time = min_time or 5
    local _max_time = max_time or 60
    local _randomize_route = randomize_route or false
    local _set_trigger_on_activated = set_trigger_on_activated or false
    if self._is_debug == true then 
        MESSAGE:New(tostring("_group_name=".._group_name.."\n_chance=".._chance.."\n_min_time=".._min_time.." _max_time=".._max_time.."\n_randomize_route="..tostring(_randomize_route)), 25, "DEBUG", false):ToAll()
    end

    -- randomize time in minutes
    local _randomized_time_seconds = math.random(_min_time*60, _max_time*60)
    if self._is_debug == true then 
        MESSAGE:New(tostring("_randomized_time_seconds = ".._randomized_time_seconds), 25, "DEBUG", false):ToAll()
    end

    -- check random chance for activation
    if math.random() <= _chance then
        if self._is_debug == true then 
            MESSAGE:New(tostring(_group_name.." will be spawned"), 25, "DEBUG", false):ToAll()
        end
        self:_activate_group_scheduled(_group_name, _randomized_time_seconds, _randomize_route, self._random_route_waypoint_offset_m, self._random_route_add_alt_m)
    end
end

function RandomGroupSpawner:SetRandomizedRouteOptions(waypoint_offset_km, route_add_alt_m)
    self._random_route_waypoint_offset_m = waypoint_offset_m or 30000
    self._random_route_add_alt_m = route_add_alt_m or 10000
end

function RandomGroupSpawner:_activate_group_scheduled(group_name, activation_time, randomize_route, route_offset_m, route_alt_m)
    local _spawned_vehicle = SPAWN:New(group_name):InitKeepUnitNames():InitLimit(100, 1)

    if randomize_route == true then 
        _spawned_vehicle:InitRandomizeRoute(0, 0, route_offset_m, route_alt_m)
    end

    _spawned_vehicle:SpawnScheduled(activation_time, 0, true)

    if self._is_debug == true then 
        MESSAGE:New(tostring("Activated group "..group_name), 25, "DEBUG", false):ToAll()
    end
end

function RandomGroupSpawner:_parse_group_name_and_schedule(group_name)
    local _group_name = tostring(group_name):lower()

    local _chance = "undef"
    local _time_min = "undef"
    local _time_max = "undef"
    local _route_offset_km= "undef"
    local _route_alt_km= "undef"

    if _group_name:find("chance") then
        _chance = tonumber(string.match(_group_name, "chance<(.-)>"))
    end

    if _group_name:find("time") then
        _time_min, _time_max = string.match(_group_name, "time<(.-)>"):match("([^,]+),([^,]+)")
        _time_min = tonumber(_time_min)
        _time_max = tonumber(_time_max)
    end

    if _group_name:find("route") then
        _route_offset_km, _route_alt_km = string.match(_group_name, "route<(.-)>"):match("([^,]+),([^,]+)")
        _route_offset_km = tonumber(_route_offset_km)
        _route_alt_km = tonumber(_route_alt_km)
    end

    if self._is_debug == true then 
        MESSAGE:New(tostring("For group "..group_name.." parsed data is:\n".." chance=".._chance.." time_min=".._time_min.." time_max=".._time_max.." route_offset_km=".._route_offset_km.." route_alt_km=".._route_alt_km), 25, "DEBUG", false):ToAll()
    end

    -- randomize time in minutes
    local _randomized_time_seconds = math.random(_time_min*60, _time_max*60)

    -- check random chance for activation
    if math.random() <= _chance then
        if self._is_debug == true then 
            MESSAGE:New(tostring(group_name.." will be spawned"), 25, "DEBUG", false):ToAll()
        end
        self:_activate_group_scheduled(group_name, _randomized_time_seconds, true, _route_offset_km*1000, _route_alt_km*1000)
    end
end