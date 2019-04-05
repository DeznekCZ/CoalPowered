local forbiden_technologies = {
  "electric-energy-distribution-2",
  "electric-energy-accumulators-1",
  "advanced-material-processing-2",
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

--[[
table.insert(data.raw.technology["oil-processing"].effects,{
        type = "unlock-recipe",
        recipe = "oil-lamp"
      })
--]]
    
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
   
data.raw.technology["basic-electronics"].effects = 
    {
      {
        type = "unlock-recipe",
        recipe = "electronic-circuit"
      },
      {
        type = "unlock-recipe",
        recipe = "copper-cable"
      },
      {
        type = "unlock-recipe",
        recipe = "assembling-machine-1"
      }
    }
    
data.raw.technology["electric-mining"].effects = {}
    
data.raw.recipe["chemical-science-pack"].ingredients =
    {
     {"solid-fuel", 1},
     {"plastic-bar", 5},
     {"engine-unit", 2}
    }
    
data.raw.recipe["production-science-pack"].ingredients =
    {
      {"steel-furnace", 1},
      {"productivity-module", 1},
      {"rail", 30},
    }
    
data.raw.item["solar-panel"].place_result = nil
data.raw["solar-panel"]["solar-panel"].order = data.raw.item["solar-panel"].order
data.raw.item["accumulator"].place_result = nil
data.raw.accumulator.accumulator.order = data.raw.item["accumulator"].order

--data.raw.accumulator.accumulator = nil
--data.raw["solar-panel"]["solar-panel"] = nil

--data.raw.recipe["steam-engine"] = nil
data.raw.recipe["steam-engine"].enabled = false
data.raw.recipe["boiler"].enabled = false

data.raw["dont-use-entity-in-energy-production-achievement"]["solaris"] = nil
data.raw["dont-use-entity-in-energy-production-achievement"]["steam-all-the-way"] = nil

local technology = data.raw.technology
local item = data.raw.item
local recipe = data.raw.recipe

with (technology["logistics-2"], 
  { 
    prerequisites = {"logistics", "logistic-science-pack", "gearing"},
  }
)

with (technology["logistics-3"], 
  {
    prerequisites = {"production-science-pack", "gearing-2"},
  }
)

with (technology["automation"], 
  {
    prerequisites = { "gearing" }
  }
)

with (technology["automation-2"], 
  {
    prerequisites = { "automation" }
  }
)

with (technology["automation-3"], 
  {
    prerequisites = { "automation-2", "speed-module" }
  }
)

with (technology["fast-inserter"], 
  {
    prerequisites = { "automation" }
  }
)

with (technology["stack-inserter"], 
  {
    prerequisites = { "fast-inserter", "gearing-2" }
  }
)

with (technology["chemical-science-pack"], 
  {
    prerequisites = { "plastics" }
  }
)

with (technology["utility-science-pack"], 
  {
    prerequisites = { "low-density-structure", "robotics" }
  }
)

with (technology["construction-robotics"], 
  {
    prerequisites = { "robotics" }
  }
)

with (technology["logistic-robotics"], 
  {
    prerequisites = { "robotics" }
  }
)

with (technology["mining-productivity-1"], 
  {
    icon = "__CoalPowered__/graphics/technology/mining-productivity.png",
    icon_size = 128,
    prerequisites = { "logistic-science-pack", "gearing" },
    effects = {
      {
        type = "mining-drill-productivity-bonus",
        modifier = 0.1
      },
      {
        type = "unlock-recipe",
        recipe = "burner-mining-drill-2"
      }
    }
  }
)

with (technology["mining-productivity-2"], 
  {
    icon = "__CoalPowered__/graphics/technology/mining-productivity.png",
    icon_size = 128,
    prerequisites = { "mining-productivity-1" }
  }
)

with (technology["mining-productivity-3"], 
  {
    icon = "__CoalPowered__/graphics/technology/mining-productivity.png",
    icon_size = 128,
    prerequisites = { "mining-productivity-2", "gearing-2" }
  }
)

with (technology["mining-productivity-4"], 
  {
    icon = "__CoalPowered__/graphics/technology/mining-productivity.png",
    icon_size = 128,
    prerequisites = { "mining-productivity-3", "space-science-pack" }
  }
)

with (technology["atomic-bomb"], 
  {
    prerequisites = { "utility-science-pack", "production-science-pack" }
  }
)

with (recipe["atomic-bomb"], 
  {
    ingredients =
    {
      { "explosives", 10 },
      { "rocket-fuel", 1 },
      { "uranium-235", 30 }
    }
  }
)

with (recipe["rocket-part"], 
  {
    ingredients =
    {
      { "low-density-structure", 10 },
      { "rocket-fuel", 10 },
      { "gyroscope", 10 }
    }
  }
)

with (technology["robotics"], 
  {
    prerequisites = { "electric-engine", "gyroscope" }
  }
)

data:extend{
  {
    type = "item",
    name = "gyroscope",
    icon = "__CoalPowered__/graphics/icons/gyroscope.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "h[gyroscope]",
    stack_size = 10
  },
  {
    type = "recipe",
    name = "gyroscope",
    enabled = false,
    ingredients =
    {
      {"steel-plate", 5},
      {"iron-stick", 2}
    },
    result = "gyroscope"
  },
  {
    type = "technology",
    name = "gyroscope",
    icon = "__CoalPowered__/graphics/technology/gyroscope.png",
    icon_size = 224,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "gyroscope"
      }
    },
    unit =
    {
      count = 150,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 15
    },
    prerequisites = {"steel-processing"},
  }
}

