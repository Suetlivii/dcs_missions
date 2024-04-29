local my_csar_blue = CSAR:New(coalition.side.BLUE,"Blue Downed Pilot","moose_csar_res")

my_csar_blue.radioSound = "beaconsilent.ogg"
my_csar_blue.csarPrefix = {"RW"}
my_csar_blue.useprefix = true
my_csar_blue.verbose = 0
my_csar_blue.extractDistance = 50
my_csar_blue.loadDistance = 3
my_csar_blue.pilotmustopendoors = true

my_csar_blue:__Start(1)

-- my_csar_blue:SpawnCSARAtZone( "NDB", coalition.side.BLUE, "VIP Chel", true )

local my_csar_red = CSAR:New(coalition.side.RED,"Red Downed Pilot","moose_csar_res")

my_csar_red.radioSound = "beaconsilent.ogg"
my_csar_red.csarPrefix = {"Mi"}
my_csar_red.useprefix = true
my_csar_red.verbose = 0
my_csar_red.extractDistance = 50
my_csar_red.loadDistance = 3
my_csar_red.pilotmustopendoors = true

my_csar_red:__Start(1)