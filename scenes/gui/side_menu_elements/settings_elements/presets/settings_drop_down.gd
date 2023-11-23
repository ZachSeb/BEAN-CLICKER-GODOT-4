extends Control
class_name SettingsDropDown

func _ready():
	var dropdown = get_node("OptionButton")
	dropdown.item_selected.connect(on_item_selected)
	SaveFile.file_loaded.connect(refresh)
	
	
func refresh(_reset):
	print('refresh')
	
	
func on_item_selected(_index: int):
	printerr("custom drop down ", self.name, " doesn't have custom function")
