-- FARP Static Beacons
farp_beacon = RandomRadioBeacons:New()
farp_beacon:SetSound("beaconsilent.ogg")

-- London Farp beacons
farp_beacon:ActivateFreq("bc_london_fm", 38.05, radio.modulation.FM)
farp_beacon:ActivateFreq("bc_london", 0.550, radio.modulation.AM)

-- YC67 beacons
farp_beacon:ActivateFreq("bc_yc67_fm", 41.25, radio.modulation.FM)
farp_beacon:ActivateFreq("bc_yc67", 0.900, radio.modulation.AM)

-- BT26 beacons
farp_beacon:ActivateFreq("bc_bt26_fm", 35.55, radio.modulation.FM)
farp_beacon:ActivateFreq("bc_bt26", 0.650, radio.modulation.AM)

-- Random Huey Beacons
huey_khz_beacon = RandomRadioBeacons:New()
huey_khz_beacon:SetSound("beaconsilent.ogg")
huey_khz_beacon:SetFreq(0.450, 1.500, radio.modulation.AM, 0.01)
huey_khz_beacon:ActivateRandomBeacons("huey_adf")

-- Random Mi8 Beacons
huey_khz_beacon = RandomRadioBeacons:New()
huey_khz_beacon:SetSound("beaconsilent.ogg")
huey_khz_beacon:SetFreq(0.150, 1.290, radio.modulation.AM, 0.01)
huey_khz_beacon:ActivateRandomBeacons("mi8_adf")

