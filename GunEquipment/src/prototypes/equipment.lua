local gunshoot = require("__base__.prototypes.entity.demo-sounds").gun_turret_gunshot

function generate_turret(magazine)
  local action
  local magazine_size = 1

  local gun_turret = data.raw['ammo-turret']['gun-turret']
  local prep_layer_1 = gun_turret.preparing_animation.layers[1]
  function use_layer(layer) return
    {
      filename = layer.filename,
      priority = layer.priority,
      width = layer.width,
      height = layer.height,
      priority = layer.priority,
      scale = (layer.scale or 1) * 1.2,
      x = 0 * (layer.width),
      y = 3 * (layer.height),
    }
  end
  local layers = {
    use_layer(prep_layer_1)
  }
  layers[1].hr_version = use_layer(prep_layer_1.hr_version)

  if data.raw.ammo[magazine] then
    local magazine_item = data.raw.ammo[magazine]
    -- log(serpent.block(magazine_item))

		-- icon of magazine
    table.insert(layers, {filename = magazine_item.icon, size = magazine_item.icon_size})

    magazine_size = magazine_item.magazine_size
    -- just copy the whole action. This means it will work with multiple complex effects like rampants incendiary ammo etc
    action = table.deepcopy(magazine_item.ammo_type.action)
  else
    table.insert(layers, {filename = '__core__/graphics/icons/alerts/ammo-icon-red.png', size = 64}) -- no ammo graphic
  end
  -- layers[2].shift = util.by_pixel(5, 5)
  layers[2].scale = 0.5 * 64 / layers[2].size
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
      layers = layers
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
      cooldown = 6,
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
        action = action
      },
      range = 18,
      sound = gunshoot
    },

    automatic = true,
    categories = {"armor"}
  }
  if not data.raw.ammo[magazine] then
    turret.localised_name = { "item-name.personal-turret-equipment-info", { "description.no-ammo" } }
  end
  data:extend{ turret }
end

generate_turret("no-magazine")
for ammo_name, ammo in pairs(data.raw.ammo) do
  if ammo.ammo_type.category == 'bullet' then generate_turret(ammo_name) end
end
