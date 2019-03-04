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
          position = { -0.2, 0.8 },
          starting_vertical_speed = 0.04,
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

with (data.raw.recipe["personal-roboport-equipment"], 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"plastic-bar", 20},
      {"advanced-gear-box", 10}
    },
  }
)

with (data.raw.recipe["personal-laser-defense-equipment"],
  {
    ingredients =
    {
      {"iron-gear-wheel", 5},
      {"copper-plate", 5},
      {"iron-plate", 10}
    },
  }
)

with (data.raw["active-defense-equipment"]["personal-laser-defense-equipment"],
  {
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      buffer_capacity = "0J"
    },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 12,
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
        energy_consumption = "0J",
        action = 
        {
          type = "direct",
          action_delivery = 
          {
            type = "instant",
            target_effects = {
              type = "damage",
              damage =
              {
                amount = 10,
                type = "physical"
              }
            }
          }
        }
      },
      range = 18,
      sound = make_heavy_gunshot_sounds()
    },
  }
)