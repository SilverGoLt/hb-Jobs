Config = {}

Config.Markers = {
    ['police'] = {
        job = 'police',
        markers = {
            {
                pos = vec3(-449.89450073242, 6003.5473632812, 31.487182617188),
                label = '[E] Garage', 
                interaction = 'openGarage',
                style = {
                    type = 1,
                    color = { r = 0, g = 255, b = 0, a = 255 },
                    size = { x = 1.0, y = 1.0, z = 1.0 },
                    bob = false,
                    face = false
                }
            }
        }
    },

    ['ambulance'] = {
        job = 'ambulance',
        markers = {
            {
                pos = vec3(-256.8923034668, 6351.7451171875, 31.346557617188),
                label = '[E] Garage', 
                interaction = 'openGarage',
                style = {
                    type = 1,
                    color = { r = 0, g = 255, b = 0, a = 255 },
                    size = { x = 0.4, y = 0.4, z = 0.2 },
                    bob = false,
                    face = false
                },
                spawn = {
                    x = -258.92306518555, y = 6347.525390625, z = 32.413940429688, heading = 269.29135131836
                }
            },
            {
                pos = vec3(-254.0822, 6339.3843, 31.4262),
                label = '[~g~E~w~] Garage', 
                interaction = 'openGarage',
                style = {
                    type = 1,
                    color = { r = 0, g = 255, b = 0, a = 255 },
                    size = { x = 0.4, y = 0.4, z = 0.2 },
                    bob = false,
                    face = false
                }
            },
            {
                pos = vec3(-243.5992, 6325.4292, 31.4262),
                label = '[~g~E~w~] Uniforms', 
                interaction = 'openUniforms',
                style = {
                    type = 1,
                    color = { r = 0, g = 255, b = 0, a = 255 },
                    size = { x = 0.4, y = 0.4, z = 0.2 },
                    bob = false,
                    face = false
                }
            },
        },
    },

    ['mechanic'] = {
        job = 'mechanic',
        markers = {
            {
                pos = vec3(147.982421875, 6361.7934570312, 31.520874023438),
                label = '[E] Garage', 
                interaction = 'openGarage',
                style = {
                    type = 1,
                    color = { r = 0, g = 255, b = 0, a = 255 },
                    size = { x = 1.0, y = 1.0, z = 1.0 },
                    bob = false,
                    face = false
                }
            }
        }
    },
}

Config.Vehicles = {
    ['police'] = {
        {name = 'Police Cruiser', model = 'police2', grade = 0}
    },
    ['ambulance'] = {
        {name = 'Greitoji', model = 'ambulance', grade = 0}
    },
    ['mechanic'] = {},
}

Config.Items = {
    ['ambulance'] = {
        {item = 'medikit', heal = 30}
    }
}

Config.Skins = {
    ['police'] = {
        {
            grade = 1,
            label = 'Police Uniform',
            data = {
                male = {
                    ['tshirt_1'] = 59, ['tshirt_2'] = 1,
                    ['torso_1'] = 55, ['torso_2'] = 0,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 41,
                    ['pants_1'] = 25, ['pants_2'] = 2,
                    ['shoes_1'] = 25, ['shoes_2'] = 0,
                    ['helmet_1'] = 46, ['helmet_2'] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                    ['ears_1'] = 2, ['ears_2'] = 0
                },
                female = {
                    ['tshirt_1'] = 36, ['tshirt_2'] = 1,
                    ['torso_1'] = 48, ['torso_2'] = 0,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 44,
                    ['pants_1'] = 34, ['pants_2'] = 0,
                    ['shoes_1'] = 27, ['shoes_2'] = 0,
                    ['helmet_1'] = 45, ['helmet_2'] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                    ['ears_1'] = 2, ['ears_2'] = 0
                }
            }
        }
    },
    ['ambulance'] = {
        {
            grade = 0,
            label = 'Simple Clothing',
            reset = true,
        },
        {
            grade = 1,
            label = 'Resident Uniform',
            data = {
                male = {
                    ['tshirt_1'] = 59, ['tshirt_2'] = 1,
                    ['torso_1'] = 55, ['torso_2'] = 0,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 41,
                    ['pants_1'] = 25, ['pants_2'] = 2,
                    ['shoes_1'] = 25, ['shoes_2'] = 0,
                    ['helmet_1'] = 46, ['helmet_2'] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                    ['ears_1'] = 2, ['ears_2'] = 0
                },
                female = {
                    ['tshirt_1'] = 36, ['tshirt_2'] = 1,
                    ['torso_1'] = 48, ['torso_2'] = 0,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 44,
                    ['pants_1'] = 34, ['pants_2'] = 0,
                    ['shoes_1'] = 27, ['shoes_2'] = 0,
                    ['helmet_1'] = 45, ['helmet_2'] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                    ['ears_1'] = 2, ['ears_2'] = 0
                }
            }
        },
        {
            grade = 2,
            label = 'Senior Doctor Uniform',
            data = {
                male = {
                    ['tshirt_1'] = 59, ['tshirt_2'] = 1,
                    ['torso_1'] = 55, ['torso_2'] = 0,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 41,
                    ['pants_1'] = 25, ['pants_2'] = 2,
                    ['shoes_1'] = 25, ['shoes_2'] = 0,
                    ['helmet_1'] = 46, ['helmet_2'] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                    ['ears_1'] = 2, ['ears_2'] = 0
                },
                female = {
                    ['tshirt_1'] = 36, ['tshirt_2'] = 1,
                    ['torso_1'] = 48, ['torso_2'] = 0,
                    ['decals_1'] = 0, ['decals_2'] = 0,
                    ['arms'] = 44,
                    ['pants_1'] = 34, ['pants_2'] = 0,
                    ['shoes_1'] = 27, ['shoes_2'] = 0,
                    ['helmet_1'] = 45, ['helmet_2'] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                    ['ears_1'] = 2, ['ears_2'] = 0
                }
            }
        },
    },
    ['mechanic'] = {},
}