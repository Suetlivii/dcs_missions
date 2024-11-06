-- Optional - Draw the borders on the map so we see what's going on
-- Set up borders on map
local red_border = ZONE_POLYGON:New( "red_border", GROUP:FindByName( "red_border_zone" ) )
local blue_border = ZONE_POLYGON:New( "blue_border", GROUP:FindByName( "blue_border_zone" ) )
local frontline_border = ZONE_POLYGON:New( "frontline_border", GROUP:FindByName( "frontline_border_zone" ) )

red_border:DrawZone(-1,{1,0,0},1,FillColor,FillAlpha,1,true)
blue_border:DrawZone(-1,{0,0,1},1,FillColor,FillAlpha,4,true)
frontline_border:DrawZone(-1,{0,1,0},1,FillColor,FillAlpha,4,true)

-- https://flightcontrol-master.github.io/MOOSE_DOCS/Documentation/Wrapper.Airbase.html

local red_palmyra_wing = EASYGCICAP:New("egc_red_palmyra", AIRBASE.Syria.Palmyra, "red", "EW_RED")
-- Add a CAP patrol point belonging to our airbase, we'll be at 30k ft doing 400 kn, initial direction 90 degrees (East), leg 20NM
red_palmyra_wing:AddPatrolPointCAP(AIRBASE.Syria.Palmyra, ZONE:FindByName("rcp_tabqa_high"):GetCoordinate(), 30000, 380, 60, 60)
red_palmyra_wing:AddPatrolPointCAP(AIRBASE.Syria.Palmyra, ZONE:FindByName("rcp_tabqa_low"):GetCoordinate(), 8000, 380, 80, 50)
red_palmyra_wing:AddPatrolPointCAP(AIRBASE.Syria.Palmyra, ZONE:FindByName("rcp_palmyra_high"):GetCoordinate(), 32000, 380, 70, 80)
red_palmyra_wing:AddSquadron("red_mig29s", "palmya_mig29_sq", AIRBASE.Syria.Palmyra, 8, AI.Skill.EXCELLENT)
red_palmyra_wing:AddAcceptZone(red_border)
red_palmyra_wing:AddAcceptZone(frontline_border)
red_palmyra_wing:AddRejectZone(blue_border)

red_palmyra_wing.debug = true -- log information
red_palmyra_wing.Monitor = true -- show some statistics on screen
