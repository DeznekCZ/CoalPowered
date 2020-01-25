
data:extend{
  {
    type = "recipe-category",
    name = "upgrade-crafting"
  },
  {
    type = "item",
    name = "iron-scrap",
    icon = "__CoalPowered__/graphics/icons/iron-scrap.png",
    icon_size = 32,
    subgroup = "raw-resource",
    order = "e[iron-scrap]",
    stack_size = 50,
    allow_decomposition = false
  },
  {
    type = "recipe",
    name = "iron-plate-from-scrap",
    enabled = false,
    category = "smelting",
    energy_required = 2.2,
    ingredients = {{"iron-scrap", 1}},
    result = "iron-plate"
  },
  {
    type = "technology",
    name = "automation-4",
    icon = "__base__/graphics/technology/automation.png",
    icon_size = 128,
    prerequisites = { "automation-3", "utility-science-pack" },
    effects = 
    {
      {
        type = "unlock-recipe",
        recipe = "iron-plate-from-scrap"
      },
      {
        type = "unlock-recipe",
        recipe = "assembling-machine-4"
      }
    },
    unit = {
      count = 300,
      ingredients = 
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
      },
      time = 15
    },
    order = "a-b-c"
  },
}

local recipe_info_defaults = 
{
  name = "",
  type = "upgrade",
  source = { name = "", amount = 1 },
  target = { name = "", amount = 1 },
  icon = "",
  icon_size = 32,
  icon_mipmaps = 1,
  energy_required = 10,
  ingredients = {},
  results = {},
  subgroup = "",
  order = "",
  scrap_iron = 0,
  scrap_steel = 0,
  types = { upgrade = "upgrade", edit = "upgrade-edit", switch = "upgrade-switch", disassemble = "upgrade-disassemble" }
}

upgrade_info = 
{
  name = "",
  type = "upgrade",
  source = { name = "", amount = 1 },
  target = { name = "", amount = 1 },
  icon = "",
  icon_size = 32,
  icon_mipmaps = 1,
  energy_required = 10,
  ingredients = {},
  results = {},
  subgroup = "",
  order = "",
  scrap_iron = 0,
  scrap_steel = 0,
  types = { upgrade = "upgrade", edit = "upgrade-edit", switch = "upgrade-switch", disassemble = "upgrade-disassemble" }
}

local function upgrade_localised(item_id)
  local item_entry = data.raw.item[item_id]
  
  if item_entry.localised_name then 
    return item_entry.localised_name
  elseif item_entry.place_result then
    return { "entity-name." .. item_id }
  elseif item_entry.place_as_tile then
    return { "tile-name." .. item_id }
  elseif item_entry.placed_as_equipment_result then
    return { "equipment-name." .. item_id }
  else
    return { "item-name." .. item_id }
  end
end

function upgrade_recipe(info_function)
  upgrade_info = util.table.deepcopy(recipe_info_defaults)
  info_function()
  
  local recipe = {
    type = "recipe",
    category = "upgrade-crafting",
    enabled = false,
    allow_decomposition = false,
    icon_size = upgrade_info.icon_size,
    icon_mipmaps = upgrade_info.icon_mipmaps,
  }
  if string.len(upgrade_info.name) > 0 then
    recipe.name = upgrade_info.type .. "-" .. upgrade_info.name
    recipe.localised_name = 
    { 
      "recipe-name." .. upgrade_info.type, 
      upgrade_localised(upgrade_info.source.name), 
      upgrade_localised(upgrade_info.target.name) 
    }
  elseif string.find(upgrade_info.type, upgrade_info.types.disassemble, 1, true) then
    recipe.name = upgrade_info.type .. "-" .. upgrade_info.source.name
    recipe.localised_name = 
    { 
      "recipe-name." .. upgrade_info.type, 
      upgrade_localised(upgrade_info.source.name)
    }
  else
    recipe.name = upgrade_info.type .. "-" .. upgrade_info.source.name .. "-to-" .. upgrade_info.target.name
    recipe.localised_name = 
    { 
      "recipe-name." .. upgrade_info.type, 
      upgrade_localised(upgrade_info.source.name), 
      upgrade_localised(upgrade_info.target.name) 
    }
    recipe.main_product = upgrade_info.target.name
  end
  recipe.energy_required = upgrade_info.energy_required
  
  recipe.ingredients = upgrade_info.ingredients
  table.insert( recipe.ingredients, 0, upgrade_info.source )
  
  recipe.results = upgrade_info.results
  if not string.find(upgrade_info.type, upgrade_info.types.disassemble, 1, true) then 
    table.insert( recipe.results, 0, upgrade_info.target ) 
  end
  
  if upgrade_info.scrap_iron > 0 then 
    table.insert( recipe.results, { "iron-scrap", upgrade_info.scrap_iron } ) 
  end
  
  if string.len(upgrade_info.icon) > 0 then
    recipe.icon = upgrade_info.icon
  else
    recipe.icon = data.raw.item[upgrade_info.target.name].icon
  end
  
  if string.len(upgrade_info.subgroup) > 0 then
    recipe.subgroup = upgrade_info.subgroup
  else
    recipe.subgroup = data.raw.item[upgrade_info.target.name].subgroup
  end
  
  if string.len(upgrade_info.order) > 0 then
    recipe.order = upgrade_info.order
  else
    recipe.order = data.raw.item[upgrade_info.target.name].order
  end
  
  table.insert(data.raw.technology["automation-4"].effects, { type = "unlock-recipe", recipe = recipe.name })
  data:extend{ 
    recipe
  }
end