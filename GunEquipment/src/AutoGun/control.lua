--[[

  Scrip:  AutoGun (Control)
  Author: Zdenek Novotny (DeznekCZ)

]]
AutoGun = {
  magazines = { },
  vehicles = { }
}

Energy_1MJ = 1000000
VehicleTypes = { "car", "tank", "train", "spider-vehicle" }

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
  elseif characterInv then
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
  damage.value = 0 -- clear value reference
  local ammo_type = prototype.get_ammo_type()
  for _,action in pairs(ammo_type.action) do
    if string.match(action.type, "direct") then
      for _,action_delivery in pairs(action.action_delivery) do
        if string.match(action_delivery.type, "instant") then
          for _,target_effect in pairs(action_delivery.target_effects) do
            if string.match(target_effect.type, "damage") then
            	-- some ammo has multiple direct instant damage sources
              damage.value = damage.value + target_effect.damage.amount
            end
          end
        end
      end
    end
  end
  return damage.value ~= 0
end

function AutoGun.OnInit()
  local damageCache = {}
  for item_name, item_prototype in pairs(game.get_filtered_item_prototypes{{filter = 'type', type = 'ammo'}}) do -- We don't have to loop through every item
    local damage = { value = 0 }
    if string.match(item_prototype.type, "ammo")
      and game.equipment_prototypes["personal-turret-" .. item_name .. "-equipment"] -- ammo is acceptable
      and AutoGun.DirectDamageType(item_prototype, damage) then
      AutoGun.AddMagazine(item_name)
      damageCache[item_name] = damage.value
    end
  end

  -- Sort by damage
  table.sort(AutoGun.magazines, function(a, b) return damageCache[a] > damageCache[b] end)

  -- load all vehicles with grid
  for _,surface in pairs(game.surfaces) do
    local vehicles = surface.find_entities_filtered {
      type = VehicleTypes
    }

    for _,vehicle in pairs(vehicles) do
      local grid = vehicle.grid
      if grid then
        AutoGun.vehicles[vehicle.unit_number] = vehicle
      end
    end
  end
end

function AutoGun.OnTick(player)
  if player.controller_type == defines.controllers.character then
    if player.character ~= nil and player.character.grid ~= nil then
      local grid = player.character.grid
      -- local ammo_inventory = player.get_inventory(defines.inventory.character_ammo)
      local main_inventory = player.get_main_inventory()
      AutoGun.Reload(grid, main_inventory, nil)
    end
  end

  if player.driving
      and player.vehicle ~= nil and player.vehicle.grid ~= nil then
    local grid = player.vehicle.grid
    local main_inventory = player.vehicle.get_inventory(defines.inventory.car_trunk)
    local character_inventory = player.get_main_inventory()
    AutoGun.Reload(grid, main_inventory, character_inventory)
  end

  for _,vehicle in pairs(AutoGun.vehicles) do
    if vehicle.valid then
      local driver = vehicle.get_driver()
      local passenger = nil
      if string.match(vehicle.type,"car") then
        passenger = vehicle.get_passenger()
      end
      if not driver and not passenger then
        -- game.players["DeznekCZ"].print("loading")
        local grid = vehicle.grid
        local main_inventory = vehicle.get_inventory(defines.inventory.car_trunk)
        if main_inventory then
          AutoGun.Reload(grid, main_inventory, nil)
        end
      end
    end
  end
end

function AutoGun.OnEntityBuild(entity)
  for _,Type in pairs(VehicleTypes) do
    Type = string.gsub(Type,"%-","%%-")
    if string.match(entity.type, Type) then
      AutoGun.vehicles[entity.unit_number] = entity

      break
    end
  end
end

function AutoGun.OnEntityEnded(unit_number)
  AutoGun.vehicles[unit_number] = nil
end

function AutoGun.OnTakeOut(weapon, grid, owner)

end

return AutoGun