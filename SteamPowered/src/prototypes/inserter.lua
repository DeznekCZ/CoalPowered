function assemblersteampipepictures()
  return
  {
    north =
    {
      filename = "__SteamPowered__/graphics/entity/assembling-machine-steam-pipes/assembling-machine-steam-pipe-N.png",
      priority = "extra-high",
      width = 35,
      height = 18,
      shift = util.by_pixel(2.5, 14),
      hr_version =
      {
        filename = "__SteamPowered__/graphics/entity/assembling-machine-steam-pipes/hr-assembling-machine-steam-pipe-N.png",
        priority = "extra-high",
        width = 71,
        height = 38,
        shift = util.by_pixel(2.25, 13.5),
        scale = 0.5
      }
    },
    east =
    {
      filename = "__SteamPowered__/graphics/entity/assembling-machine-steam-pipes/assembling-machine-steam-pipe-E.png",
      priority = "extra-high",
      width = 20,
      height = 38,
      shift = util.by_pixel(-25, 1),
      hr_version =
      {
        filename = "__SteamPowered__/graphics/entity/assembling-machine-steam-pipes/hr-assembling-machine-steam-pipe-E.png",
        priority = "extra-high",
        width = 42,
        height = 76,
        shift = util.by_pixel(-24.5, 1),
        scale = 0.5
      }
    },
    south =
    {
      filename = "__SteamPowered__/graphics/entity/assembling-machine-steam-pipes/assembling-machine-steam-pipe-S.png",
      priority = "extra-high",
      width = 44,
      height = 31,
      shift = util.by_pixel(0, -31.5),
      hr_version =
      {
        filename = "__SteamPowered__/graphics/entity/assembling-machine-steam-pipes/hr-assembling-machine-steam-pipe-S.png",
        priority = "extra-high",
        width = 88,
        height = 61,
        shift = util.by_pixel(0, -31.25),
        scale = 0.5
      }
    },
    west =
    {
      filename = "__SteamPowered__/graphics/entity/assembling-machine-steam-pipes/assembling-machine-steam-pipe-W.png",
      priority = "extra-high",
      width = 19,
      height = 37,
      shift = util.by_pixel(25.5, 1.5),
      hr_version =
      {
        filename = "__SteamPowered__/graphics/entity/assembling-machine-steam-pipes/hr-assembling-machine-steam-pipe-W.png",
        priority = "extra-high",
        width = 39,
        height = 73,
        shift = util.by_pixel(25.75, 1.25),
        scale = 0.5
      }
    }
  }
end

local function increase_consuption(inserter)
  data.raw.inserter[inserter].energy_per_movement
   = multiple_single_consuption( data.raw.inserter[inserter].energy_per_movement, 20 )
  data.raw.inserter[inserter].energy_per_rotation
   = multiple_single_consuption( data.raw.inserter[inserter].energy_per_rotation, 20 )
end

local function fluid(inserter, frequency) 
  data.raw.inserter[inserter].energy_source = {
    type = "fluid",
    emissions_per_minute = 4,
    effectivity = 2,
    fluid_box = {
      base_area = 1,
      pipe_covers = pipecoverspictures(),
      pipe_picture = assemblersteampipepictures(),
      secondary_draw_orders = { north = -1 },
      pipe_connections =
      {
        { filter = "steam", type = "input-output", position = {-1, 0} },
        { filter = "steam", type = "input-output", position = {1, 0} },
        { filter = "steam", type = "input-output", position = {0, -1} },
        { filter = "steam", type = "input-output", position = {0, 1} }
      },
      production_type = "none"
    },
    burns_fluid = false,
    scale_fluid_usage = true,
    minimum_temperature = 100.0,
    smoke =
    {
      {
        name = "light-smoke",
        north_position = {0.8, 0.2},
        south_position = {0.8, 0.2},
        east_position = {0.8, 0.2},
        west_position = {0.8, 0.2},
        frequency = 30 * frequency,
        starting_vertical_speed = 0.08,
        slow_down_factor = 1,
        starting_frame_deviation = 60
      }
    }
  }
end

--local function replace_energy(inserter)
--  data.raw.inserter[inserter].energy_source = {
--      type = "burner",
--      fuel_category = "chemical",
--      effectivity = 1,
--      fuel_inventory_size = 1,
--      smoke =
--      {
--        {
--          name = "smoke",
--          deviation = {0.1, 0.1},
--          frequency = 9
--        }
--      }
--    }
--end

--increase_consuption("inserter")
--increase_consuption("long-handed-inserter")
--increase_consuption("fast-inserter")
--increase_consuption("filter-inserter")
--increase_consuption("stack-inserter")
--increase_consuption("stack-filter-inserter")

--replace_energy("inserter")
--replace_energy("long-handed-inserter")
--replace_energy("fast-inserter")
--replace_energy("filter-inserter")
--replace_energy("stack-inserter")
--replace_energy("stack-filter-inserter")

fluid("inserter", 0.5)
fluid("long-handed-inserter", 0.75)
fluid("fast-inserter", 1)
fluid("filter-inserter", 1)
fluid("stack-inserter", 3)
fluid("stack-filter-inserter", 3)

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


