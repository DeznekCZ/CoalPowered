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
     {"electric-engine-unit", 1},
     {"steel-furnace", 1},
     {"steel-plate", 4},
     {"advanced-circuit", 5}
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

with (technology["rocket-silo"], 
  {
    prerequisites = { "concrete", "speed-module-3", "productivity-module-3", "rocket-fuel", "utility-science-pack" }
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





