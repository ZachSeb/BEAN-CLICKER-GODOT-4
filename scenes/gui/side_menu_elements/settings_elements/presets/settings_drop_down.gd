extends Control
class_name SettingsDropDown

@onready var dropdown = get_node("OptionButton")
var selected_item


func _ready():
	selected_item = dropdown.selected
	on_item_selected(selected_item)

	
	dropdown.item_selected.connect(func super_on_item_selected(index: int):
		selected_item = dropdown.selected
		on_item_selected(index)
	)
	
	SaveFile.file_loaded.connect(func super_file_loaded():
		dropdown.selected = selected_item
		on_item_selected(selected_item)
	)
	
	
func on_item_selected(_index: int) -> void:
	pass
	

func save_stats():
	var save_dict = {
		"filename" : $".".get_path(),
		"selected_item" : selected_item
	}
	return save_dict
