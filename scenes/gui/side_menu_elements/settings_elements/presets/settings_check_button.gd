extends Control
class_name SettingsCheckButton

@export var checked: bool:
	get: return checked
	set(value):
		checked = value
		refresh()



func _ready():
	refresh()
	
	$CheckButton.pressed.connect(func super_on_check_button_pressed():
		checked = $CheckButton.button_pressed 
		$CheckPressSFX.play()
		on_check_button_pressed()
	)
	
	
func on_check_button_pressed():
	pass
	
	
func refresh():
	$CheckButton.button_pressed = checked
	
	
func save_stats() -> Dictionary:
	var save_dict = {
		"filename" : $".".get_path(),
		"checked" : checked
	}
	return save_dict
