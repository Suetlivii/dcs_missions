-- RED
red_cap_chance = 0.33
red_gci_chance = 0.21

-- from 0 to 100
red_overhead_min = 20
red_overhead_max = 60

-- in seconds
red_cap_interval_min = 12 * 60
red_cap_interval_max = 21 * 60

--BLUE
blue_cap_chance = 0.45
blue_gci_chance = 0.6

-- in seconds
blue_cap_interval_min = 12 * 60
blue_cap_interval_max = 21 * 60

if ME_isRedCap == true then
    RedDetectionSetGroup = SET_GROUP:New()
    RedDetectionSetGroup:FilterPrefixes( { "RED_EWR" } )
    RedDetectionSetGroup:FilterStart()

    -- Setup the detection and group targets to a 30km range!
    RedDetection = DETECTION_AREAS:New( RedDetectionSetGroup, 15000 )

    -- Setup the A2A dispatcher, and initialize it.
    RedA2ADispatcher = AI_A2A_DISPATCHER:New( RedDetection )

    RedA2ADispatcher:SetEngageRadius( 70000 )
    RedA2ADispatcher:SetGciRadius( 105000 )
    RedA2ADispatcher:SetDisengageRadius(110000)
    RedA2ADispatcher:SetTacticalDisplay( ME_isDebugMode )

    RedA2ACapZone = ZONE:New("red_cap_zone")

    -- Sayqal 17th Brigade 
    -- https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    RedA2ADispatcher:SetSquadron( "Sayqal_17th", AIRBASE.Syria.Sayqal, { "mig23_24r", "mig23_24t", "mig29_r60m", "mig29_r73", "mig29_r27er"}, 4 )
    RedA2ADispatcher:SetSquadronTakeoffFromParkingCold( "Sayqal_17th" )
    RedA2ADispatcher:SetSquadronLandingAtRunway( "Sayqal_17th" )
    RedA2ADispatcher:SetSquadronFuelThreshold( "Sayqal_17th", 0.30 )
    RedA2ADispatcher:SetSquadronGrouping( "Sayqal_17th", 2 )
    RedA2ADispatcher:SetSquadronOverhead( "Sayqal_17th", math.random(red_overhead_min, red_overhead_max)/100 )

    -- GCI random chance is 21%
    if math.random() < red_gci_chance then
        RedA2ADispatcher:SetSquadronGci( "Sayqal_17th", 750, 1100 )
    end

    -- CAP random chance is 30%
    if math.random() < red_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        RedA2ADispatcher:SetSquadronCap( "Sayqal_17th", RedA2ACapZone, 5000, 9000, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        RedA2ADispatcher:SetSquadronCapInterval( "Sayqal_17th", 1, red_cap_interval_min, red_cap_interval_max, 1 )
    end

    -- Dumayr 30th Brigade
    -- https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    RedA2ADispatcher:SetSquadron( "Dumayr_30th", AIRBASE.Syria.Al_Dumayr, { "mig21_r3", "mig21_r60", "mig21_r60m"}, 6 )
    RedA2ADispatcher:SetSquadronTakeoffFromParkingCold( "Dumayr_30th" )
    RedA2ADispatcher:SetSquadronLandingAtRunway( "Dumayr_30th" )
    RedA2ADispatcher:SetSquadronFuelThreshold( "Dumayr_30th", 0.30 )
    RedA2ADispatcher:SetSquadronGrouping( "Dumayr_30th", 2 )
    RedA2ADispatcher:SetSquadronOverhead( "Dumayr_30th", math.random(red_overhead_min, red_overhead_max)/100 )

    -- GCI random chance is 21%
    if math.random() < red_gci_chance then
        RedA2ADispatcher:SetSquadronGci( "Dumayr_30th", 750, 1100 )
    end

    -- CAP random chance is 30%
    if math.random() < red_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        RedA2ADispatcher:SetSquadronCap( "Dumayr_30th", RedA2ACapZone, 5000, 9000, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        RedA2ADispatcher:SetSquadronCapInterval( "Dumayr_30th", 1, red_cap_interval_min, red_cap_interval_max, 1 )
    end

    -- Shayrat 50th Brigade
    -- https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    RedA2ADispatcher:SetSquadron( "Shayrat_50th", AIRBASE.Syria.Shayrat, { "mig21_r3", "mig21_r60", "mig21_r60m", "mig23_24r", "mig23_24t"}, 4 )
    RedA2ADispatcher:SetSquadronTakeoffFromParkingCold( "Shayrat_50th" )
    RedA2ADispatcher:SetSquadronLandingAtRunway( "Shayrat_50th" )
    RedA2ADispatcher:SetSquadronFuelThreshold( "Shayrat_50th", 0.30 )
    RedA2ADispatcher:SetSquadronGrouping( "Shayrat_50th", 2 )
    RedA2ADispatcher:SetSquadronOverhead( "Shayrat_50th", math.random(red_overhead_min, red_overhead_max)/100 )

    -- GCI random chance is 21%
    if math.random() < red_gci_chance then
        RedA2ADispatcher:SetSquadronGci( "Shayrat_50th", 750, 1100 )
    end

    -- CAP random chance is 30%
    if math.random() < red_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        RedA2ADispatcher:SetSquadronCap( "Shayrat_50th", RedA2ACapZone, 5000, 9000, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        RedA2ADispatcher:SetSquadronCapInterval( "Shayrat_50th", 1, red_cap_interval_min, red_cap_interval_max, 1 )
    end

end

if ME_isBlueCap == true then 
    BlueDetectionSetGroup = SET_GROUP:New()
    BlueDetectionSetGroup:FilterPrefixes( { "BLUE_EWR" } )
    BlueDetectionSetGroup:FilterStart()

    -- Setup the detection and group targets to a 30km range!
    BlueDetection = DETECTION_AREAS:New( BlueDetectionSetGroup, 10000 )

    -- Setup the A2A dispatcher, and initialize it.
    BlueA2ADispatcher = AI_A2A_DISPATCHER:New( BlueDetection )

    BlueA2ADispatcher:SetEngageRadius( 40000 )
    BlueA2ADispatcher:SetGciRadius( 40000 )
    BlueA2ADispatcher:SetDisengageRadius(550000)
    BlueA2ADispatcher:SetTacticalDisplay( ME_isDebugMode )
    BlueA2ACapZone = ZONE:New("blue_cap_zone")

    --https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    BlueA2ADispatcher:SetSquadron( "BeirutF5", AIRBASE.Syria.Beirut_Rafic_Hariri, { "F5_9p5" }, 4 )
    BlueA2ADispatcher:SetSquadronTakeoffFromParkingCold( "BeirutF5" )
    BlueA2ADispatcher:SetSquadronLandingAtRunway( "BeirutF5" )
    BlueA2ADispatcher:SetSquadronFuelThreshold( "BeirutF5", 0.30 )
    BlueA2ADispatcher:SetSquadronGrouping( "BeirutF5", 2 )
    BlueA2ADispatcher:SetSquadronOverhead( "BeirutF5", 1 )

    -- GCI random chance is 60%
    if math.random() < blue_gci_chance then
        BlueA2ADispatcher:SetSquadronGci( "BeirutF5", 750, 1100 )
    end

    -- CAP random chance is 45%
    if math.random() < blue_cap_chance then
        --min alt, max alt, min patrol speed, max patrol speed, min engage speed, max engage speed, radio/baro alt
        BlueA2ADispatcher:SetSquadronCap( "BeirutF5", BlueA2ACapZone, 5000, 9000, 600, 750, 800, 1100, "RADIO" )
        --name, max spawned groups, min time sec, max time sec
        BlueA2ADispatcher:SetSquadronCapInterval( "BeirutF5", 1, blue_cap_interval_min, blue_cap_interval_max, 1 )
    end
end