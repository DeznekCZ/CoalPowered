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
data.raw.item["accumulator"].place_result = nil
data.raw.accumulator.accumulator.order = data.raw.item["accumulator"].order

--data.raw.accumulator.accumulator = nil
--data.raw["solar-panel"]["solar-panel"] = nil

--data.raw.recipe["steam-engine"] = nil
data.raw.recipe["steam-engine"].enabled = false
data.raw.recipe["boiler"].enabled = false

data.raw["dont-use-entity-in-energy-production-achievement"]["solaris"] = nil
data.raw["dont-use-entity-in-energy-production-achievement"]["steam-all-the-way"] = nil