--[[

  Scrip:  AutoGun (Control)
  Author: Zdenek Novotny (DeznekCZ)
  
]]
AutoGun = { 
  magazines = { }
}

Energy_1MJ = 1000000

function AutoGun.AddMagazine(magazine)
  if game.item_prototypes[magazine] then
    local found = nil
    for _,exists in pairs(AutoGun.magazines) do
      found = found or string.match(exists,magazine)
      if found then break end
    end
    if not found then table.insert(AutoGun.magazines, magazine) end
  end
end

function AutoGun.ReloadUnloaded(grid, weapon_ref, ammoInv, characterInv, magazine)
  local ammo_stack = ammoInv.find_item_stack(magazine)
  local inv = ammoInv
  local weapon = weapon_ref.value
  
  if ammo_stack and ammo_stack.count > 0 then
    -- ok
  else
    inv = characterInv
    ammo_stack = characterInv.find_item_stack(magazine)
  end
  
  if ammo_stack and ammo_stack.count > 0 then
    
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
    
    weapon.energy = ammo_stack.ammo * Energy_1MJ
    -- game.players["DeznekCZ"].print("energy: " .. weapon.energy)
    
    if ammo_stack.count > 1 then
      ammo_stack.count = ammo_stack.count - 1
    else
      inv.remove(ammo_stack)
    end
    return true -- REFILLED
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

function AutoGun.Reload(grid, ammoInv, characterInv)
  local missing = {}
  
  for id,weapon in pairs(grid.equipment) do
    if string.find(weapon.name, "personal-turret", 1, true)
        and weapon.energy < Energy_1MJ then
      missing[id] = weapon
    end
  end
  
  for id,weapon in pairs(missing) do
    local loaded = false
    local weapon_ref = { value = weapon }
    
    for _,magazine in pairs(AutoGun.magazines) do
      loaded = AutoGun.ReloadUnloaded(grid, weapon_ref, ammoInv, characterInv, magazine)
      if loaded then break end
    end
  end
end

function AutoGun.DirectDamageType(prototype, damage)
  local ammo_type = prototype.get_ammo_type()
  for _,action in pairs(ammo_type.action) do
    if string.match(action.type, "direct") then
      for _,action_delivery in pairs(action.action_delivery) do
        if string.match(action_delivery.type, "instant") then
          for _,target_effect in pairs(action_delivery.target_effects) do
            if string.match(target_effect.type, "damage") then
              damage.value = target_effect.damage.amount
              return true
            end
          end
        end
      end
    end
  end
  return false
end

function AutoGun.OnInit()
  local damageCache = {}
  for item_name,item_prototype in pairs(game.item_prototypes) do
    local damage = { value = 0 }
    if string.match(item_prototype.type, "ammo")
      and string.match(item_name, ".*%-magazine")
      and AutoGun.DirectDamageType(item_prototype, damage) then
      AutoGun.AddMagazine(item_name)
      damageCache[item_name] = damage.value
    end
  end
  
  -- Sort by damage
  local origin = AutoGun.magazines
  local sorted = {}
  for i=1, #origin do
    local maximum = 0
    local higher
    local higher_name
  	for j,name in pairs(origin) do
  	  if damageCache[name] > maximum then
        higher = j
        higher_name = name
  	    maximum = damageCache[name]
  	  end
    end
    table.remove(origin, higher)
    table.insert(sorted, #sorted + 1, higher_name)
  end
  
  AutoGun.magazines = sorted
  -- game.players["DeznekCZ"].print("ammo types: " .. serpent.block(sorted))
end

function AutoGun.OnTick(player)
  if not player.driving 
      and player.controller_type == defines.controllers.character then
    if player.character ~= nil and player.character.grid ~= nil then
      local grid = player.character.grid
      local ammo_inventory = player.get_inventory(defines.inventory.character_ammo)
      local main_inventory = player.get_main_inventory()
      AutoGun.Reload(grid, ammo_inventory, main_inventory)
    end
  elseif player.driving 
      and player.vehicle ~= nil and player.vehicle.grid ~= nil then
    local grid = player.vehicle.grid
    local main_inventory = player.vehicle.get_inventory(defines.inventory.car_trunk)
    local character_inventory = player.get_main_inventory()
    AutoGun.Reload(grid, main_inventory, character_inventory)
  end
end

function AutoGun.OnTakeOut(weapon, grid, owner)
  
end

return AutoGun