
local forbiden_technologies = {
	"electric-energy-distribution-1",
	"electric-energy-distribution-2",
	"electric-energy-accumulators-1",
	"advanced-material-processing-2",
	"fluid-wagon",
	"laser-turrets",
	"discharge-defense-equipment",
	"laser-turret-damage-1",
	"laser-turret-damage-2",
	"laser-turret-damage-3",
	"laser-turret-damage-4",
	"laser-turret-damage-5",
	"laser-turret-damage-6",
	"laser-turret-damage-7",
	"laser-turret-damage-8",
	"laser-turret-speed-1",
	"laser-turret-speed-2",
	"laser-turret-speed-3",
	"laser-turret-speed-4",
	"laser-turret-speed-5",
	"laser-turret-speed-6",
	"laser-turret-speed-7",
	"laser-turret-speed-8",
	"personal-laser-defense-equipment"
}

for tech_name, tech_data in pairs(data.raw.technology) do
	for _, forbiden in pairs (forbiden_technologies) do
		 if forbiden == tech_name then
		 	tech_data.enabled = false
		 end
	end
end

table.insert(data.raw.technology["oil-processing"].effects,{
        type = "unlock-recipe",
        recipe = "oil-lamp"
      })

data.raw.technology["nuclear-power"].effects = {
      {
        type = "unlock-recipe",
        recipe = "centrifuge"
      },
      {
        type = "unlock-recipe",
        recipe = "uranium-processing"
      },
      {
        type = "unlock-recipe",
        recipe = "clear-uranium"
      }
    }
    
data.raw.technology["coal-liquefaction"].effects = {
      {
        type = "unlock-recipe",
        recipe = "boiler"
      },
      {
        type = "unlock-recipe",
        recipe = "coal-liquefaction"
      }
   }
    
data.raw.technology["advanced-material-processing"].effects =
    {
      {
        type = "unlock-recipe",
        recipe = "steel-furnace"
      },
      {
        type = "unlock-recipe",
        recipe = "production-science-pack"
      },
      {
        type = "unlock-recipe",
        recipe = "burner-mining-drill-2"
      },
      {
        type = "unlock-recipe",
        recipe = "burner-mining-drill-2-upgrade"
      }
    }
    
data.raw.recipe["production-science-pack"].ingredients =
    {
     {"electric-engine-unit", 1},
     {"steel-furnace", 1},
     {"steel-plate", 4},
     {"advanced-circuit", 5}
    }
    
data.raw.item["solar-panel"].place_result = nil
data.raw["solar-panel"]["solar-panel"].order = data.raw.item["solar-panel"].order
data.raw.item["solar-panel"].flags = {"goes-to-main-inventory"}
data.raw.item["accumulator"].place_result = nil
data.raw.accumulator.accumulator.order = data.raw.item["accumulator"].order
data.raw.item["accumulator"].flags = {"goes-to-main-inventory"}

--data.raw.accumulator.accumulator = nil
--data.raw["solar-panel"]["solar-panel"] = nil

--data.raw.recipe["steam-engine"] = nil
data.raw.recipe["steam-engine"].enabled = false
data.raw.recipe["boiler"].enabled = false

data.raw["dont-use-entity-in-energy-production-achievement"]["solaris"] = nil
data.raw["dont-use-entity-in-energy-production-achievement"]["steam-all-the-way"] = nil

--[[ UTIL ]]--

local function new_burner(data)
	local burner_d = {
	      type = "burner",
	      fuel_category = data.fuel_category or "chemical",
	      effectivity = data.efectivity or 1,
	      emissions = data.emissions or 0.02,
	      fuel_inventory_size = data.fuel_inventory_size or 1,
	      burnt_inventory_size = data.burnt_inventory_size,
	      smoke =
	      {
	        {
	          name = "smoke",
	          frequency = data.frequency or 10,
	          position = data.position or {0.7, -1.2},
	          starting_vertical_speed = data.starting_vertical_speed or 0.08,
	          starting_frame_deviation = data.starting_frame_deviation or 60
	        }
	      }
	    }
	if data.extra then
		for var, val in pairs(data.extra) do
			burner_d[var] = val
		end
	end
	return burner_d
end

--[[ ASSEMBLERS ]]--

local assemblers = data.raw["assembling-machine"]
local recipes = data.raw.recipe

-- Assembling machine 1
assemblers["assembling-machine-1"].energy_source = new_burner{emissions = 0.01}
recipes["assembling-machine-1"].ingredients = {
	{"electronic-circuit", 3},
	{"iron-gear-wheel", 5},
	{"iron-plate", 9},
	{"stone-furnace", 1}
}

-- Assembling machine 2
assemblers["assembling-machine-2"].energy_source = new_burner{}

-- Assembling machine 3
assemblers["assembling-machine-3"].energy_source = new_burner{emissions = 0.03}

-- Chemical plant
assemblers["chemical-plant"].energy_source = new_burner{emissions = 0.04}

--[[ INSERTERS ]]--

