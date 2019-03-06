
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
      ingredients =
      {
        {"simple-gear-box", 2},
        {"advanced-gear-box", 4},
        {"iron-plate", 2},
        {"iron-stick", 6}
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


--[[ Items ]]
