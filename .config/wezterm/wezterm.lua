local wezterm = require "wezterm"

function scheme_for_appearance(appearance)
	if appearance:find "Dark" then
		return "Catppuccin Macchiato"
	else
		return "Catppuccin Latte"
	end
end

return {
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
  use_fancy_tab_bar = false,
  send_composed_key_when_left_alt_is_pressed = true,
}
