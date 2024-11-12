data:extend {
  {
    type = "recipe",
    name = "personal-turret-equipment",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="iron-gear-wheel", amount=5},
      {type="item", name="copper-plate", amount=5},
      {type="item", name="iron-plate", amount=10},
      {type="item", name="electronic-circuit", amount=10}
    },
    results = {
      { type="item", name="personal-turret-equipment", amount=1 }
    },
    allow_quality = false -- quality is planned to do, but is not required now
  },
}