
local function generate_turret(magazine, damage)
  local turret =
  {
    type = "active-defense-equipment",
    name = "personal-turret-" .. magazine .. "-equipment",
    localised_name = 
        { "item-name.personal-turret-equipment-info", { "item-name." .. magazine } },
    localised_description = {"item-description.personal-turret-equipment"},
    take_result = "personal-turret-equipment",
    sprite =
    {
      filename = "__CoalPowered__/graphics/equipment/personal-turret-equipment/" .. magazine .. ".png",
      width = 128,
      height = 128,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 2,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      buffer_capacity = "1MJ",
      input_flow_limit = "1W",
    },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 6,
      movement_slow_down_factor = 0.1,
      projectile_creation_distance = 1.39375,
      projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {-0.0625, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      ammo_type = 
      {
        category = "bullet",
        energy_consumption = "1MJ",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              type = "create-explosion",
              entity_name = "explosion-gunshot"
            },
            target_effects =
            {
              {
                type = "create-entity",
                entity_name = "explosion-hit"
              },
              {
                type = "damage",
                damage = { amount = damage, type = "physical"}
              }
            }
          }
        }
      },
      range = 18,
      sound = make_heavy_gunshot_sounds()
    },

    automatic = true,
    categories = {"armor"}
  }
  if damage == 0 then
    turret.localised_name = { "item-name.personal-turret-equipment-info", { "description.no-ammo" } }
  end
  data:extend{ turret }
end

generate_turret("uranium-rounds-magazine", 24)
generate_turret("piercing-rounds-magazine", 8)
generate_turret("firearm-magazine", 5)
generate_turret("no-magazine", 0)

data:extend(
{
	{
		type = "generator-equipment",
    name = "portable-generator-equipment",
    sprite = {
      filename = "__CoalPowered__/graphics/equipment/portable-generator-equipment.png",
      width = 224,
      height = 224,
      priority = "medium"
		},
    shape = {
      width = 2,
      height = 3,
      type = "full"
  	},
  	burner =
  	{
  	  fuel_category = "chemical",
      effectivity = 0.25,
      emissions = 0.01,
      fuel_inventory_size = 2,
      smoke = {
        {
          name = "smoke",
          deviation = { 0.1, 0.1 },
          frequency = 30,
          west_position = { -0.2, -1.2 },
          south_position = { -0.2, -1.2 },
          east_position = { -0.2, -1.2 },
          north_position = { -0.2, -1.2 },
          starting_vertical_speed = 0.03,
          starting_frame_deviation = 60
        }
      }
  	},
    energy_source =
		{
      type = "burner",
      usage_priority = "secondary-output",
		},
    power = "250kW",
    categories = { "armor" }
  },
})
  
--[[ Recipes ]]

with (data.raw.recipe["exoskeleton-equipment"], 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"steel-plate", 20},
      {"copper-cable", 10},
      {"advanced-gear-box", 20}
    },
  }
)

with_recipe ("personal-roboport-equipment", 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"plastic-bar", 20},
      {"advanced-gear-box", 10}
    },
  }
)

with_recipe ("personal-roboport-equipment-2", 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"personal-roboport-equipment", 5},
      {"low-density-structure", 20},
      {"advanced-gear-box", 10}
    },
  }
)