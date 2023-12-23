extends Control
class_name SettingsCheckButton

@onready var check_button = get_node("CheckButton")
var checked


func _ready():
	checked = check_button.button_pressed
	on_check_button_toggled(checked)
	
	check_button.toggled.connect(func super_on_check_button_toggled(state):
		checked = state
		$CheckPressSFX.play()
		on_check_button_toggled(state)
	)
	
	SaveFile.file_loaded.connect(func super_file_loaded():
		check_button.button_pressed = checked
	)


# CHILD FUNCTION
func on_check_button_toggled(_state: bool) -> void:
	pass


func save_stats():
	var save_dict = {
		"filename" : $".".get_path(),
		"checked" : checked
	}
	return save_dict
