extends SettingsSlider


func on_slider_changed(value: float) -> void:
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
