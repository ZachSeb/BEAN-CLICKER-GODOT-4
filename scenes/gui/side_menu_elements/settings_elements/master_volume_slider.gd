extends SettingsSlider


func on_slider_changed(value: float) -> void:
	Settings.master_volume = value


func refresh(_reset):
	$HSlider.value = Settings.master_volume
