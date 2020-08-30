
function generate_turret(magazine)
  local damage = 0
  local magazine_size = 1
  if data.raw.ammo[magazine] then
    local magazine_item = data.raw.ammo[magazine]
    magazine_size = magazine_item.magazine_size
    local action = 
      magazine_item
        .ammo_type
        .action;
    if action[1] then action = action[1] end
    local action_delivery =
      action
        .action_delivery;
    if action_delivery[1] then action_delivery = action_delivery[1] end
    damage =
      action_delivery
        .target_effects[2]
        .damage
        .amount;
  end
  local turret =
  {
    type = "active-defense-equipment",
    name = "personal-turret-" .. magazine .. "-equipment",
    localised_name = 
        { "item-name.personal-turret-equipment-info", { "item-name." .. magazine } },
    localised_description = {"item-description.personal-turret-equipment"},
    take_result = "personal-turret-equipment",
    sprite =
    {
      filename = "__GunEquipment__/graphics/equipment/personal-turret-equipment/" .. magazine .. ".png",
      width = 128,
      height = 128,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 2,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      buffer_capacity = magazine_size .. "MJ",
      input_flow_limit = "1W",
    },
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 10,
      movement_slow_down_factor = 0.1,
      projectile_creation_distance = 1.39375,
      projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {-0.0625, 0},
        creation_distance = -1.925,
        starting_frame_speed = 0.2,
        starting_frame_speed_deviation = 0.1
      },
      ammo_type = 
      {
        category = "bullet",
        energy_consumption = "1MJ",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              type = "create-explosion",
              entity_name = "explosion-gunshot"
            },
            target_effects =
            {
              {
                type = "create-entity",
                entity_name = "explosion-hit"
              },
              {
                type = "damage",
                damage = { amount = damage, type = "physical"}
              }
            }
          }
        }
      },
      range = 18,
      sound = require("__base__.prototypes.entity.demo-sounds").gun_turret_gunshot
    },

    automatic = true,
    categories = {"armor"}
  }
  if damage == 0 then
    turret.localised_name = { "item-name.personal-turret-equipment-info", { "description.no-ammo" } }
  end
  data:extend{ turret }
end

generate_turret("uranium-rounds-magazine")
generate_turret("piercing-rounds-magazine")
generate_turret("firearm-magazine")
generate_turret("no-magazine")