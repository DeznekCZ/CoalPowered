
--[[ Equipments ]]

data:extend{
  {
    type = "equipment-category",
    name = "mock"
  },
  {
    type = "solar-panel-equipment",
    name = "mock-solar-panel-equipment",
    sprite =
    {
      filename = "__base__/graphics/equipment/solar-panel-equipment.png",
      width = 32,
      height = 32,
      priority = "medium"
    },
    shape =
    {
      width = 1,
      height = 1,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "primary-output"
    },
    power = "30kW",
    categories = {"mock"}
  },
  {
    type = "battery-equipment",
    name = "mock-battery-equipment",
    sprite =
    {
      filename = "__base__/graphics/equipment/battery-equipment.png",
      width = 32,
      height = 64,
      priority = "medium"
    },
    shape =
    {
      width = 1,
      height = 2,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "20MJ",
      input_flow_limit = "200MW",
      output_flow_limit = "200MW",
      usage_priority = "tertiary"
    },
    categories = {"mock"}
  },
  {
    type = "energy-shield-equipment",
    name = "mock-energy-shield-equipment",
    sprite =
    {
      filename = "__base__/graphics/equipment/energy-shield-equipment.png",
      width = 64,
      height = 64,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 2,
      type = "full"
    },
    max_shield_value = 50,
    energy_source =
    {
      type = "electric",
      buffer_capacity = "120kJ",
      input_flow_limit = "240kW",
      usage_priority = "primary-input"
    },
    energy_per_shield = "20kJ",
    categories = {"mock"}
  },
}

--[[ Items ]]

data:extend{
  {
    type = "item",
    name = "mock-solar-panel-equipment",
    icon = "__base__/graphics/icons/solar-panel-equipment.png",
    icon_size = 32,
    placed_as_equipment_result = "mock-solar-panel-equipment",
    subgroup = "equipment",
    order = "a[energy-source]-a[solar-panel]",
    stack_size = 20
  },
  {
    type = "item",
    name = "mock-battery-equipment",
    icon = "__base__/graphics/icons/battery-equipment.png",
    icon_size = 32,
    placed_as_equipment_result = "mock-battery-equipment",
    subgroup = "equipment",
    order = "c[battery]-a[battery-equipment]",
    stack_size = 20
  },
  {
    type = "item",
    name = "mock-energy-shield-equipment",
    icon = "__base__/graphics/icons/energy-shield-equipment.png",
    icon_size = 32,
    placed_as_equipment_result = "mock-energy-shield-equipment",
    subgroup = "equipment",
    order = "b[shield]-a[energy-shield-equipment]",
    stack_size = 20
  },
}