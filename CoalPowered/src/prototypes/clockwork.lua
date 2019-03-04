
--[[ Technology ]]

with (data.raw.technology["electric-engine"], 
  {
    localised_name = {"technology-name.clockwork-engine-unit"},
    localised_description = {"technology-description.clockwork-engine-unit"},
    -- TODO new icon for engine unit  
  }
)

--[[ Recipes ]]

data:extend{
  {
    type = "recipe",
    name = "copper-gear-wheel",
    normal =
    {
      ingredients = {{"copper-plate", 2}},
      result = "copper-gear-wheel"
    },
    expensive =
    {
      ingredients = {{"copper-plate", 4}},
      result = "copper-gear-wheel"
    }
  },
}

with (data.raw.recipe["electric-engine-unit"], 
  {
    ingredients =
    {
      {"copper-cable", 20},
      {"copper-gear-wheel", 5},
      {type="fluid", name= "lubricant", amount = 15},
    },
  }
)

with (data.raw.recipe["flying-robot-frame"], 
  {
    ingredients =
    {
      {"electric-engine-unit", 1},
      {"advanced-gear-box", 4},
      {"plastic-bar", 4},
      {"steel-plate", 1},
    },
  }
)

with (data.raw.recipe["construction-robot"], 
  {
    ingredients =
    {
      {"flying-robot-frame", 1},
      {"repair-pack", 5},
    },
  }
)

with (data.raw.recipe["logistic-robot"], 
  {
    ingredients =
    {
      {"flying-robot-frame", 1},
      {"fast-inserter", 1},
    },
  }
)

--[[ Items ]]

with (data.raw.item["electric-engine-unit"], 
  {
    localised_name = {"item-name.clockwork-engine-unit"},
    localised_description = {"item-description.clockwork-engine-unit"},
    -- TODO new icon for engine unit  
  }
)

data:extend{
  {
    type = "item",
    name = "copper-gear-wheel",
    icon = "__CoalPowered__/graphics/icons/copper-gear-wheel.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "c[copper-gear-wheel]",
    stack_size = 50
  },
}