
AutoGun = require("AutoGun.control")
AutoGun.InitDone = false;

script.on_init(function()
  -- nothing
end)

script.on_load(function()
  -- nothing
end)

script.on_event(defines.events.on_tick, function(event)
  if not AutoGun.InitDone then
    AutoGun.OnInit()
    AutoGun.InitDone = true
  end

  for pid,player in pairs(game.players) do
    AutoGun.OnTick(player)
  end
end)

script.on_event({ 
      defines.events.on_built_entity, 
      defines.events.on_robot_built_entity
    }, function(event)
  AutoGun.OnEntityBuild(event.entity)
end)

local EntityEnded = function(event)
  AutoGun.OnEntityEnded(event.entity.unit_number)
end

script.on_event( defines.events.on_entity_died,         EntityEnded, {{filter = "vehicle"}} )
script.on_event( defines.events.on_player_mined_entity, EntityEnded, {{filter = "vehicle"}} )
script.on_event( defines.events.on_robot_mined_entity,  EntityEnded, {{filter = "vehicle"}} )
script.on_event( defines.events.on_object_destroyed,    function(event)
  AutoGun.OnEntityEnded(event.registration_number)
end )


