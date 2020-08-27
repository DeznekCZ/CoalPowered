
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
    name = "copper-gear-set",
    normal =
    {
      ingredients = {{"copper-plate", 2}},
      result = "copper-gear-set"
    },
    expensive =
    {
      ingredients = {{"copper-plate", 4}},
      result = "copper-gear-set"
    }
  },
}
add_limitation("copper-gear-set")

with (data.raw.recipe["electric-engine-unit"], 
  {
    ingredients =
    {
      {"copper-cable", 20},
      {"copper-gear-set", 5},
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
      {"gyroscope", 1},
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
    name = "copper-gear-set",
    icon = "__SteamPowered__/graphics/icons/copper-gear-set.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "c[copper-gear-wheel]",
    stack_size = 100
  },
}

upgrade_recipe(function()
  upgrade_info.name = "robot-logistic-to-constuction"
  upgrade_info.type = upgrade_info.types.switch
  upgrade_info.source.name = "logistic-robot"
  upgrade_info.target.name = "construction-robot"
  upgrade_info.icon_size = 64
  upgrade_info.icon_mipmaps = 4
  upgrade_info.energy_required = 2
  upgrade_info.ingredients =
  {
    {"repair-pack", 5},
  }
  upgrade_info.results = 
  {
    {"fast-inserter", 1},
  }
end)

upgrade_recipe(function()
  upgrade_info.name = "robot-constuction-to-logistic"
  upgrade_info.type = upgrade_info.types.switch
  upgrade_info.source.name = "construction-robot"
  upgrade_info.target.name = "logistic-robot"
  upgrade_info.icon_size = 64
  upgrade_info.icon_mipmaps = 4
  upgrade_info.energy_required = 2
  upgrade_info.ingredients =
  {
    {"fast-inserter", 1},
  }
  upgrade_info.results = 
  {
    {"repair-pack", 5},
  }
end)