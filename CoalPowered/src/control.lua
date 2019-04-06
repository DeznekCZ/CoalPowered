
script.on_init(function()
	-- Nothing to do :-)
end)

local magazines = {
  "uranium-rounds-magazine", "piercing-rounds-magazine", "firearm-magazine" 
}

local function reload_unloaded(grid, weapon_ref, ammoInv, characterInv, magazine)
  local ammo_stack = ammoInv.find_item_stack(magazine)
  local inv = ammoInv
  local weapon = weapon_ref.value
  
  if ammo_stack and ammo_stack.count > 0 and ammo_stack.ammo > 0 then
    -- ok
  else
    inv = characterInv
    ammo_stack = characterInv.find_item_stack(magazine)
  end
  
  if ammo_stack and ammo_stack.count > 0 and ammo_stack.ammo > 0 then
    
    if ammo_stack.ammo > 1 then
      if string.find(weapon.name, magazine, 1, true) then
        -- same weapon as magazines
      else -- switch weapon
        local pos = weapon.position
        grid.take{ equipment = weapon }
        weapon = grid.put{
            name = "personal-turret-" .. magazine .. "-equipment", 
            position = pos
        }
        weapon_ref.value = weapon
      end 
    
      weapon.energy = weapon.max_energy
      ammo_stack.ammo = ammo_stack.ammo - 1
      return true -- REFILLED
    elseif ammo_stack.ammo == 1 then
      weapon.energy = weapon.max_energy
      if ammo_stack.count > 1 then
        ammo_stack.ammo = ammo_stack.prototype.magazine_size
        ammo_stack.count = ammo_stack.count - 1
      else
        inv.remove(ammo_stack)
        -- No ammo (from refilling)
      end
      return true -- REFILLED
    else
      return false -- No ammo (unexpected state)
    end
  else
    if string.find(weapon.name, "no-magazine", 1, true) then
      -- was switched
    else -- switch weapon
      local pos = weapon.position
      grid.take{ equipment = weapon }
      weapon_ref.value = grid.put{
        name = "personal-turret-no-magazine-equipment", 
        position = pos
      }
    end 
    return false -- No ammo (empty invetory on start)
  end
end

local function reload(grid, ammoInv, characterInv)
  local missing = {}
  
  for id,weapon in pairs(grid.equipment) do
    if string.find(weapon.name, "personal-turret", 1, true)
        and weapon.energy ~= weapon.max_energy then
      missing[id] = weapon
    end
  end
  
  for id,weapon in pairs(missing) do
    local loaded = false
    local weapon_ref = { value = weapon }
    
    for _,magazine in pairs(magazines) do
      loaded = reload_unloaded(grid, weapon_ref, ammoInv, characterInv, magazine)
      if loaded then break end
    end
  end
end

script.on_event(defines.events.on_tick, function(event)

  for pid,player in pairs(game.players) do
    if not player.driving 
        and player.controller_type == defines.controllers.character then
      if player.character ~= nil and player.character.grid ~= nil then
        local grid = player.character.grid
        local ammo_inventory = player.get_inventory(defines.inventory.player_ammo)
        local main_inventory = player.get_main_inventory()
        reload(grid, ammo_inventory, main_inventory)
      end
    end
  end
end)