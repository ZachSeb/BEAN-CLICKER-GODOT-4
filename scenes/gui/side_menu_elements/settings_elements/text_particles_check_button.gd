extends SettingsCheckButton


func on_check_button_toggled(state: bool) -> void:
	SettingsSignals.toggle_particles_changed.emit("Text", state)
