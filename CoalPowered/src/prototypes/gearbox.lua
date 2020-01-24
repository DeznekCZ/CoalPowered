
--[[ Locomotive ]]
with (data.raw.recipe["locomotive"], 
  {
    ingredients =
    {
      {"engine-unit", 20},
      {"simple-gear-box", 10},
      {"steel-plate", 30}
    },
  }
)

--[[ Technology ]]

data:extend{
  {
    type = "technology",
    name = "gearing",
    icon_size = 128,
    icon = "__CoalPowered__/graphics/technology/gearing.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "simple-gear-box"
      }
    },
    unit =
    {
      count = 50,
      ingredients = {{"automation-science-pack", 1}},
      time = 5
    },
    order = "c-a"
  },
  {
    type = "technology",
    name = "gearing-2",
    icon_size = 128,
    icon = "__CoalPowered__/graphics/technology/gearing-2.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "advanced-gear-box"
      }
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 15
    },
    prerequisites = {"gearing", "lubricant", "steel-processing"},
    order = "c-a"
  },
}

--[[ Recipes ]]

data:extend{
  {
    type = "recipe",
    name = "simple-gear-box",
    category = "crafting",
    normal =
    {
      enabled = false,
      energy_required = 2,
      ingredients =
      {
        {"iron-gear-wheel", 5},
        {"iron-plate", 1},
        {"iron-stick", 4},
      },
      result = "simple-gear-box"
    },
    expensive =
    {
      enabled = false,
      energy_required = 3,
      ingredients =
      {
        {"iron-gear-wheel", 10},
        {"iron-stick", 4},
        {"iron-plate", 1},
      },
      result = "simple-gear-box"
    }
  },
  {
    type = "recipe",
    name = "advanced-gear-box",
    category = "crafting-with-fluid",
    normal =
    {
      enabled = false,
      energy_required = 6,
      ingredients =
      {
        {"iron-gear-wheel", 5},
        {"iron-stick", 4},
        {"steel-plate", 1},
        {type="fluid", name="lubricant", amount=20}
      },
      result = "advanced-gear-box"
    },
    expensive =
    {
      enabled = false,
      energy_required = 8,
      ingredients =
      {
        {"iron-gear-wheel", 10},
        {"iron-stick", 4},
        {"steel-plate", 1},
        {type="fluid", name="lubricant", amount=40}
      },
      result = "advanced-gear-box"
    }
  },
}

--[[ Items ]]

with(data.raw.item["iron-gear-wheel"],
  {
    localised_name = { "item-name.iron-gear-set" },
    icon = "__CoalPowered__/graphics/icons/iron-gear-set.png",
    icon_size = 32,
  }
)
data.raw.item["empty-barrel"].order = "d-b[empty-barrel]"
data:extend{
  {
    type = "item",
    name = "simple-gear-box",
    icon = "__CoalPowered__/graphics/icons/gearing.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "d-aa",
    stack_size = 50
  },
  {
    type = "item",
    name = "advanced-gear-box",
    icon = "__CoalPowered__/graphics/icons/gearing-2.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "d-ab",
    stack_size = 50
  },
}
