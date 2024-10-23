local blue_cap_chance = 1.0
local blue_gci_chance = 0.85

if ME_isDebugMode == true then
    blue_cap_chance = 1.0
    blue_gci_chance = 1.0
end

-- in minutes
local blue_cap_interval_min = 15 * 60
local blue_cap_interval_max = 40 * 60

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

    blueA2ADispatcher:SetEngageRadius( 80000 )
    blueA2ADispatcher:SetGciRadius( 180000 )
    blueA2ADispatcher:SetDisengageRadius(250000)
    blueA2ADispatcher:SetTacticalDisplay( ME_isDebugMode )
    local blueA2ACapZone = ZONE:New("blue_cap_zone")

    --https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    blueA2ADispatcher:SetSquadron( "viper_incirlik", AIRBASE.Syria.Incirlik, { "cap_viper" }, 12 )
    blueA2ADispatcher:SetSquadronTakeoffFromParkingCold( "viper_incirlik" )
    blueA2ADispatcher:SetSquadronLandingAtRunway( "viper_incirlik" )
    blueA2ADispatcher:SetSquadronFuelThreshold( "viper_incirlik", 0.30 )
    blueA2ADispatcher:SetSquadronGrouping( "viper_incirlik", 2 )
    blueA2ADispatcher:SetSquadronOverhead( "viper_incirlik", 1 )

    if math.random() <= blue_gci_chance then
        blueA2ADispatcher:SetSquadronGci( "viper_incirlik", 750, 1100 )
    end

    if math.random() <= blue_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        blueA2ADispatcher:SetSquadronCap( "viper_incirlik", blueA2ACapZone, 5000, 9000, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        blueA2ADispatcher:SetSquadronCapInterval( "viper_incirlik", 2, blue_cap_interval_min, blue_cap_interval_max, 1 )
    end
end