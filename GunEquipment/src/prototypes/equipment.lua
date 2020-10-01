local mul = require('math3d').vector2.mul

function generate_turret(magazine)
  local gunshoot = require("__base__.prototypes.entity.demo-sounds").gun_turret_gunshot
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

  local magazine_localised_name
  local magazine_item = data.raw.ammo[magazine]
  if magazine_item then
    magazine_localised_name = magazine_item.localised_name
    -- log(serpent.block(magazine_item))

		-- icon of magazine
    if magazine_item.icon then
      table.insert(layers, {filename = magazine_item.icon, size = magazine_item.icon_size})
    else
      for _, icon_data in ipairs(magazine_item.icons) do
        icon_data = table.deepcopy(icon_data)
        icon_data.filename = icon_data.icon
        icon_data.size = icon_data.icon_size
        table.insert(layers, icon_data)
      end
    end

    magazine_size = magazine_item.magazine_size
    -- just copy the whole action. This means it will work with multiple complex effects like rampants incendiary ammo etc
    action = table.deepcopy(magazine_item.ammo_type.action)
  else
    table.insert(layers, {filename = '__core__/graphics/icons/alerts/ammo-icon-red.png', size = 64}) -- no ammo graphic
  end
  layers[2].scale = 0.5 * 64 / layers[2].size

  for i = 3, #layers do
    layers[i].scale = (layers[i].scale or 1) * 0.5 * 64 / layers[2].size -- YES, it's supposed to be layer[2].size and not layer[i].size
    -- scale is bugged, so we need a blank scale 1 image first for icons.
    -- https://forums.factorio.com/viewtopic.php?f=7&t=71480&p=433700&hilit=scale#p433700
    -- which means all other icons will be rescaled according to this value.

    -- layers[i].shift = mul(layers[i].shift or {0, 0}, layers[i].scale)
    -- If they are shifted we might need to adjust those values too by scaling them.
  end
  if magazine_item
      and magazine_item.reload_time
      and magazine_item.reload_time > 0
    then
    local load_layers = util.table.deepcopy(layers)
    table.insert(load_layers,{
      filename = '__core__/graphics/icons/alerts/no-building-material-icon.png',
      size = 64,
      scale = 0.50,
      shift = { x = 16, y = 16 },
      run_mode = "forward-then-backward",
      frame_count = 2,
      animation_speed = 30,
      repeat_count = magazine_item.reload_time / 30
    })
    
    local function load_turret(size)
      return {
        type = "active-defense-equipment",
        name = "personal-turret-" .. magazine .. "-equipment-reload-" .. size,
        localised_name = {
          "item-name.personal-turret-equipment-info", 
          magazine_localised_name or { "item-name." .. magazine }
        },
        localised_description = {"item-description.personal-turret-equipment"},
        take_result = "personal-turret-equipment",
        sprite =
        {
          layers = load_layers
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
          buffer_capacity = magazine_item.reload_time .. "J",
          input_flow_limit = "0W",
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
            energy_consumption = ( 1 + magazine_item.reload_time ) .. "J",
            action = action
          },
          range = 18,
          sound = gunshoot
        },
    
        automatic = true,
        categories = {"armor"}
      }
    end
    
    for size=1, magazine_size do
    	data:extend{ load_turret(size) }
    end
  end 
  
  local turret =
  {
    type = "active-defense-equipment",
    name = "personal-turret-" .. magazine .. "-equipment",
    localised_name = {
    	"item-name.personal-turret-equipment-info", 
    	magazine_localised_name or { "item-name." .. magazine }
    },
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
      buffer_capacity = magazine_size .. "J",
      input_flow_limit = "0W",
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
        energy_consumption = "1J",
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

-- data.raw.ammo["uranium-rounds-magazine"].reload_time = 2 * 60 -- 20 seconds

generate_turret("no-magazine")
for ammo_name, ammo in pairs(data.raw.ammo) do
  if ammo.ammo_type.category == 'bullet' then generate_turret(ammo_name) end
end