with (technology["rocket-silo"], 
  {
    prerequisites = { "concrete", "speed-module-3", "productivity-module-3", "rocket-fuel", "utility-science-pack", "gyroscope" }
  }
)

technology["optics"] = nil
technology["solar-energy"] = nil
technology["electric-energy-distribution-2"] = nil

technology["laser"] = nil
technology["laser-turrets"] = nil
technology["energy-weapons-damage-1"] = nil
technology["energy-weapons-damage-2"] = nil
technology["energy-weapons-damage-3"] = nil
technology["energy-weapons-damage-4"] = nil
technology["energy-weapons-damage-5"] = nil
technology["energy-weapons-damage-6"] = nil
technology["energy-weapons-damage-7"] = nil
technology["laser-turret-speed-1"] = nil
technology["laser-turret-speed-2"] = nil
technology["laser-turret-speed-3"] = nil
technology["laser-turret-speed-4"] = nil
technology["laser-turret-speed-5"] = nil
technology["laser-turret-speed-6"] = nil
technology["laser-turret-speed-7"] = nil

technology["advanced-electronics"] = nil
technology["advanced-electronics-2"] = nil

technology["effect-transmission"] = nil -- TODO
technology["rocket-control-unit"] = nil
item["rocket-control-unit"] = nil
recipe["rocket-control-unit"] = nil

-- Remove recipe from limitation

remove_limitation("rocket-control-unit")
remove_limitation("advanced-circuit")
remove_limitation("processing-unit")

with_recipe ("utility-science-pack", 
  {
    category = "crafting-with-fluid",
    ingredients = {
       { "flying-robot-frame", 1 },
       { "low-density-structure", 3 },
       { name = "sulfuric-acid", amount = 30, type = "fluid" },
    }
  }
)

item["advanced-circuit"] = nil
recipe["advanced-circuit"] = nil


with (data.raw.recipe["tank"].normal,
  {
    ingredients = 
    { 
      {"engine-unit", 32},
      {"advanced-gear-box", 6},
      {"steel-plate", 50}
    }
  }
)

with (data.raw.recipe["tank"].expensive,
  {
    ingredients = 
    { 
      {"engine-unit", 64},
      {"advanced-gear-box", 12},
      {"steel-plate", 100}
    }
  }
)

with (data.raw.recipe["artillery-turret"],
  {
    ingredients = 
    { 
      {"concrete", 60},
      {"advanced-gear-box", 4},
      {"steel-plate", 60}
    }
  }
)

