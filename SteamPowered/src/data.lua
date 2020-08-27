--[[ UTIL ]]--

function string.equals( self, compared )
  if self ~= nil then
    return string.find(self,compared,1,true)
  else
    return false
  end
end

function with(data, changes, clear)
  if not data then return end
  if not clear then clear = {"_no_fields_"} end
  for k,v in pairs(changes) do
    data[k] = v
  end
  for _,v in pairs(clear) do
    data[v] = nil
  end
end

function with_remove(data, changes)
  if not data then return end
  if not changes then return end
  
  local to_remove = {}
  
  for key,item in pairs(data) do
    if changes(item) then
      table.insert(to_remove, { key = key }) 
    end
  end
  
  local i = #to_remove
  while i > 0 do
    data[to_remove[i].key] = nil
    i = i - 1
  end
end

recipe_data = data.raw.recipe
function with_recipe(name, changes, clear)
  with(recipe_data[name], changes, clear)
end

function with_recipe_ingredients(name, ingredients)
  with(recipe_data[name], 
    {
      ingredients = ingredients
    }
  )
end

function multiple_single_consuption(origin, value)
  local appendix = origin:gsub("[^%D]+", "")
  local number = origin:gsub("%D+", "")
  return (tonumber(number) * value) .. appendix
end

function new_burner(data)
  local burner_d = {
        type = "burner",
        fuel_category = data.fuel_category or "chemical",
        effectivity = data.efectivity or 1,
        fuel_inventory_size = data.fuel_inventory_size or 1,
        burnt_inventory_size = data.burnt_inventory_size,
        smoke =
        {
          {
            name = "smoke",
            frequency = data.frequency or 10,
            position = data.position or {0.7, -1.2},
            starting_vertical_speed = data.starting_vertical_speed or 0.08,
            starting_frame_deviation = data.starting_frame_deviation or 60
          }
        }
      }
  burner_d.emissions_per_second_per_watt = (data.emissions or 0.02) * --[[Effectivity counter]](0.001 / burner_d.effectivity)
  if data.extra then
    for var, val in pairs(data.extra) do
      burner_d[var] = val
    end
  end
  return burner_d
end

function remove_limitation(item_name)
  local limitation = data.raw.module["productivity-module"].limitation
  for key, value in pairs(limitation) do
    if string.find(value, item_name, 1, true) then
      limitation[key] = nil
      break
    end
  end 
  
  limitation = data.raw.module["productivity-module-2"].limitation
  for key, value in pairs(limitation) do
    if string.find(value, item_name, 1, true) then
      limitation[key] = nil
      break
    end
  end 
  
  limitation = data.raw.module["productivity-module-3"].limitation
  for key, value in pairs(limitation) do
    if string.find(value, item_name, 1, true) then
      limitation[key] = nil
      break
    end
  end 
end

function add_limitation(item_name)
  local key_found = false
  local limitation = data.raw.module["productivity-module"].limitation
  for key, value in pairs(limitation) do
    if string.find(value, item_name, 1, true) then
      key_found = true break
    end
  end
  if not key_found then limitation[#limitation + 1] = item_name end
  
  key_found = false
  limitation = data.raw.module["productivity-module-2"].limitation
  for key, value in pairs(limitation) do
    if string.find(value, item_name, 1, true) then
      key_found = true break
    end
  end 
  if not key_found then limitation[#limitation + 1] = item_name end
  
  key_found = false
  limitation = data.raw.module["productivity-module-3"].limitation
  for key, value in pairs(limitation) do
    if string.find(value, item_name, 1, true) then
      key_found = true break
    end
  end 
  if not key_found then limitation[#limitation + 1] = item_name end
end

require ("prototypes.upgrade")

data:extend{
  {
    type = "fluid",
    name = "cooling-fluid",
    base_color = {r=0, g=0.34, b=0.6},
    flow_color = {r=0.7, g=0.7, b=0.7},
    icon = "__SteamPowered__/graphics/icons/cooling-fluid.png",
    icon_size = 32,
    default_temperature = -5,
    max_temperature = -5,
    fuel_value = "800kJ",
    subgroup = "fluid-recipes",
    order = "e-[lubricant-cooling]",
    auto_barrel = true
  },
  {
    type = "recipe",
    name = "cooling-fluid",
    category = "chemistry",
    energy_required = 2,
    ingredients = {
      { type = "fluid", name = "light-oil", amount = 20 }
    },
    results = {
      { type = "fluid", name = "cooling-fluid", amount = 20 }
    },
    crafting_machine_tint = { primary = {r=0.52,g=1,b=0.96,a=0}, secondary = {r=0.52,g=1,b=0.96,a=0}, tertiary = {r=0.52,g=1,b=0.96,a=0}},
    enabled = false
  }
}

require ("prototypes.metalurgy")