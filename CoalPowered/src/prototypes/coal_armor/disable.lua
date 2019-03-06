local to_remove = {
  ["solar-panel-equipment"] = "solar-panel-equipment",
  ["fusion-reactor-equipment"] = "generator-equipment",
  ["discharge-defense-equipment"] = "active-defense-equipment",
  ["energy-shield-equipment"] = "energy-shield-equipment",
  ["energy-shield-equipment-2"] = "energy-shield-equipment", -- TECH
  ["energy-shield-mk2-equipment"] = "energy-shield-equipment", -- ITEMS
  ["battery-equipment"] = "battery-equipment",
  ["battery-equipment-2"] = "battery-equipment", -- TECH
  ["battery-mk2-equipment"] = "battery-equipment", -- ITEMS
  ["discharge-defense-remote"] = "capsule",
  ["personal-laser-defense-equipment"] = "active-defense-equipment",
}

for name, type in pairs(to_remove) do
  if data.raw[type] then data.raw[type][name] = nil end
  data.raw.technology[name] = nil
  data.raw.item[name] = nil
  data.raw.recipe[name] = nil
end

-- data.raw.technology["solar-panel-equipment"].enabled = false

with (data.raw.technology["night-vision-equipment"],
  {
    prerequisites = {"portable-generator-equipment"}
  }
)

with (data.raw.technology["belt-immunity-equipment"],
  {
    prerequisites = {"portable-generator-equipment"}
  }
)

with (data.raw.technology["exoskeleton-equipment"],
  {
    prerequisites = { "portable-generator-equipment", "gearing-2" }
  }
)

with (data.raw.technology["personal-roboport-equipment"],
  {
    prerequisites = { "military-3", "low-density-structure", "power-armor", "portable-generator-equipment" }
  }
)