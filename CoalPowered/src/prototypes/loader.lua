
--[[ data:extend{
 {
    type = "recipe",
    name = "loader",
    ingredients = {
      {"transport-belt", 2},
      {"iron-gear-wheel", 5},
      {"iron-plate", 2},
    },
    result = "loader"
  },
  {
    type = "recipe",
    name = "fast-loader",
    enabled = false,
    ingredients = {
      {"loader", 1},
      {"simple-gear-box", 2},
    },
    result = "fast-loader"
  },
  {
    type = "recipe",
    name = "express-loader",
    enabled = false,
    ingredients = {
      {"fast-loader", 1},
      {"advanced-gear-box", 2},
    },
    result = "express-loader"
 },
}
--]] 

with (data.raw.technology["logistics-2"], 
  {  
--[[    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "fast-transport-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "fast-underground-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "fast-splitter"
      },
      {
        type = "unlock-recipe",
        recipe = "fast-loader"
      }
    },
--]]
  }
)

with (data.raw.technology["logistics-3"], 
  {
--[[    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "express-transport-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "express-underground-belt"
      },
      {
        type = "unlock-recipe",
        recipe = "express-splitter"
      },
      {
        type = "unlock-recipe",
        recipe = "express-loader"
      }
    },
--]]
  }
)

with (data.raw.recipe["splitter"],
  {
    enabled = true,
    ingredients =
    {
      {"iron-gear-wheel", 10},
      {"iron-plate", 5},
      {"transport-belt", 4}
    },
  }
) 

with (data.raw.recipe["fast-splitter"],
  {
    ingredients =
    {
      {"splitter", 1},
      {"simple-gear-box", 3},
    },
  }
) 

with (data.raw.recipe["express-splitter"],
  {
    category = "crafting",
    ingredients =
    {
      {"fast-splitter", 1},
      {"advanced-gear-box", 3},
    }
  }
)

with (data.raw.recipe["fast-underground-belt"],
  {
    ingredients =
    {
      {"underground-belt", 2},
      {"simple-gear-box", 5},
    },
  }
) 

with (data.raw.recipe["express-underground-belt"],
  {
    category = "crafting",
    ingredients =
    {
      {"fast-underground-belt", 2},
      {"advanced-gear-box", 5},
    }
  }
) 

with (data.raw.recipe["fast-transport-belt"],
  {
    ingredients =
    {
      {"transport-belt", 1},
      {"simple-gear-box", 1},
    },
  }
) 

with (data.raw.recipe["express-transport-belt"],
  {
    category = "crafting",
    enabled = false,
    ingredients =
    {
      {"fast-transport-belt", 1},
      {"advanced-gear-box", 1},
    },
    result = "express-transport-belt"
  },
  { "normal", "expensive" }
) 
