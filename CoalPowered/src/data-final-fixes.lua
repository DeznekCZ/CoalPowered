
function string.equals( self, compared )
  if self ~= nil then
    return string.find(self,compared,1,true)
  else
    return false
  end
end

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

function with_remove(data, changes)
  if not data then return end
  if not changes then return end
  
  local to_remove = {}
  
  for key,item in pairs(data) do
    if changes(item) then
      table.insert(to_remove, { key = key }) 
    end
  end
  
  local i = #to_remove
  while i > 0 do
    data[to_remove[i].key] = nil
    i = i - 1
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

function multiple_single_consuption(origin, value)
  local appendix = origin:gsub("[^%D]+", "")
  local number = origin:gsub("%D+", "")
  return (tonumber(number) * value) .. appendix
end

require("prototypes.tech")

--[[ UTIL ]]--

function new_burner(data)
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
assemblers["assembling-machine-1"].energy_source = new_burner{
  effectivity = 0.5,
  emissions = 0.01
}
recipes["assembling-machine-1"].ingredients = {
	{"simple-gear-box", 1},
	{"iron-plate", 9},
	{"stone-furnace", 1}
}
assemblers["assembling-machine-1"].energy_usage
     = multiple_single_consuption( assemblers["assembling-machine-1"].energy_usage, 10 )

-- Assembling machine 2
assemblers["assembling-machine-2"].energy_source = new_burner{
  effectivity = 0.5,
}
recipes["assembling-machine-2"].enabled = false
recipes["assembling-machine-2"].normal = nil
recipes["assembling-machine-2"].expensive = nil
recipes["assembling-machine-2"].result = "assembling-machine-2"
recipes["assembling-machine-2"].ingredients = {
  {"simple-gear-box", 5},
  {"steel-plate", 2},
  {"assembling-machine-1", 1}
}
assemblers["assembling-machine-2"].energy_usage
     = multiple_single_consuption( assemblers["assembling-machine-2"].energy_usage, 10 )

-- Assembling machine 3
assemblers["assembling-machine-3"].energy_source = new_burner{
  effectivity = 0.5,
  emissions = 0.03
}
recipes["assembling-machine-3"].ingredients = {
  {"speed-module", 2},
  {"assembling-machine-2", 2}
}
assemblers["assembling-machine-3"].energy_usage
     = multiple_single_consuption( assemblers["assembling-machine-3"].energy_usage, 10 )

-- Chemical plant
assemblers["chemical-plant"].energy_source = new_burner{
  effectivity = 0.5,
  emissions = 0.04
}
with_recipe_ingredients("chemical-plant",
  {
    {"steel-plate", 5},
    {"simple-gear-box", 1},
    {"engine-unit", 6},
    {"pipe", 5}
  }
)

--[[ OTHER ]]--

data.raw.lab.lab.energy_source = new_burner{emissions = 0.04}
data.raw.recipe.lab.ingredients = {
	{"simple-gear-box", 10},
	{"transport-belt", 4},
	{"stone-furnace", 2}
}

data.raw.recipe["electric-mining-drill"] = nil
----[[
data.raw["pump"]["pump"].energy_source = new_burner{
	emissions = 0.01,
	extra = {usage_priority = "secondary-input"}
}
with_recipe_ingredients("pump",
  {
    {"pipe", 2},
    {"iron-gear-wheel", 4}
  }
)

with_recipe_ingredients("offshore-pump",
  {
    {"pipe", 2},
    {"iron-gear-wheel", 4}
  }
)

data.raw["radar"]["radar"].energy_source = new_burner{
	emissions = 0.05,
    extra = {usage_priority = "secondary-input"}
}
with_recipe_ingredients("radar",
  {
    {"stone-furnace", 1},
    {"simple-gear-box", 1},
    {"iron-plate", 10}
  }
)

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

require ("prototypes.mining")

data.raw["assembling-machine"]["oil-refinery"].energy_source = new_burner{emissions = 0.15}

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



