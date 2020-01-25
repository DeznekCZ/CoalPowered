
data.raw.recipe.radar.enabled = false
data.raw["radar"]["radar"].energy_source = new_burner{
  emissions = 0.05,
    extra = {usage_priority = "secondary-input"}
}
with_recipe_ingredients("radar",
  {
    {"stone-furnace", 1},
    {"simple-gear-box", 1},
    {"iron-plate", 10}
  }
)

data:extend{
  {
    type = "technology",
    name = "radar-technology",
    localised_name = { "entity-name.radar" },
    localised_description = { "technology-description.radar" },
    icon = "__CoalPowered__/graphics/technology/radar.png",
    icon_size = 256,
    prerequisites = { "military", "gearing" },
    effects = 
    {
      {
        type = "unlock-recipe",
        recipe = "radar"
      }
    },
    unit = {
      count = 20,
      ingredients = 
      {
        {"automation-science-pack", 1},
      },
      time = 10
    },
    order = "a-b-c"
  }
}