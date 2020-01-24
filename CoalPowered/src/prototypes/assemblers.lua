

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
  emissions = 0.02
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
  {"speed-module", 4},
  {"assembling-machine-2", 2}
}
assemblers["assembling-machine-3"].energy_usage
     = multiple_single_consuption( assemblers["assembling-machine-3"].energy_usage, 10 )

-- Chemical plant
assemblers["chemical-plant"].energy_source = new_burner{
  effectivity = 1,
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

-- Centrifuge
assemblers["centrifuge"].energy_source = new_burner{
  effectivity = 1,
  emissions = 0.04
}
with_recipe_ingredients ("centrifuge", 
  {
    {"concrete", 100},
    {"steel-plate", 50},
    {"advanced-gear-box", 20},
    {"engine-unit", 50}
  }
)

--[[ ASSEMBLER-4 ]] 

assemblers["assembling-machine-3"].next_upgrade = "assembling-machine-4"
local assembler_4 = util.table.deepcopy(assemblers["assembling-machine-3"])
assembler_4.name = "assembling-machine-4"
assembler_4.icon = "__CoalPowered__/graphics/icons/assembling-machine-4.png"
assembler_4.icon_size = 32
assembler_4.crafting_speed = 2
assembler_4.energy_source.effectivity = 1.5
assembler_4.energy_source.emissions = 0.02
assembler_4.minable.result = "assembling-machine-4"
assembler_4.fluid_boxes =
{
  {
    production_type = "input",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ type="input", position = {0, -2} }},
    secondary_draw_orders = { north = -1 }
  },
  {
    production_type = "output",
    pipe_picture = assembler2pipepictures(),
    pipe_covers = pipecoverspictures(),
    base_area = 10,
    base_level = -1,
    pipe_connections = {{ type="output", position = {0, 2} }},
    secondary_draw_orders = { north = -1 }
  },
  off_when_no_fluid_recipe = true
}
table.insert(assembler_4.crafting_categories,0,"upgrade-crafting")

local f_ani_s = function(animations,faces) for _,face in pairs(faces) do 
  local layer = animations[face].layers[1] 
  if string.find(layer.filename, "shadow", 1, true) then
    -- Do not replace shadow
  else
    layer.filename = layer.filename:gsub("3","4")
    layer.hr_version.filename = layer.hr_version.filename:gsub("3","4")
    layer.filename = layer.filename:gsub("__base__","__CoalPowered__")
    layer.hr_version.filename = layer.hr_version.filename:gsub("__base__","__CoalPowered__")
  end
end end
f_ani_s(assembler_4,{"animation"})

data:extend{
  {
    type = "item",
    name = "assembling-machine-4",
    icon = "__CoalPowered__/graphics/icons/assembling-machine-4.png",
    icon_size = 32,
    subgroup = "production-machine",
    order = "c[assembling-machine-4]",
    place_result = "assembling-machine-4",
    stack_size = 50
  },
  assembler_4,
  {
    type = "recipe",
    category = "advanced-crafting",
    name = "assembling-machine-4",
    enabled = false,
    ingredients =
    {
      {"engine-unit", 8},
      {"steel-plate", 6},
      {"speed-module-2", 1},
      {"effectivity-module-2", 1},
    },
    result = "assembling-machine-4"
  },
}

upgrade_recipe(function()
  upgrade_info.name = "assembling-machine-3-to-4"
  upgrade_info.source.name = "assembling-machine-3"
  upgrade_info.target.name = "assembling-machine-4"
  upgrade_info.energy_required = 15
  upgrade_info.ingredients =
  {
    {"engine-unit", 8},
    {"steel-plate", 6},
    {type = "fluid", name = "lubricant", amount = 5},
    {"effectivity-module-2", 1},
  }
  upgrade_info.results = 
  {
    {"stone-furnace", 2},
    {"simple-gear-box", 12},
  }
  upgrade_info.scrap_iron = 16
end)
