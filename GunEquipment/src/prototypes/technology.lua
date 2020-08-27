data:extend(
{
  {
    type = "technology",
    name = "personal-turret-equipment",
    icon = "__GunEquipment__/graphics/technology/personal-turret-equipment.png",
    icon_size = 128,
    prerequisites = { "modular-armor", "turrets", "military-science-pack" },
    effects = 
    {
      {
        type = "unlock-recipe",
        recipe = "personal-turret-equipment"
      }
    },
    unit = {
      count = 150,
      ingredients = 
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"military-science-pack", 1},
      },
      time = 15
    },
    order = "a-b-c"
  },
})