
local function increase_consuption(inserter)
  data.raw.inserter[inserter].energy_per_movement
   = multiple_single_consuption( data.raw.inserter[inserter].energy_per_movement, 20 )
  data.raw.inserter[inserter].energy_per_rotation
   = multiple_single_consuption( data.raw.inserter[inserter].energy_per_rotation, 20 )
end

local function replace_energy(inserter)
  data.raw.inserter[inserter].energy_source = {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      smoke =
      {
        {
          name = "smoke",
          deviation = {0.1, 0.1},
          frequency = 9
        }
      }
    }
end

increase_consuption("inserter")
increase_consuption("long-handed-inserter")
increase_consuption("fast-inserter")
increase_consuption("filter-inserter")
increase_consuption("stack-inserter")
increase_consuption("stack-filter-inserter")

replace_energy("inserter")
replace_energy("long-handed-inserter")
replace_energy("fast-inserter")
replace_energy("filter-inserter")
replace_energy("stack-inserter")
replace_energy("stack-filter-inserter")

with_recipe_ingredients ("burner-inserter", 
  {
     { "iron-gear-wheel", 2 },
     { "iron-plate", 3 },
  }
)

with_recipe_ingredients ("inserter", 
  {
     { "iron-gear-wheel", 3 },
     { "iron-plate", 3 },
  }
)
with_recipe_ingredients ("long-handed-inserter", 
  {
     { "iron-gear-wheel", 3 },
     { "iron-plate", 5 },
  }
)
with_recipe_ingredients ("fast-inserter", 
  {
     { "inserter", 1 },
     { "simple-gear-box", 1 },
  }
)
with_recipe_ingredients ("filter-inserter", 
  {
     { "fast-inserter", 1 },
     { "iron-plate", 1 },
  }
)
with_recipe_ingredients ("stack-inserter", 
  {
     { "fast-inserter", 1 },
     { "advanced-gear-box", 1 },
     { "iron-plate", 2 },
  }
)
with_recipe_ingredients ("stack-filter-inserter", 
  {
     { "stack-inserter", 1 },
     { "iron-plate", 1 },
  }
)


