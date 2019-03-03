
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
