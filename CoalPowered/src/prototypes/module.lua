
--[[ Locomotive ]]

--[[ Technology ]]

local technology = data.raw.technology

with (technology["modules"], 
  {
    prerequisites =
    {
      "gearing-2"
    }
  }
)

--[[ Recipes ]]

local recipe = data.raw.recipe

local modules = { "speed-module", "productivity-module", "effectivity-module" }

for _,module in pairs(modules) do
  with (recipe[module], 
    {
      category = "crafting-with-fluid",
      normal =
      {
        enabled = false,
        energy_required = recipe[module].energy_required,
        ingredients =
        {
          {"steel-gear-set", 5},
          {"steel-stick", 4},
          {"steel-plate", 1},
          {type="fluid", name="lubricant", amount=20}
        },
        result = module
      },
      expensive =
      {
        enabled = false,
        energy_required = recipe[module].energy_required + 5,
        ingredients =
        {
          {"steel-gear-set", 10},
          {"steel-stick", 4},
          {"steel-plate", 1},
          {type="fluid", name="lubricant", amount=40}
        },
        result = module
      }
    }
  )
  with (technology[module .. "-2"], 
    {
      prerequisites =
      {
        module, "chemical-science-pack"
      }
    }
  )
  with (recipe[module .. "-2"], 
    {
      category = "crafting-with-fluid",
      ingredients =
      {
        {module, 4},
        {"steel-plate", 1},
        {type="fluid", name="lubricant", amount=5}
      }
    }
  )
  with (technology[module .. "-3"], 
    {
      prerequisites =
      {
        module .. "-2", "production-science-pack"
      }
    }
  )
  with (recipe[module .. "-3"], 
    {
      category = "crafting-with-fluid",
      ingredients =
      {
        {module .. "-2", 4},
        {type="fluid", name="lubricant", amount=5}
      }
    }
  )
end

data:extend{
  {
    type = "recipe",
    name = "steel-gear-set",
    normal =
    {
      ingredients = {{"steel-plate", 2}},
      result = "steel-gear-set",
      result_count = 5,
      energy_required = 2.5,
      enabled = false,
    },
    expensive =
    {
      ingredients = {{"steel-plate", 4}},
      result = "steel-gear-set",
      result_count = 5,
      energy_required = 2.5,
      enabled = false,
    }
  },
  {
    type = "recipe",
    name = "steel-stick",
    ingredients = {{"steel-plate", 1}},
    result = "steel-stick",
    energy_required = 1,
    result_count = 2,
    enabled = false,
  },
}
table.insert(data.raw.technology["steel-processing"].effects, 
  {
    type = "unlock-recipe",
    recipe = "steel-gear-set"  
  }
)
table.insert(data.raw.technology["steel-processing"].effects, 
  {
    type = "unlock-recipe",
    recipe = "steel-stick"  
  }
)
add_limitation("steel-gear-set")
add_limitation("steel-stick")

--[[ Items ]]

data:extend{
  {
    type = "item",
    name = "steel-gear-set",
    icon = "__CoalPowered__/graphics/icons/steel-gear-set.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "c[steel-gear-wheel]",
    stack_size = 100
  },
  {
    type = "item",
    name = "steel-stick",
    icon = "__CoalPowered__/graphics/icons/steel-stick.png",
    icon_size = 32,
    subgroup = "intermediate-product",
    order = "b[steel-stick]",
    stack_size = 100
  },
}