with (data.raw.recipe["artillery-wagon"],
  {
    ingredients = 
    { 
      {"engine-unit", 64},
      {"advanced-gear-box", 4},
      {"pipe", 16},
      {"steel-plate", 40}
    }
  }
)

recipe["railgun"] = nil

item["processing-unit"] = nil
recipe["processing-unit"] = nil

with_recipe_ingredients ("artillery-targeting-remote", 
  {
    { "radar", 1 }
  }
)

item["substation"] = nil
recipe["substation"] = nil
data.raw["electric-pole"]["substation"] = nil
item["electric-furnace"] = nil
recipe["electric-furnace"] = nil
data.raw.furnace["electric-furnace"] = nil
item["beacon"] = nil
recipe["beacon"] = nil
data.raw.beacon.beacon = nil
data:extend
{
  {
    type = "beacon",
    name = "mock-beacon",
    icon = "__base__/graphics/icons/beacon.png",
    icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "wood"},
    order = "a",
    max_health = 200,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    drawing_box = {{-1.5, -2.2}, {1.5, 1.3}},
    allowed_effects = {"consumption", "speed", "pollution"},
    base_picture =
    {
      filename = "__base__/graphics/entity/beacon/beacon-base.png",
      width = 116,
      height = 93,
      shift = { 0.34375, 0.046875}
    },
    animation =
    {
      filename = "__base__/graphics/entity/beacon/beacon-antenna.png",
      width = 54,
      height = 50,
      line_length = 8,
      frame_count = 32,
      shift = { -0.03125, -1.71875},
      animation_speed = 0.5
    },
    animation_shadow =
    {
      filename = "__base__/graphics/entity/beacon/beacon-antenna-shadow.png",
      width = 63,
      height = 49,
      line_length = 8,
      frame_count = 32,
      shift = { 3.140625, 0.484375},
      animation_speed = 0.5
    },
    radius_visualisation_picture =
    {
      filename = "__base__/graphics/entity/beacon/beacon-radius-visualization.png",
      priority = "extra-high-no-scale",
      width = 10,
      height = 10
    },
    supply_area_distance = 3,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input"
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    energy_usage = "480kW",
    distribution_effectivity = 0.5,
    module_specification =
    {
      module_slots = 2,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    }
  },
}

item["small-plane"] = nil
recipe["small-plane"] = nil

with_recipe_ingredients ("satellite", 
  {
    { "radar", 1 }
  }
)

with_recipe_ingredients ("nuclear-reactor", 
  {
    {"concrete", 500},
    {"steel-plate", 500},
    {"copper-plate", 500}
  }
)

technology["advanced-material-processing-2"] = nil
technology["production-science-pack"].prerequisites = {"productivity-module", "advanced-material-processing", "railway"}

technology["combat-robotics"] = nil
technology["combat-robotics-2"] = nil
technology["combat-robotics-3"] = nil
technology["follower-robot-count-1"] = nil
technology["follower-robot-count-2"] = nil
technology["follower-robot-count-3"] = nil
technology["follower-robot-count-4"] = nil
technology["follower-robot-count-5"] = nil
technology["follower-robot-count-6"] = nil
technology["follower-robot-count-7"] = nil

data.raw["produce-per-hour-achievement"]["circuit-veteran-1"] = nil
data.raw["produce-per-hour-achievement"]["circuit-veteran-2"] = nil
data.raw["produce-per-hour-achievement"]["circuit-veteran-3"] = nil
data.raw["produce-per-hour-achievement"]["computer-age-1"] = nil
data.raw["produce-per-hour-achievement"]["computer-age-2"] = nil
data.raw["produce-per-hour-achievement"]["computer-age-3"] = nil

with_recipe_ingredients("repair-pack",
  {
    {"iron-gear-wheel", 2},
    {"iron-plate", 2},
    {"copper-cable", 2},
  }
)

local mock_generator = data.raw.generator["steam-engine"]
mock_generator.name = "mock-engine"
mock_generator.minable.name = "wood"
data.raw.generator["steam-engine"] = nil
item["steam-engine"] = nil
recipe["steam-engine"] = nil
with_remove(technology["analyse-ship"].effects,function (effect)
  return effect.recipe and string.find("steam-engine", effect.recipe, 1, true)
end)

