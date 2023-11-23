extends SettingsCheckButton

func refresh():
	$CheckButton.button_pressed = Settings.display_fps


func on_check_button_pressed_child():
	print(str($CheckButton.button_pressed))
	Settings.display_fps = $CheckButton.button_pressed
