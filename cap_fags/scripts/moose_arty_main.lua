local morbius = ARTY:New(GROUP:FindByName("morbius"))
morbius:SetMaxFiringRange(20)
morbius:SetMarkAssignmentsOn()
morbius:Start()

local meat = ARTY:New(GROUP:FindByName("meat"))
meat:SetMaxFiringRange(30)
meat:SetMarkAssignmentsOn()
meat:Start()