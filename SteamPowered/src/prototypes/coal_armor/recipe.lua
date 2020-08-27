data:extend{
  {
    type = "recipe",
    name = "portable-generator-equipment",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      { "engine-unit", 20 },
      { "advanced-gear-box", 20 }
    },
    result = "portable-generator-equipment"
  },
  {
    type = "recipe",
    name = "personal-turret-equipment",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {"iron-gear-wheel", 5},
      {"copper-plate", 5},
      {"iron-plate", 10}
    },
    result = "personal-turret-equipment"
  },
}

with (data.raw.recipe["modular-armor"], 
  {
    ingredients =
    {
      {"simple-gear-box", 4},
      {"steel-plate", 50}
    },
  }
)

with (data.raw.recipe["power-armor"], 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"advanced-gear-box", 4},
      {"steel-plate", 50},
      {"effectivity-module", 5}, 
      {"speed-module", 5}
    },
  }
)

with (data.raw.recipe["power-armor-mk2"], 
  {
    category = "advanced-crafting",
    ingredients =
    {
      {"steel-plate", 50},
      {"low-density-structure", 30},
      {"effectivity-module-2", 25}, 
      {"speed-module-2", 25},
    },
  }
)
