
local new_miner = util.table.deepcopy(data.raw["mining-drill"]["burner-mining-drill"])
new_miner.mining_speed = 0.7 
new_miner.module_specification =
    {
      module_slots = 2
    }
new_miner.allowed_effects = {"consumption", "speed", "productivity", "pollution"}
new_miner.resource_searching_radius = 1.99
new_miner.energy_usage = "600kW"
new_miner.name = "burner-mining-drill-2"
new_miner.minable = {mining_time = 1, result = "burner-mining-drill-2"}

new_miner.radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/electric-mining-drill/electric-mining-drill-radius-visualization.png",
      width = 12,
      height = 12
    }
new_miner.monitor_visualization_tint = {r=78, g=173, b=255}

data.raw.item["burner-mining-drill"].order = "a[items]-a[burner-mining-drill-1]"

local new_miner_item =util.table.deepcopy(data.raw.item["burner-mining-drill"])
new_miner_item.name = "burner-mining-drill-2"
new_miner_item.order = "a[items]-a[burner-mining-drill-2]"
new_miner_item.place_result = "burner-mining-drill-2"
new_miner_item.icon = new_miner_item.icon:gsub("__base__","__CoalPowered__")

local f_ani_s = function(animations,faces) for _,face in pairs(faces) do 
	local layer = animations[face].layers[1] 
	layer.filename = layer.filename:gsub("__base__","__CoalPowered__")
	layer.hr_version.filename = layer.hr_version.filename:gsub("__base__","__CoalPowered__")
end end
f_ani_s(new_miner.animations,{"north","south","east","west"})

local u_res = data.raw.resource["uranium-ore"]
u_res.minable =
    {
      hardness = 0.9,
      mining_particle = "stone-particle",
      mining_time = 4,
      result = "dirty-uranium-ore"
    }
data:extend{
	{
	  type = "item",
		name = "dirty-uranium-ore",
		icon = "__CoalPowered__/graphics/icons/dirty-uranium-ore.png",
		icon_size = 32,
		subgroup = "raw-resource",
		order = "g[dirty-uranium-ore]",
	    stack_size = 50
	},
	{
	  type = "recipe",
	  name = "clear-uranium",
		icon = "__CoalPowered__/graphics/icons/clear-uranium.png",
		icon_size = 32,
		enabled = false,
    category = "crafting-with-fluid",
  	subgroup = "raw-material",
    energy_required = 1,
    order = "k[clear-uranium]",
    ingredients =
    {
      {"dirty-uranium-ore", 1},
      {type="fluid", name= "sulfuric-acid", amount = 5}
    },
    results =
    {
      {name = "uranium-ore", amount = 1, probability = 0.15},
      {name = "stone", amount = 1, probability = 0.85}
    },
    enabled = false
	}
}
table.insert(data.raw.technology["uranium-processing"].effects, 
  {
    type = "unlock-recipe",
    recipe = "clear-uranium"
  }
)
with_remove(data.raw.technology["nuclear-power"].effects, 
  function (item) 
    return string.equals(item.type, "unlock-recipe") 
       and string.equals(item.recipe, "steam-turbine")
  end
)
data.raw.recipe["steam-generator"] = nil
data.raw.recipe["steam-turbine"] = nil

data:extend{
	new_miner,
	new_miner_item,
	{
		enabled = false,
	    type = "recipe",
	    name = "burner-mining-drill-2",
      energy_required = 2,
      ingredients =
      {
        {"simple-gear-box", 6},
        {"steel-plate", 2},
        {"burner-mining-drill", 1},
      },
      result = "burner-mining-drill-2"
	},
}

data.raw["mining-drill"]["pumpjack"].energy_source = new_burner{emissions = 0.15}
with_recipe_ingredients("pumpjack",
  {
    {"engine-unit", 6},
    {"simple-gear-box", 4},
    {"steel-plate", 4},
    {"pipe", 10}
  }
)