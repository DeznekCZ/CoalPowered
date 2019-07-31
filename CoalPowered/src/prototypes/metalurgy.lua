
local m_tech = {
  type = "technology",
  name = "metalurgy",
  icon_size = 128,
  icon = "__base__/graphics/technology/advanced-material-processing.png",
  enabled = true,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "gas-furnace"
    }
  },
  prerequisites = {'oil-processing'},
  unit = {
    count = 150,
    ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
    time = 30
  },
}

local m_recipe = {
  type = "recipe",
  name = "gas-furnace",
  ingredients = {{"steel-plate", 6}, {"pipe", 5}, {"stone-brick", 10}},
  result = "gas-furnace",
  energy_required = 3,
  enabled = false
}

local m_item = {
  type = "item",
  name = "gas-furnace",
  icon = "__base__/graphics/icons/electric-furnace.png",
  icon_size = 32,
  subgroup = "smelting-machine",
  order = "d[gas-furnace]",
  place_result = "gas-furnace",
  stack_size = 50
}

local b_electric_furnace = data.raw.furnace["electric-furnace"]
local b_storage_tank = data.raw["storage-tank"]["storage-tank"]
local b_fluid_box = util.table.deepcopy( b_storage_tank.fluid_box )
b_fluid_box.filter = "petroleum-gas"

local m_gas_furnace = util.table.deepcopy( b_electric_furnace )
m_gas_furnace.energy_source = {
  type = "fluid",
  emissions_per_minute = 4,
  fluid_box = b_fluid_box,
  burns_fluid = true,
  scale_fluid_usage = true
}
m_gas_furnace.crafting_speed = 3
m_gas_furnace.name = "gas-furnace"
m_gas_furnace.minable.result = "gas-furnace"
m_gas_furnace.energy_usage = "135kW"

data:extend{
  m_tech, m_recipe, m_item, m_gas_furnace
}

local void = {
  type = "furnace",
  icon = "__base__/graphics/icons/electric-furnace.png",
  icon_size = 32,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = {mining_time = 0.2, result = "electric-furnace"},
  max_health = 350,
  corpse = "medium-remnants",
  dying_explosion = "medium-explosion",
  resistances =
  {
    {
      type = "fire",
      percent = 80
    }
  },
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  module_specification =
  {
    module_slots = 2,
    module_info_icon_shift = {0, 0.8}
  },
  allowed_effects = {"consumption", "speed", "productivity", "pollution"},
  crafting_categories = {"smelting"},
  result_inventory_size = 1,
  crafting_speed = 3,
  energy_usage = "135kW",
  source_inventory_size = 1,
  energy_source =
  {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = 1
  },
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  working_sound =
  {
    sound =
    {
      filename = "__base__/sound/electric-furnace.ogg",
      volume = 0.7
    },
    apparent_volume = 1.5
  },
  animation =
  {
    layers =
    {
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-base.png",
        priority = "high",
        width = 129,
        height = 100,
        frame_count = 1,
        shift = {0.421875, 0},
        hr_version =
        {
          filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace.png",
          priority = "high",
          width = 239,
          height = 219,
          frame_count = 1,
          shift = util.by_pixel(0.75, 5.75),
          scale = 0.5
        }
      },
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-shadow.png",
        priority = "high",
        width = 129,
        height = 100,
        frame_count = 1,
        shift = {0.421875, 0},
        draw_as_shadow = true,
        hr_version =
        {
          filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-shadow.png",
          priority = "high",
          width = 227,
          height = 171,
          frame_count = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(11.25, 7.75),
          scale = 0.5
        }
      }
    }
  },
  working_visualisations =
  {
    {
      animation =
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-heater.png",
        priority = "high",
        width = 25,
        height = 15,
        frame_count = 12,
        animation_speed = 0.5,
        shift = {0.015625, 0.890625},
        hr_version =
        {
          filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-heater.png",
          priority = "high",
          width = 60,
          height = 56,
          frame_count = 12,
          animation_speed = 0.5,
          shift = util.by_pixel(1.75, 32.75),
          scale = 0.5
        }
      },
      light = {intensity = 0.4, size = 6, shift = {0.0, 1.0}, color = {r = 1.0, g = 1.0, b = 1.0}}
    },
    {
      animation =
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-1.png",
        priority = "high",
        width = 19,
        height = 13,
        frame_count = 4,
        animation_speed = 0.5,
        shift = {-0.671875, -0.640625},
        hr_version =
        {
          filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-1.png",
          priority = "high",
          width = 37,
          height = 25,
          frame_count = 4,
          animation_speed = 0.5,
          shift = util.by_pixel(-20.5, -18.5),
          scale = 0.5
        }
      }
    },
    {
      animation =
      {
        filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-2.png",
        priority = "high",
        width = 12,
        height = 9,
        frame_count = 4,
        animation_speed = 0.5,
        shift = {0.0625, -1.234375},
        hr_version =
        {
          filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-2.png",
          priority = "high",
          width = 23,
          height = 15,
          frame_count = 4,
          animation_speed = 0.5,
          shift = util.by_pixel(3.5, -38),
          scale = 0.5
        }
      }
    }
  },
  fast_replaceable_group = "furnace"
}

data.raw.fluid["petroleum-gas"].fuel_value = "600kJ"