local function increase_consuption(inserter)
	data.raw.inserter[inserter].energy_per_movement = data.raw.inserter[inserter].energy_per_movement * 20
	data.raw.inserter[inserter].energy_per_rotation = data.raw.inserter[inserter].energy_per_rotation * 20
end

local function replace_energy(inserter)
	data.raw.inserter[inserter].energy_source = {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 9
        }
      }
    }
end

increase_consuption("inserter")
increase_consuption("long-handed-inserter")
increase_consuption("fast-inserter")
increase_consuption("filter-inserter")
increase_consuption("stack-inserter")
increase_consuption("stack-filter-inserter")

replace_energy("inserter")
replace_energy("long-handed-inserter")
replace_energy("fast-inserter")
replace_energy("filter-inserter")
replace_energy("stack-inserter")
replace_energy("stack-filter-inserter")

--[[ OTHER ]]--

data.raw.lab.lab.energy_source = new_burner{emissions = 0.04}
data.raw.recipe.lab.ingredients = {
	{"electronic-circuit", 10},
	{"iron-gear-wheel", 10},
	{"transport-belt", 4},
	{"stone-furnace", 1}
}

data.raw.recipe["small-electric-pole"] = nil
data.raw.recipe["electric-mining-drill"] = nil
data.raw.recipe["science-pack-3"].ingredients =
    {
      {"advanced-circuit", 1},
      {"engine-unit", 1},
      {"electronic-circuit", 5},
    }
----[[
data.raw["pump"]["pump"].energy_source = new_burner{
	emissions = 0.01,
	extra = {usage_priority = "secondary-input"}
}
--]]--
----[[
data.raw["roboport"]["roboport"].energy_source = new_burner({
	emissions = 0.05,
	fuel_inventory_size = 2,
	extra = {
      usage_priority = "secondary-input",
      input_flow_limit = "5MW",
      buffer_capacity = "100MJ"
    }
})
--]]--
data.raw["radar"]["radar"].energy_source = new_burner{
	emissions = 0.05,
    extra = {usage_priority = "secondary-input"}
}

data.raw["rocket-silo"]["rocket-silo"].energy_source = new_burner({emissions = 0.1})

data.raw["mining-drill"]["pumpjack"].energy_source = new_burner{emissions = 0.15}

require ("prototypes.mining")

data.raw["assembling-machine"]["oil-refinery"].energy_source = new_burner{emissions = 0.15}

data:extend{
	{
		type = "fuel-category",
		name = "lamp-oil"
	},
	{
		type = "fuel-category",
		name = "vehicle-fuel"
	}
}


local lamp_oil = data.raw.item["petroleum-gas-barrel"]
lamp_oil.fuel_category = "lamp-oil"
lamp_oil.fuel_value = "60MJ"
lamp_oil.burnt_result = "empty-barrel"
--[[
local vehicle_fuel = data.raw.item["light-oil-barrel"]
vehicle_fuel.fuel_category = "vehicle-fuel"
vehicle_fuel.fuel_value = "125MJ"
vehicle_fuel.burnt_result = "empty-barrel"

local locomotive = data.raw.locomotive.locomotive
locomotive.burner.fuel_category = "vehicle-fuel"
locomotive.burnt_inventory_size = 3

local car = data.raw.car.car
car.burner.fuel_category = "vehicle-fuel"
car.burnt_inventory_size = 1

local tank = data.raw.car.tank
tank.burner.fuel_category = "vehicle-fuel"
tank.burnt_inventory_size = 2
--]]

require ("prototypes.lamp")

local new_oil_lamp_item =util.table.deepcopy(data.raw.item["small-lamp"])
new_oil_lamp_item.name = "oil-lamp"
new_oil_lamp_item.order = "a[light]-b[oil-lamp]"
new_oil_lamp_item.place_result = "oil-lamp"

data:extend{
	create_oil_lamp(),
	new_oil_lamp_item,
	{
		enabled = false,
	    type = "recipe",
	    name = "oil-lamp",
	    normal =
	    {
	      energy_required = 1.5,
	      ingredients =
	      {
	        {"iron-stick", 4},
	        {"iron-plate", 2}
	      },
	      result = "oil-lamp"
	    },
	    expensive =
	    {
	      energy_required = 3,
	      ingredients =
	      {
	        {"iron-stick", 8},
	        {"iron-plate", 4}
	      },
	      result = "oil-lamp"
	    }
	},
	{
		enabled = true,
	    type = "recipe",
	    name = "small-lamp",
	    normal =
	    {
	      energy_required = 0.5,
	      ingredients =
	      {
	        {"stone", 3}
	      },
	      result = "small-lamp"
	    },
	    expensive =
	    {
	      energy_required = 0.5,
	      ingredients =
	      {
	        {"stone", 4}
	      },
	      result = "small-lamp"
	    }
	}
}

--data.raw.lamp["small-lamp"] = nil
data.raw.item["small-lamp"].place_result = "fire-site"
data.raw.lamp["small-lamp"].order = data.raw.item["small-lamp"].order
data:extend{ create_lamp() }


