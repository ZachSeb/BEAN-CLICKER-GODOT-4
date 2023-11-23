extends Control


@export var tab_group: ButtonGroup
@export var open_close_duration = 0.6
var open: bool = true


func _on_top_menu_change_state(state: String):
	for states in $MenuStates.get_children():
		states.visible = false
		
	
		
	if state == "Shop":
		$MenuStates/Shop.visible = true

	elif state == "Upgrades":
		$MenuStates/Upgrades.visible = true

	elif state == "Settings":
		$MenuStates/Settings.visible = true

	elif state == "Achievements":
		$MenuStates/Achievements.visible = true
		
	else:
		print(str(state, " is not valid"))
		

# settings
func _on_save_button_pressed():
	SaveFile.save_file()


func _on_load_button_pressed():
	SaveFile.load_file()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_reset_button_pressed():
	SaveFile.reset_file()



