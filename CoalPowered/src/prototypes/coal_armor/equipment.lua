
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

with_recipe ("personal-roboport-mk2-equipment", 
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