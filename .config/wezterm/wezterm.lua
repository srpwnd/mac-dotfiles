local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "Gruvbox dark, soft (base16)"
config.use_fancy_tab_bar = false
config.send_composed_key_when_left_alt_is_pressed = true

return config
