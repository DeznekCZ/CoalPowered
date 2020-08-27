data:extend(
{
	{
		type = "item",
		name = "portable-generator-equipment",
		icon = "__SteamPowered__/graphics/icons/portable-generator-equipment.png",
		icon_size = 32,
		placed_as_equipment_result = "portable-generator-equipment",
		subgroup = "equipment",
		order = "a[energy-source]-b[portable-generator-equipment]",
		stack_size = 10
  },
	{
		type = "item",
		name = "personal-turret-equipment",
		localised_name = { "item-name.personal-turret-equipment" },
		icon = "__SteamPowered__/graphics/icons/personal-turret-equipment.png",
		icon_size = 32,
		placed_as_equipment_result = "personal-turret-no-magazine-equipment",
		subgroup = "equipment",
		order = "a[active-defense]-b[personal-turret-equipment]",
		stack_size = 10
  },
})