extends SettingsCheckButton


func on_check_button_pressed_child():
	Settings.bean_particles = $CheckButton.button_pressed


func refresh():
	$CheckButton.button_pressed = Settings.bean_particles
