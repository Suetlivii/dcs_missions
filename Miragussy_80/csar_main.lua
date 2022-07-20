my_csar = CSAR:New(coalition.side.BLUE,"Downed Pilot","moose_csar_res")

my_csar.radioSound = "beaconsilent.ogg"
my_csar.csarPrefix = {"RW"}
my_csar.useprefix = true
-- my_csar.verbose = 5
my_csar.extractDistance = 50
my_csar.loadDistance = 3
my_csar.pilotmustopendoors = true

my_csar:__Start(5)

-- my_csar:SpawnCSARAtZone( "NDB", coalition.side.BLUE, "VIP Chel", true )