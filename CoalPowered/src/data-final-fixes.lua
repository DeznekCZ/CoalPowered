
function with(data, changes, clear)
  if not data then return end
  if not clear then clear = {"_no_fields_"} end
  for k,v in pairs(changes) do
    data[k] = v
  end
  for _,v in pairs(clear) do
    data[v] = nil
  end
end

recipe_data = data.raw.recipe
function with_recipe(name, changes, clear)
  with(recipe_data[name], changes, clear)
end

function with_recipe_ingredients(name, ingredients)
  with(recipe_data[name], 
    {
      ingredients = ingredients
    }
  )
end

require("prototypes.tech")

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
	{"simple-gear-box", 5},
	{"iron-plate", 9},
	{"stone-furnace", 1}
}

-- Assembling machine 2
assemblers["assembling-machine-2"].energy_source = new_burner{}
recipes["assembling-machine-2"].enabled = false
recipes["assembling-machine-2"].normal = nil
recipes["assembling-machine-2"].expensive = nil
recipes["assembling-machine-2"].result = "assembling-machine-2"
recipes["assembling-machine-2"].ingredients = {
  {"simple-gear-box", 5},
  {"steel-plate", 2},
  {"assembling-machine-1", 1}
}

-- Assembling machine 3
assemblers["assembling-machine-3"].energy_source = new_burner{emissions = 0.03}
recipes["assembling-machine-3"].ingredients = {
  {"speed-module", 2},
  {"assembling-machine-2", 2}
}

-- Chemical plant
assemblers["chemical-plant"].energy_source = new_burner{emissions = 0.04}

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
----[[
data.raw["pump"]["pump"].energy_source = new_burner{
	emissions = 0.01,
	extra = {usage_priority = "secondary-input"}
}
--]]--

data.raw["radar"]["radar"].energy_source = new_burner{
	emissions = 0.05,
    extra = {usage_priority = "secondary-input"}
}

data.raw["rocket-silo"]["rocket-silo"].energy_source = new_burner({emissions = 0.1})
with (data.raw.recipe["rocket-silo"], 
  {
    ingredients =
    {
      {"steel-plate", 1000},
      {"concrete", 1000},
      {"pipe", 100},
      {"advanced-gear-box", 200},
      {"engine-unit", 200}
    },
  }
)

data.raw["arithmetic-combinator"]["arithmetic-combinator"].energy_source.type = "void"
data.raw["decider-combinator"]["decider-combinator"].energy_source.type = "void"

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

require ("prototypes.inserter")
require ("prototypes.logistics")
require ("prototypes.clockwork")
require ("prototypes.gearbox")
require ("prototypes.module")
require ("prototypes.lamp")
require ("prototypes.loader")

require ("prototypes.coal_armor.disable")
require ("prototypes.coal_armor.mock")
require ("prototypes.coal_armor.equipment")
require ("prototypes.coal_armor.item")
require ("prototypes.coal_armor.recipe")
require ("prototypes.coal_armor.technology")


