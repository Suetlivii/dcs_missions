local red_cap_chance = 1.0

if ME_isDebugMode == true then
    red_cap_chance = 1.0
end

-- in minutes
local red_cap_interval_min = 5 * 60
local red_cap_interval_max = 10 * 60

if ME_isDebugMode == true then
    -- in minutes
    red_cap_interval_min = 1 * 60
    red_cap_interval_max = 1 * 60
end

if ME_isRedCap == true then
    local redDetectionSetGroup = SET_GROUP:New()
    redDetectionSetGroup:FilterPrefixes( { "EW_RED" } )
    redDetectionSetGroup:FilterStart()


    -- Setup the detection and group targets to a 30km range!
    local redDetection = DETECTION_AREAS:New( redDetectionSetGroup, 10000 )

    -- Setup the A2A dispatcher, and initialize it.
    local redA2ADispatcher = AI_A2A_DISPATCHER:New( redDetection )

    redA2ADispatcher:SetEngageRadius( 1 )
    redA2ADispatcher:SetDisengageRadius(180000)
    redA2ADispatcher:SetTacticalDisplay( ME_isDebugMode )
    local redA2ACapZone = ZONE:New("red_uav_zone")

    --https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    redA2ADispatcher:SetSquadron( "uav_wingloong_tabqa", AIRBASE.Syria.Tabqa, { "uav_wingloong" }, 15 )
    redA2ADispatcher:SetSquadronTakeoffFromParkingCold( "uav_wingloong_tabqa" )
    redA2ADispatcher:SetSquadronLandingAtRunway( "uav_wingloong_tabqa" )
    redA2ADispatcher:SetSquadronFuelThreshold( "uav_wingloong_tabqa", 0.30 )
    redA2ADispatcher:SetSquadronGrouping( "uav_wingloong_tabqa", 1 )
    redA2ADispatcher:SetSquadronOverhead( "uav_wingloong_tabqa", 1 )

    if math.random() <= red_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        redA2ADispatcher:SetSquadronCap( "uav_wingloong_tabqa", redA2ACapZone, 150, 300, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        redA2ADispatcher:SetSquadronCapInterval( "uav_wingloong_tabqa", 4, red_cap_interval_min, red_cap_interval_max, 1 )
    end
end