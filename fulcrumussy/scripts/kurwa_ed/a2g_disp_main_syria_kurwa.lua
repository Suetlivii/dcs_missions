local blue_bai_chance = 0.35

if ME_isDebugMode == true then
    blue_bai_chance = 1.0
end

-- in minutes
local blue_bai_interval_min = 30 * 60
local blue_bai_interval_max = 60 * 60

if ME_isDebugMode == true then
    -- in minutes
    blue_bai_interval_min = 1 * 60
    blue_bai_interval_max = 1 * 60
end

if ME_isBlueBai == true then
    local BlueBaiDetectionSetGroup = SET_GROUP:New()
    BlueBaiDetectionSetGroup:FilterPrefixes( { "BLUE_REC" } )
    BlueBaiDetectionSetGroup:FilterStart()

    local BlueBaiDetection = DETECTION_AREAS:New( BlueBaiDetectionSetGroup, 3000 )
    local BlueA2GDispatcher = AI_A2G_DISPATCHER:New( BlueBaiDetection )
    BlueA2GDispatcher:AddDefenseCoordinate( "BLUE_HQ", GROUP:FindByName( "BLUE_HQ" ):GetCoordinate() )
    BlueA2GDispatcher:SetDefenseRadius( 35000 )
    BlueA2GDispatcher:SetTacticalDisplay( ME_isDebugMode )

    local BlueA2GBaiZone = ZONE:New("blue_bai_zone")

    -- fsa_L39_1st
    -- https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html
    BlueA2GDispatcher:SetSquadron( "fsa_L39_1st", AIRBASE.Syria.Abu_al_Duhur, { "fsa_L39" }, 4 )
    BlueA2GDispatcher:SetSquadronGrouping( "fsa_L39_1st", 2 )
    BlueA2GDispatcher:SetSquadronTakeoffFromParkingCold( "fsa_L39_1st" )
    BlueA2GDispatcher:SetSquadronLandingAtRunway( "fsa_L39_1st" )
    BlueA2GDispatcher:SetSquadronFuelThreshold( "fsa_L39_1st", 0.30 )

    if math.random() < blue_bai_chance then
        -- SquadronName, Zone, FloorAltitude, CeilingAltitude, PatrolMinSpeed, PatrolMaxSpeed, EngageMinSpeed, EngageMaxSpeed, AltType
        BlueA2GDispatcher:SetSquadronBaiPatrol( "fsa_L39_1st", BlueA2GBaiZone, 500, 1500, 500, 600, 600, 900, "RADIO" )
        BlueA2GDispatcher:SetSquadronBaiPatrolInterval("fsa_L39_1st", 1, Blue_bai_interval_min, Blue_bai_interval_max, 1)
    end
end