local my_csar = CSAR:New(coalition.side.RED,"Downed Pilot","moose_csar_res")

my_csar.radioSound = "beaconsilent.ogg" -- the name of the sound file to use for the pilots' radio beacons.
my_csar.csarPrefix = {"TR", "RW", "TWR", "MEDEVAC"}
my_csar.useprefix = true
my_csar.verbose = 0
my_csar.extractDistance = 50
my_csar.loadDistance = 3
my_csar.pilotmustopendoors = true

my_csar:__Start(5)