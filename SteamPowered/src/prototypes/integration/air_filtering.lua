
if data.raw.recipe["air-filter-machine"] then
  with_recipe_ingredients("air-filter-machine",
    {
      {"engine-unit", 4},
      {"simple-gear-box", 4},
      {"steel-plate", 10}
    }
  )
  
  with_recipe_ingredients("air-filter-machine-mk2",
    {
      {"air-filter-machine", 2},
      {"advanced-gear-box", 4}
    }
  )
  
  with_recipe_ingredients("air-filter-machine-mk3",
    {
      {"air-filter-machine-mk2", 2},
      {"speed-module", 4}
    }
  )
  
  with (data.raw.technology["air-filtering"],
    {
      prerequisites = {"plastics", "steel-processing", "automation-2"},
    }
  )
  
  with (data.raw.technology["air-filtering-mk2"],
    {
      prerequisites = {"chemical-science-pack", "air-filtering"},
    }
  )
  
  with (data.raw.technology["air-filter-recycling"],
    {
      prerequisites = {"chemical-science-pack", "air-filtering"},
    }
  )
  
  with (data.raw.technology["air-filtering-mk3"],
    {
      prerequisites = {"production-science-pack", "air-filtering-mk2"},
    }
  )
  
  data.raw.furnace["air-filter-machine"].energy_source = new_burner{
    effectivity = 1,
    emissions = -0.06
  }
  
  data.raw.furnace["air-filter-machine-mk2"].energy_source = new_burner{
    effectivity = 1,
    emissions = -0.12
  }
  
  data.raw.furnace["air-filter-machine-mk3"].energy_source = new_burner{
    effectivity = 1,
    emissions = -0.3
  }
end