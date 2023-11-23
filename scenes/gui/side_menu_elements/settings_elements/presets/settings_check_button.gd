extends Control
class_name SettingsCheckButton


func _ready():
	var check_button = get_node("CheckButton")
	
	check_button.pressed.connect(on_check_button_pressed_parent)
	SaveFile.file_loaded.connect(refresh)
	
	
func refresh(_reset):
	print("refresh settings check button")
	

func on_check_button_pressed_parent():
	$CheckPressSFX.play()
	on_check_button_pressed_child()


func on_check_button_pressed_child():
	print("custom function")
