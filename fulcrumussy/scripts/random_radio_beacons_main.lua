-- Frontline airfield beacons
farp_beacon = RandomRadioBeacons:New()
farp_beacon:SetSound("beaconsilent.ogg")

farp_beacon:ActivateFreq("frontline_airfield_ark_ud", 123.1, radio.modulation.AM)
farp_beacon:ActivateFreq("frontline_airfield_ark_9", 0.550, radio.modulation.AM)

-- FOB beacons
fob_beacon = RandomRadioBeacons:New()
fob_beacon:SetSound("beaconsilent.ogg")

fob_beacon:ActivateFreq("frontline_fob_beacon_ark_ud", 124.1, radio.modulation.AM)
fob_beacon:ActivateFreq("frontline_fob_beacon_ark_9", 0.870, radio.modulation.AM)