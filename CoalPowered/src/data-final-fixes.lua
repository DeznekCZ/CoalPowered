

require("prototypes.tech") -- Fixing technologies

--[[ OTHER ]]--

data:extend{
  {
    type = "recipe",
    name = "charcoal",
    localised_name = {"recipe-name.charcoal"},
    enabled = true,
    energy_required = 3.2,
    ingredients = {{"wood", 4}},
    result = "coal",
    category = "smelting",
  },
}

data.raw.lab.lab.energy_source = new_burner{emissions = 0.04}
data.raw.recipe.lab.ingredients = {
	{"iron-gear-wheel", 20},
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
local pipe_picture = assembler1pipepictures()
pipe_picture.south.shift = { 0, 4.5 }
pipe_picture.south.hr_version.shift = { 0, 4.5 }

data.raw["rocket-silo"]["rocket-silo"].energy_source = { type = "void" }

table.insert(data.raw.recipe["rocket-part"].ingredients, { "cooling-fluid-barrel", 1 } )

table.insert(data.raw.technology["rocket-silo"].effects, {
  type = "unlock-recipe",
  recipe = "cooling-fluid"
})
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
data.raw["programmable-speaker"]["programmable-speaker"].energy_source.type = "void"

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

require ("prototypes.assemblers")

require ("prototypes.integration.air_filtering")
