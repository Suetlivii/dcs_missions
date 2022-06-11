my_csar = CSAR:New(coalition.side.BLUE,"Downed Pilot","moose_csar_res")

my_csar.radioSound = "beaconsilent.ogg" -- the name of the sound file to use for the pilots' radio beacons.
my_csar.csarPrefix = {"RW"}
my_csar.useprefix = true
my_csar.verbose = 1
my_csar.extractDistance = 50
my_csar.loadDistance = 3
my_csar.pilotmustopendoors = true

my_csar:__Start(5)

-- my_csar:SpawnCSARAtZone( "TgtEvac", coalition.side.BLUE, "VIP Chel", true )