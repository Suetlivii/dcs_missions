local red_cap_chance = 0.65
local red_gci_chance = 0.85

if ME_isDebugMode == true then
    red_cap_chance = 1.0
    red_gci_chance = 1.0
end

-- in minutes
local red_cap_interval_min = 20 * 60
local red_cap_interval_max = 40 * 60

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

    redA2ADispatcher:SetEngageRadius( 80000 )
    redA2ADispatcher:SetGciRadius( 150000 )
    redA2ADispatcher:SetDisengageRadius(180000)
    redA2ADispatcher:SetTacticalDisplay( ME_isDebugMode )
    local redA2ACapZone = ZONE:New("red_cap_zone_palmyra")

    --https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    redA2ADispatcher:SetSquadron( "mig29_palmyra", AIRBASE.Syria.Palmyra, { "cap_mig29_palmyra" }, 6 )
    redA2ADispatcher:SetSquadronTakeoffFromParkingCold( "mig29_palmyra" )
    redA2ADispatcher:SetSquadronLandingAtRunway( "mig29_palmyra" )
    redA2ADispatcher:SetSquadronFuelThreshold( "mig29_palmyra", 0.30 )
    redA2ADispatcher:SetSquadronGrouping( "mig29_palmyra", 2 )
    redA2ADispatcher:SetSquadronOverhead( "mig29_palmyra", 1 )

    if math.random() <= red_gci_chance then
        redA2ADispatcher:SetSquadronGci( "mig29_palmyra", 750, 1100 )
    end

    if math.random() <= red_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        redA2ADispatcher:SetSquadronCap( "mig29_palmyra", redA2ACapZone, 5000, 9000, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        redA2ADispatcher:SetSquadronCapInterval( "mig29_palmyra", 2, red_cap_interval_min, red_cap_interval_max, 1 )
    end
end