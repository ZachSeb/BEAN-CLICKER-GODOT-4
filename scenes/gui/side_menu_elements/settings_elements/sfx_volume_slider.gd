extends SettingsSlider

func on_slider_changed(value: float) -> void:
	Settings.sfx_volume = value


func refresh(_reset):
	$HSlider.value = Settings.sfx_volume
