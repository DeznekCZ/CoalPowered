
require ("__base__/prototypes/entity/demo-pipecovers")

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

local b_storage_tank = data.raw["storage-tank"]["storage-tank"]
local b_fluid_box = util.table.deepcopy( b_storage_tank.fluid_box )
b_fluid_box.filter = "steam"
b_fluid_box.minimum_temperature = 100.0

local function fluid(frequency, a, b) 
  local smokes = {}
  if a then
    table.insert(smokes, {
        name = "light-smoke",
        north_position = {-0.7, -1.0},
        south_position = {-0.7, -1.0},
        east_position = {-0.7, -1.0},
        west_position = {-0.7, -1.0},
        frequency = 40 * frequency,
        starting_vertical_speed = 0.08,
        slow_down_factor = 1,
        starting_frame_deviation = 60
      })
  end
  if b then
    table.insert(smokes, {
        name = "light-smoke",
        north_position = {0.8, 0.2},
        south_position = {0.8, 0.2},
        east_position = {0.8, 0.2},
        west_position = {0.8, 0.2},
        frequency = 40 * frequency,
        starting_vertical_speed = 0.08,
        slow_down_factor = 1,
        starting_frame_deviation = 60
      })
  end
  
  return {
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
        { filter = "steam", type = "input-output", position = {-2, 0} },
        { filter = "steam", type = "input-output", position = {2, 0} }
      },
      production_type = "none"
    },
    burns_fluid = false,
    scale_fluid_usage = true,
    minimum_temperature = 100.0,
    smoke = smokes
  }
end


data.raw["assembling-machine"]["assembling-machine-1"]
    .energy_source = fluid(0.50, true, false)
data.raw["assembling-machine"]["assembling-machine-2"]
    .energy_source = fluid(0.75 / 2, true, true)
data.raw["assembling-machine"]["assembling-machine-3"]
    .energy_source = fluid(1.25, false, true)
data.raw["assembling-machine"]["assembling-machine-4"]
    .energy_source = fluid(2.00, false, true)