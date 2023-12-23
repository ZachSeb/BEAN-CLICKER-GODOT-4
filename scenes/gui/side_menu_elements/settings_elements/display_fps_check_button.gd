extends SettingsCheckButton


func on_check_button_toggled(state: bool) -> void:
	SettingsSignals.display_fps_visibility_changed.emit(state)
