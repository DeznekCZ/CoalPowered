
script.on_init(function()
	for _,force in pairs(game.forces) do
		force.recipes["steam-engine"].enabled = false
	end
end)