
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

--[[ spidertron ]]

data.raw.recipe["spidertron-remote"] = nil
data.raw.item["spidertron-remote"] = nil
data.raw.technology["spidertron"].effects = 
    {
      {
        type = "unlock-recipe",
        recipe = "spidertron"
      }
    }
data.raw.technology["spidertron"].prerequisites = {
  "military-4", "exoskeleton-equipment", "portable-generator-equipment", "rocketry", "gyroscope", "effectivity-module-3"
}

local function spidertron_clearout(ingredients)
  for _,ingredient in pairs(ingredients) do
    if string.find(ingredient[1], "fusion-reactor-equipment", 1, true) then
      ingredient[1] = "portable-generator-equipment";
      ingredient[2] = ingredient[2] * 3;
    elseif string.find(ingredient[1], "rocket-control-unit", 1, true) then
      ingredient[1] = "gyroscope";
      ingredient[2] = 8;
    end
  end
end

if data.raw.recipe["spidertron"].normal then
  spidertron_clearout(data.raw.recipe["spidertron"].normal.ingredients)

  if data.raw.recipe["spidertron"].expensive then
    spidertron_clearout(data.raw.recipe["spidertron"].expensive.ingredients)
  end
elseif data.raw.recipe["spidertron"].ingredients then
  spidertron_clearout(data.raw.recipe["spidertron"].ingredients)
end

data.raw["spider-vehicle"]["spidertron"].energy_source = new_burner{
  effectivity = 0.75,
  emissions = 0.02,
  fuel_inventory_size = 3
}
data.raw["spider-vehicle"]["spidertron"].movement_energy_consumption = "1200kW"

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
