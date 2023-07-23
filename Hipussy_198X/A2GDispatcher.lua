-- RED
red_bai_chance = 0.33

-- in seconds
red_bai_interval_min = 12 * 60
red_bai_interval_max = 20 * 60

if ME_isRedBai == true then
    RedBaiDetectionSetGroup = SET_GROUP:New()
    RedBaiDetectionSetGroup:FilterPrefixes( { "RED_REC" } )
    RedBaiDetectionSetGroup:FilterStart()

    RedBaiDetection = DETECTION_AREAS:New( RedBaiDetectionSetGroup, 3000 )
    RedA2GDispatcher = AI_A2G_DISPATCHER:New( RedBaiDetection )
    RedA2GDispatcher:AddDefenseCoordinate( "RED_HQ", GROUP:FindByName( "RED_HQ" ):GetCoordinate() )
    RedA2GDispatcher:SetDefenseRadius( 30000 )
    RedA2GDispatcher:SetTacticalDisplay( ME_isDebugMode )

    RedA2GBaiZone = ZONE:New("red_bai_zone")

    -- Dumayr_30th_bomber
    -- https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    RedA2GDispatcher:SetSquadron( "Dumayr_30th_bomber", AIRBASE.Syria.Al_Dumayr, { "su25_rockets", "su25_bombs" }, 4 )
    RedA2GDispatcher:SetSquadronGrouping( "Dumayr_30th_bomber", 2 )
    RedA2GDispatcher:SetSquadronTakeoffFromParkingCold( "Dumayr_30th_bomber" )
    RedA2GDispatcher:SetSquadronLandingAtRunway( "Dumayr_30th_bomber" )
    RedA2GDispatcher:SetSquadronFuelThreshold( "Dumayr_30th_bomber", 0.30 )

    if math.random() < red_bai_chance then
        -- SquadronName, Zone, FloorAltitude, CeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, EngageMinSpeed, EngageMaxSpeed, AltType
        RedA2GDispatcher:SetSquadronBaiPatrol( "Dumayr_30th_bomber", RedA2GBaiZone, 500, 1500, 500, 600, 600, 900, "RADIO" )
        RedA2GDispatcher:SetSquadronBaiPatrolInterval("Dumayr_30th_bomber", 1, red_bai_interval_min, red_bai_interval_max, 1)
    end

    -- Marj_64th
    -- https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    RedA2GDispatcher:SetSquadron( "Marj_64th", AIRBASE.Syria.Mezzeh, { "mi24_atgm", "mi24_rockets" }, 4 )
    RedA2GDispatcher:SetSquadronGrouping( "Marj_64th", 2 )
    RedA2GDispatcher:SetSquadronTakeoffFromParkingCold( "Marj_64th" )
    RedA2GDispatcher:SetSquadronLandingAtRunway( "Marj_64th" )
    RedA2GDispatcher:SetSquadronFuelThreshold( "Marj_64th", 0.30 )

    if math.random() < red_bai_chance then
        -- SquadronName, Zone, FloorAltitude, CeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, EngageMinSpeed, EngageMaxSpeed, AltType
        RedA2GDispatcher:SetSquadronBaiPatrol( "Marj_64th", RedA2GBaiZone, 150, 900, 150, 200, 200, 300, "RADIO" )
        RedA2GDispatcher:SetSquadronBaiPatrolInterval("Marj_64th", 1, red_bai_interval_min, red_bai_interval_max, 1)
    end
end