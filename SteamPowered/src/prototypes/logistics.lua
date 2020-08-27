
--[[ Technology ]]

--[[ Recipes ]]

with (data.raw.recipe["logistic-chest-passive-provider"], 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"steel-chest", 1},
      {"copper-cable", 20},
      {"plastic-bar", 10}
    },
  }
)

with (data.raw.recipe["logistic-chest-active-provider"], 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"steel-chest", 1},
      {"copper-cable", 20},
      {"plastic-bar", 10}
    },
  }
)

with (data.raw.recipe["logistic-chest-buffer"], 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"steel-chest", 1},
      {"copper-cable", 20},
      {"plastic-bar", 10}
    },
  }
)

with (data.raw.recipe["logistic-chest-requester"], 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"steel-chest", 1},
      {"copper-cable", 20},
      {"plastic-bar", 10}
    },
  }
)

with (data.raw.recipe["logistic-chest-storage"], 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"steel-chest", 1},
      {"copper-cable", 20},
      {"plastic-bar", 10}
    },
  }
)

--[[ Items ]]

--[[ Roboport ]]

with (data.raw["roboport"]["roboport"].energy_source,
{
  type = "void",
  fuel_category = "chemical",
  effectivity = 1,
  emissions = 0.02,
  fuel_inventory_size = 1,
  smoke =
  {
    {
      name = "smoke",
      frequency = 10,
      position = {0.7, -1.2},
      starting_vertical_speed = 0.08,
      starting_frame_deviation = 60
    }
  },
})

--with (data.raw.item["roboport"], {}, { "place_result" })
--data.raw["roboport"]["roboport"].order = data.raw.item["roboport"].order

with (data.raw.recipe["roboport"], 
{
  ingredients =
  {
    {"steel-plate", 45},
    {"advanced-gear-box", 45}
  },
})
