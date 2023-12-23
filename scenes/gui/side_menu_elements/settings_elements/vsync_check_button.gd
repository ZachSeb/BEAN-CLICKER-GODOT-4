extends SettingsCheckButton


# CHILD FUNCTION
func on_check_button_toggled(state: bool) -> void:
	if state:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
