rand_beacons = RandomRadioBeacons:New()
rand_beacons:SetSound("beaconsilent.ogg")
rand_beacons:SetFreq(36.05, 38.25, radio.modulation.AM, 0.05)
rand_beacons:CreateRandomBeacons("test_g")

rand_beacons1 = RandomRadioBeacons:New()
rand_beacons1:SetSound("beaconsilent.ogg")
rand_beacons1:SetFreq(0.350, 0.650, radio.modulation.FM, 0.001)
rand_beacons1:CreateRandomBeacons("test_p")
