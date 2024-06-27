local blue_cap_chance = 0.35
local blue_gci_chance = 0.75

if ME_isDebugMode == true then
    blue_cap_chance = 1.0
    blue_gci_chance = 1.0
end

-- in minutes
local blue_cap_interval_min = 20 * 60
local blue_cap_interval_max = 40 * 60

if ME_isDebugMode == true then
    -- in minutes
    blue_cap_interval_min = 1 * 60
    blue_cap_interval_max = 1 * 60
end

if ME_isBlueCap == true then 
    local BlueDetectionSetGroup = SET_GROUP:New()
    BlueDetectionSetGroup:FilterPrefixes( { "BLUE_EWR" } )
    BlueDetectionSetGroup:FilterStart()


    -- Setup the detection and group targets to a 30km range!
    local BlueDetection = DETECTION_AREAS:New( BlueDetectionSetGroup, 10000 )

    -- Setup the A2A dispatcher, and initialize it.
    local BlueA2ADispatcher = AI_A2A_DISPATCHER:New( BlueDetection )

    BlueA2ADispatcher:SetEngageRadius( 55000 )
    BlueA2ADispatcher:SetGciRadius( 100000 )
    BlueA2ADispatcher:SetDisengageRadius(140000)
    BlueA2ADispatcher:SetTacticalDisplay( ME_isDebugMode )
    local BlueA2ACapZone = ZONE:New("blue_cap_zone_mig23")

    --https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    BlueA2ADispatcher:SetSquadron( "fsa_mig23_1st", AIRBASE.Syria.Kuweires, { "fsa_mig23" }, 6 )
    BlueA2ADispatcher:SetSquadronTakeoffFromParkingCold( "fsa_mig23_1st" )
    BlueA2ADispatcher:SetSquadronLandingAtRunway( "fsa_mig23_1st" )
    BlueA2ADispatcher:SetSquadronFuelThreshold( "fsa_mig23_1st", 0.30 )
    BlueA2ADispatcher:SetSquadronGrouping( "fsa_mig23_1st", 2 )
    BlueA2ADispatcher:SetSquadronOverhead( "fsa_mig23_1st", 1 )

    if math.random() <= blue_gci_chance then
        BlueA2ADispatcher:SetSquadronGci( "fsa_mig23_1st", 750, 1100 )
    end

    if math.random() <= blue_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        BlueA2ADispatcher:SetSquadronCap( "fsa_mig23_1st", BlueA2ACapZone, 5000, 9000, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        BlueA2ADispatcher:SetSquadronCapInterval( "fsa_mig23_1st", 1, blue_cap_interval_min, blue_cap_interval_max, 1 )
    end
end