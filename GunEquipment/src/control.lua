
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