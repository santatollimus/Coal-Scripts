CoalWantedConfig = {
    maxHeat = 100,
    baseDecay = {
        amount = 1,
        interval = 60000
    },
    tiers = {
        { level = 0, min = 0 },
        { level = 1, min = 20 },
        { level = 2, min = 50 },
        { level = 3, min = 80 },
    },
    offenseHeat = {
        murder = 45,
        assault = 25,
        robbery = 30,
        theft = 15,
        trespass = 5,
        generic = 10,
    },
    decayModifiers = {
        -- { center = vector3(0.0, 0.0, 0.0), radius = 250.0, multiplier = 0.5 },
    }
}
LawPosseConfig = {
    posseTier = 3, -- tier at which NPC posse will spawn
    numDeputies = 3,
    spawnRadius = 25.0,
    models = {
        `S_M_M_DispatchLawRural_01`,
        `S_M_M_DispatchLawRural_02`,
    },
    weapon = `WEAPON_REPEATER_CARBINE`,
    maxDistanceFromPlayer = 120.0 -- cleanup if they wander too far
}
