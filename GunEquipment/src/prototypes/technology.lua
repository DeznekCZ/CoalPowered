data:extend(
{
  {
    type = "technology",
    name = "personal-turret-equipment",
    icons = {
      {
        icon = "__GunEquipment__/graphics/technology/personal-turret-equipment.png",
        icon_size = 256,
      },
      {
        icon = "__core__/graphics/icons/technology/constants/constant-equipment.png",
        icon_size = 128,
        scale = 0.5,
        shift = {50, 50}
      }
    },
    prerequisites = { "modular-armor", "gun-turret", "military-science-pack" },
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
  }
})