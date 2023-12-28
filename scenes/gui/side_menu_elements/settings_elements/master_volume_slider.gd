extends SettingsSlider
	

func on_slider_changed(value):
	Settings.master_volume = value
	
	
func refresh():
	$HSlider.value = Settings.master_volume
	
