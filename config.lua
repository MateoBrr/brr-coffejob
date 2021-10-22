Config = {}

Config.Ubicaciones = {
    ["servicio"] = {
        [1] = vector3(-634.32, 228.08, 81.88),
      --  [2] = vector3(-634.32, 228.08, 81.88),
    },
    ["vehiculos"] = {
        [1] = vector4(-620.67, 206.63, 74.17, 89.57),
    },
    ["tienda"] = {
        [1] = vector3(-631.68, 228.03, 81.88),
    },
    ["stash"] = {
        [1] = vector3(-635.41, 233.66, 81.88),
    },
    ["blips"] = {
        [1] = {label = "StarBucks", coords = vector4(-630.04, 234.87, 81.88, 3.5)},
       -- [2] = {label = "StarBucks", coords = vector4(-630.04, 234.87, 81.88, 3.5)},
    },
 }



 Config.Vehiculos = {
	-- Grado 0
	[0] = {
		["sanchez"] = "Carro 1",
        ["bati"] = "Carro 2",
        ["zentorno"] = "Carro 1",
    },
	-- Grado 1
	[1] = {
		["sanchez"] = "Carro 1",
        ["sanchez"] = "Carro 1",

	},
	-- Grado 2
	[2] = {
		["sanchez"] = "Carro 1",
        ["sanchez"] = "Carro 1",
    },
	-- Grado 3
	[3] = {
		["sanchez"] = "Carro 1",
        ["sanchez"] = "Carro 1",
    },
	-- Grado 4
	[4] = {
		["sanchez"] = "Carro 1",
        ["sanchez"] = "Carro 1",
    }
}

Config.Slots = 10

Config.Items = {
    label = "Tienda",
    slots = 10,
    items = {
        [1] = {
            name = "cafe6oz",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        [2] = {
            name = "cafe10oz",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        [3] = {
            name = "cafe12oz",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        [4] = {
            name = "capucino",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        [5] = {
            name = "pan",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        [6] = {
            name = "croazan",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        [7] = {
            name = "churro",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 7,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        [8] = {
            name = "milo",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 8,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        [9] = {
            name = "cupcake",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 9,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        [10] = {
            name = "muffing",
            price = 0,
            amount = 1000,
            info = {},
            type = "item",
            slot = 10,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        }
    }
}
