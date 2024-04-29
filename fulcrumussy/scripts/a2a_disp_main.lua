--BLUE
blue_cap_chance = 0.99
blue_gci_chance = 0.99

-- in seconds
blue_cap_interval_min = 5 * 60
blue_cap_interval_max = 15 * 60

if ME_isBlueCap == true then 
    BlueDetectionSetGroup = SET_GROUP:New()
    BlueDetectionSetGroup:FilterPrefixes( { "BLUE_EWR" } )
    BlueDetectionSetGroup:FilterStart()

    -- Setup the detection and group targets to a 30km range!
    BlueDetection = DETECTION_AREAS:New( BlueDetectionSetGroup, 10000 )

    -- Setup the A2A dispatcher, and initialize it.
    BlueA2ADispatcher = AI_A2A_DISPATCHER:New( BlueDetection )

    BlueA2ADispatcher:SetEngageRadius( 20000 )
    BlueA2ADispatcher:SetGciRadius( 70000 )
    BlueA2ADispatcher:SetDisengageRadius(74000)
    BlueA2ADispatcher:SetTacticalDisplay( ME_isDebugMode )
    BlueA2ACapZone = ZONE:New("blue_cap_zone")

    --https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    BlueA2ADispatcher:SetSquadron( "fsa_mig23", AIRBASE.Caucasus.Mineralnye_Vody, { "fsa_mig23" }, 20 )
    BlueA2ADispatcher:SetSquadronTakeoffFromParkingCold( "fsa_mig23" )
    BlueA2ADispatcher:SetSquadronLandingAtRunway( "fsa_mig23" )
    BlueA2ADispatcher:SetSquadronFuelThreshold( "fsa_mig23", 0.30 )
    BlueA2ADispatcher:SetSquadronGrouping( "fsa_mig23", 2 )
    BlueA2ADispatcher:SetSquadronOverhead( "fsa_mig23", 1 )

    if math.random() < blue_gci_chance then
        BlueA2ADispatcher:SetSquadronGci( "fsa_mig23", 750, 1100 )
    end

    if math.random() < blue_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        BlueA2ADispatcher:SetSquadronCap( "fsa_mig23", BlueA2ACapZone, 5000, 9000, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        BlueA2ADispatcher:SetSquadronCapInterval( "fsa_mig23", 1, blue_cap_interval_min, blue_cap_interval_max, 1 )
    end
end