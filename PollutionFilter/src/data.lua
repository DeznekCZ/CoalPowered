

data:extend{
  {
    type = "recipe",
    name = "air-filtering",
    category = "chemistry",
    crafting_machine_tint =
    {
      primary = {r = 0.955, g = 0.945, b = 0.000, a = 0.000}, -- #f3f10000
      secondary = {r = 0.000, g = 0.441, b = 0.659, a = 0.898}, -- #0070a8e5
      tertiary = {r = 0.000, g = 0.288, b = 0.365, a = 0.000}, -- #00495d00
    },
    energy_required = 5,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="water", amount=100},
      {"pollution", 100},
      {"raw-wood", 5}
    },
    results=
    {
      {type="fluid", name="waste-water", amount=100},
    },
    subgroup = "fluid-recipes",
    order = "d[pollution]-a[air-filtering]",
  }
}