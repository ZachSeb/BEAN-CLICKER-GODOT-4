extends SettingsSlider


func on_slider_changed(value):
	Settings.sfx_volume = value
	
	
func refresh():
	$HSlider.value = Settings.sfx_volume
