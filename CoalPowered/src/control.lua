
script.on_init(function()
	for _,force in pairs(game.forces) do
		force.recipes["steam-engine"].enabled = false
	end
end)

local function reload(grid, ammoInv, characterInv, magazine, weapon)
  local missing = {}
  local give_ammo = false
  local ammo_stack = ammoInv.find_item_stack(magazine)
  if ammo_stack and ammo_stack.count > 0 and ammo_stack.ammo > 0 then
    for id,weq in pairs(grid.equipment) do
      if string.find(weapon, weq.name, 1, true) 
          and weq.energy ~= weq.max_energy then
        missing[id] = weq
      end
    end
    
    for id,weq in pairs(missing) do
      if ammo_stack.ammo > 1 then
        weq.energy = weq.max_energy
        ammo_stack.ammo = ammo_stack.ammo - 1
      elseif ammo_stack.ammo == 1 then
        weq.energy = weq.max_energy
        if ammo_stack.count > 1 then
          ammo_stack.ammo = game.item_prototypes[magazine].magazine_size
          ammo_stack.count = ammo_stack.count - 1
        else
          ammoInv.remove(ammo_stack)
          break -- No ammo (from refilling)
        end
      else
        break -- No ammo (empty invetory on start)
      end
    end
  else
    give_ammo = true
  end
  
  if give_ammo and #missing then
    ammo_stack = characterInv.find_item_stack(magazine)
    if ammo_stack and ammo_stack.count > 0 and ammo_stack.ammo > 0 then
      ammoInv.insert(ammo_stack)
      characterInv.remove(ammo_stack)
      ammo_stack = ammoInv.find_item_stack(magazine)
    end
  end
end

script.on_event(defines.events.on_tick, function(event)

  for pid,player in pairs(game.players) do
    if not player.driving 
        and player.controller_type == defines.controllers.character then
      if player.character ~= nil and player.character.grid ~= nil then
        reload(
            player.character.grid, 
            player.character.get_inventory(defines.inventory.player_ammo),
            player.character.get_main_inventory(), 
            "piercing-rounds-magazine", 
            "personal-laser-defense-equipment")
      end
    end
  end
end)
