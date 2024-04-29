RandomRadioBeacons = {
    _freq_min = nil,
    _freq_max = nil,
    _modulation = nil,
    _sound_file_name = nil
}

function RandomRadioBeacons:New()
    local self = BASE:Inherit( self, BASE:New() ) -- #DATABASE
    return self
end

function RandomRadioBeacons:SetFreq(freq_min_mhz, freq_max_mhz, modulation, min_step)
    self._freq_min = freq_min_mhz
    self._freq_max = freq_max_mhz
    self._modulation = modulation
    self._min_step = min_step
end

function RandomRadioBeacons:SetSound(sound_file_name)
    self._sound_file_name = sound_file_name
end

function RandomRadioBeacons:ActivateFreq(unit_name, freq, modulation)
    local beacon_unit = UNIT:FindByName(unit_name)
    if beacon_unit then
        local unit_radio = beacon_unit:GetRadio()
        unit_radio:SetFileName(self._sound_file_name)
        unit_radio:SetFrequency(freq)
        unit_radio:SetModulation(modulation)
        unit_radio:SetLoop(true)
        unit_radio:Broadcast()
        -- MESSAGE:New(tostring("For unit " .. unit_name .. " freq is " .. freq), 10, "DEBUG", false):ToAll()
    end
end

function RandomRadioBeacons:ActivateRandomBeacons(unit_name_prefix)
    -- Find all units with given prefix
    local units_set = SET_UNIT:New():FilterPrefixes(unit_name_prefix):FilterOnce():GetSetNames()

    -- For each unit
    for k, v in pairs(units_set) do
        local random_freq = math.random() * (self._freq_max - self._freq_min) + self._freq_min
        random_freq = random_freq - (random_freq % self._min_step)

        self:ActivateFreq(v, random_freq, self._modulation)
    end

end