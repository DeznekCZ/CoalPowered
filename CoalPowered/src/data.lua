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
        emissions = data.emissions or 0.02,
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