--[[ REPLACE electronic-circuit 
data.raw.item["electronic-circuit"] = nil
data.raw.recipe["electronic-circuit"] = nil
--]]
--[[ KEEP 
data.raw.recipe["small-lamp"] = nil
data.raw.recipe["player-port"] = nil
data.raw.recipe["train-stop"] = nil
data.raw.recipe["rail-signal"] = nil
data.raw.recipe["rail-chain-signal"] = nil
data.raw.recipe["red-wire"] = nil
data.raw.recipe["green-wire"] = nil
data.raw.recipe["loader"] = nil
data.raw.recipe["fast-loader"] = nil
data.raw.recipe["express-loader"] = nil
data.raw.recipe["arithmetic-combinator"] = nil
data.raw.recipe["decider-combinator"] = nil
data.raw.recipe["constant-combinator"] = nil
data.raw.recipe["power-switch"] = nil
data.raw.recipe["programmable-speaker"] = nil
data.raw.recipe["electric-energy-interface"] = nil

data.raw.technology["basic-electronics"].effects = {}
data.raw.technology["basic-optics"].effects = {}
data.raw.technology["improved-equipment"].effects = {}
data.raw.technology["circuit-network"].effects = {}
data.raw.technology["automated-rail-transportation"].effects = {}
data.raw.technology["rail-signals"].effects = {}

data.raw["produce-achievement"]["mass-production-1"] = nil
data.raw["produce-achievement"]["mass-production-2"] = nil
data.raw["produce-achievement"]["mass-production-3"] = nil

remove_limitation("electronic-circuit")
--]]

--[[ REMOVE ]]
data.raw.recipe["railgun-dart"] = nil
data.raw.item["solar-panel"] = nil
data.raw.recipe["solar-panel"] = nil
data.raw["solar-panel"]["mock-solar-panel"] = data.raw["solar-panel"]["solar-panel"]
data.raw["solar-panel"]["mock-solar-panel"].name = "mock-solar-panel"
data.raw["solar-panel"]["mock-solar-panel"].minable.result = "wood"
data.raw["solar-panel"]["mock-solar-panel"].order = "z-[mock]"
data.raw["solar-panel"]["solar-panel"] = nil
data.raw.item["laser-turret"] = nil
data.raw.recipe["laser-turret"] = nil
data.raw["electric-turret"]["mock-laser-turret"] = data.raw["electric-turret"]["laser-turret"]
data.raw["electric-turret"]["mock-laser-turret"].name = "mock-laser-turret"
data.raw["electric-turret"]["mock-laser-turret"].minable.result = "wood"
data.raw["electric-turret"]["mock-laser-turret"].order = "z-[mock]"
data.raw["electric-turret"]["laser-turret"] = nil
data.raw["dont-build-entity-achievement"]["raining-bullets"] = nil

--[[ REPLACE ]]
with_recipe_ingredients("rocket",
  {
    {"explosives", 1},
    {"iron-plate", 2}
  }
)
with_recipe_ingredients("poison-capsule",
  {
    {"steel-plate", 3},
    {"coal", 10}
  }
)
with_recipe_ingredients("slowdown-capsule",
  {
    {"steel-plate", 3},
    {"coal", 10}
  }
)
with_recipe_ingredients("gate",
  {
    {"stone-wall", 1}, 
    {"steel-plate", 2}, 
    {"simple-gear-box", 2}
  }
)
with_recipe_ingredients("rocket-launcher",
  {
    {"iron-plate", 5},
    {"iron-gear-wheel", 5},
  }
)
with_recipe_ingredients("oil-refinery",
  {
    {"steel-plate", 15},
    {"simple-gear-box", 2},
    {"stone-brick", 10},
    {"engine-unit", 8},
    {"pipe", 10}
  }
)

--[[ Uranium-processing ]]
with_recipe_ingredients("uranium-processing",
  {
    {"uranium-ore", 1}
  }
)

--[[  ]]
