

require("prototypes.tech") -- Fixing technologies

--[[ OTHER ]]--

data:extend{
  {
    type = "recipe",
    name = "charcoal",
    localised_name = {"recipe-name.charcoal"},
    enabled = true,
    energy_required = 3,
    ingredients = {{"wood", 2}},
    result = "coal",
    subgroup = "raw-material",
    order = "a[coal]",
    category = "smelting",
  },
}

data.raw.lab.lab.energy_source = new_burner{emissions = 0.04}
data.raw.recipe.lab.ingredients = {
	{"iron-gear-wheel", 20},
	{"transport-belt", 4},
	{"stone-furnace", 2}
}

local pipe_picture = assembler2pipepictures()
pipe_picture.south.shift = { 0, 4.5 }
pipe_picture.south.hr_version.shift = { 0, 4.5 }

data.raw["rocket-silo"]["rocket-silo"].energy_source = { type = "void" }

--with ( data.raw["rocket-silo"]["rocket-silo"],
--  {
--    energy_usage = "750kW", --energy usage used when crafting the rocket
--    idle_energy_usage = "10kW",
--    lamp_energy_usage = "10kW",
--    active_energy_usage = "750kW",
--    
--    energy_source = {
--      type = "fluid",
--      emissions_per_minute = 4,
--      fluid_box = {
--        base_area = 1,
--          height = 1,
--          base_level = -1,
--          pipe_covers = pipecoverspictures(),
--          pipe_connections =
--          {
--            {type = "input", position = {0.0, 5.2}}
--          },
--          production_type = "input",
--          filter = "cooling-fluid"
--      },
--      burns_fluid = true,
--      scale_fluid_usage = true
--    }
--  })

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

require ("prototypes.combinators")

require ("prototypes.mining")

require ("prototypes.inserter")
require ("prototypes.logistics")
require ("prototypes.clockwork")
require ("prototypes.gearbox")
require ("prototypes.module")
require ("prototypes.loader")
require ("prototypes.radar")
require ("prototypes.tips")

require ("prototypes.coal_armor.disable")
require ("prototypes.coal_armor.mock")
require ("prototypes.coal_armor.equipment")
require ("prototypes.coal_armor.item")
require ("prototypes.coal_armor.recipe")
require ("prototypes.coal_armor.technology")

require ("prototypes.assemblers")

require ("prototypes.integration.air_filtering")
