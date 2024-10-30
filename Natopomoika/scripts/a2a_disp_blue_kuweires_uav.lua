local blue_cap_chance = 1.0

if ME_isDebugMode == true then
    blue_cap_chance = 1.0
    blue_gci_chance = 1.0
end

-- in minutes
local blue_cap_interval_min = 5 * 60
local blue_cap_interval_max = 10 * 60

if ME_isDebugMode == true then
    -- in minutes
    blue_cap_interval_min = 1 * 60
    blue_cap_interval_max = 1 * 60
end

if ME_isBlueCap == true then
    local blueDetectionSetGroup = SET_GROUP:New()
    blueDetectionSetGroup:FilterPrefixes( { "EW_BLUE" } )
    blueDetectionSetGroup:FilterStart()


    -- Setup the detection and group targets to a 30km range!
    local blueDetection = DETECTION_AREAS:New( blueDetectionSetGroup, 10000 )

    -- Setup the A2A dispatcher, and initialize it.
    local blueA2ADispatcher = AI_A2A_DISPATCHER:New( blueDetection )

    blueA2ADispatcher:SetEngageRadius( 1 )
    blueA2ADispatcher:SetDisengageRadius(250000)
    blueA2ADispatcher:SetTacticalDisplay( ME_isDebugMode )
    local blueA2ACapZone = ZONE:New("blue_uav_zone")

    --https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    blueA2ADispatcher:SetSquadron( "mq1_kuweires", AIRBASE.Syria.Kuweires, { "uav_mq1" }, 20 )
    blueA2ADispatcher:SetSquadronTakeoffFromParkingCold( "mq1_kuweires" )
    blueA2ADispatcher:SetSquadronLandingAtRunway( "mq1_kuweires" )
    blueA2ADispatcher:SetSquadronFuelThreshold( "mq1_kuweires", 0.30 )
    blueA2ADispatcher:SetSquadronGrouping( "mq1_kuweires", 1 )
    blueA2ADispatcher:SetSquadronOverhead( "mq1_kuweires", 1 )

    if math.random() <= blue_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        blueA2ADispatcher:SetSquadronCap( "mq1_kuweires", blueA2ACapZone, 150, 300, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        blueA2ADispatcher:SetSquadronCapInterval( "mq1_kuweires", 4, blue_cap_interval_min, blue_cap_interval_max, 1 )
    end
end