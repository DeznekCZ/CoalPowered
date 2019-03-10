
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
    stack_size = 50
  },
  {
    type = "recipe",
    name = "iron-plate-from-scrap",
    category = "smelting",
    energy_required = 2.2,
    ingredients = {{"iron-scrap", 1}},
    result = "iron-plate"
  },
}

local recipe_info_defauls = 
{
  name = "",
  source = { name = "", amount = 1 },
  target = { name = "", amount = 1 },
  icon = "",
  energy_required = 10,
  ingredients = {},
  results = {},
  subgroup = "",
  order = "",
  scrap_iron = 0,
  scrap_steel = 0,
}

upgrade_info = 
{
  name = "",
  source = { name = "", amount = 1 },
  target = { name = "", amount = 1 },
  icon = "",
  energy_required = 10,
  ingredients = {},
  results = {},
  subgroup = "",
  order = "",
  scrap_iron = 0,
  scrap_steel = 0,
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
  upgrade_info = util.table.deepcopy(recipe_info_defauls)
  info_function()
  
  local recipe = {
    type = "recipe",
    category = "upgrade-crafting",
    icon_size = 32,
    enabled = true, -- TODO
  }
  if string.len(upgrade_info.name) > 0 then
    recipe.name = "upgrade-" .. upgrade_info.name
  else
    recipe.name = "upgrade-" .. upgrade_info.source.name .. "-to-" .. upgrade_info.target.name
  end
  recipe.energy_required = upgrade_info.energy_required
  
  recipe.localised_name = 
  { 
    "recipe-name.upgrade", 
    upgrade_localised(upgrade_info.source.name), 
    upgrade_localised(upgrade_info.target.name) 
  }
  
  recipe.ingredients = upgrade_info.ingredients
  table.insert( recipe.ingredients, 0, upgrade_info.source )
  
  recipe.results = upgrade_info.results
  table.insert( recipe.results, 0, upgrade_info.target )
  
  if upgrade_info.iron_scrap > 0 then 
    table.insert( recipe.results, { "iron-scrap", upgrade_info.iron_scrap } ) 
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
  
  data:extend{ 
    recipe
  }
end