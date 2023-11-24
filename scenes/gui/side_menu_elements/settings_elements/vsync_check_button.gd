extends SettingsCheckButton


func refresh():
	$CheckButton.button_pressed = Settings.vsync_enabled
	

func on_check_button_pressed_child():
	Settings.vsync_enabled = $CheckButton.button_pressed
