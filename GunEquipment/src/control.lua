
AutoGun = require("AutoGun.control")

script.on_init(function()
	-- Nothing to do :-)
end)

script.on_load(function()
	-- Nothing to do :-)
end)

script.on_event(defines.events.on_tick, function(event)

  for pid,player in pairs(game.players) do
    AutoGun.OnTick(player)
  end
end)