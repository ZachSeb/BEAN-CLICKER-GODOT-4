extends SettingsCheckButton


# CHILD FUNCTION
func on_check_button_toggled(state: bool) -> void:
	SettingsSignals.toggle_particles_changed.emit("Bean", state)
