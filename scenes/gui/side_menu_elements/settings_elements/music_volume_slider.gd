extends SettingsSlider


func on_slider_changed(value: float) -> void:
	Settings.music_volume = value


func refresh(_reset):
	$HSlider.value = Settings.music_volume
