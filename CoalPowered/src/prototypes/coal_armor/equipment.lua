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
          frequency = 5,
          position = { 0.0, -0.8 },
          starting_vertical_speed = 0.08,
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