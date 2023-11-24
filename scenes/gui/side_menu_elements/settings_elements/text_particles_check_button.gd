extends SettingsCheckButton


func on_check_button_pressed_child():
	Settings.text_particles = $CheckButton.button_pressed


func refresh():
	$CheckButton.button_pressed = Settings.text_particles
