extends SettingsSlider
	

func on_slider_changed(value):
	Settings.music_volume = value
	
	
func refresh():
	$HSlider.value = Settings.music_volume
	
