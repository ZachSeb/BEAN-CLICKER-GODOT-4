extends Control
class_name SettingsSlider

@onready var slider = get_node("HSlider")
var slider_value


func _ready():
	slider_value = slider.value
	on_slider_changed(slider_value)
	
	slider.value_changed.connect(func super_on_slider_changed(value):
		slider_value = value
		on_slider_changed(value)
	)
	
	SaveFile.file_loaded.connect(func super_file_loaded():
		slider.value = slider_value
	)
	

func on_slider_changed(value: float) -> void:
	print(value)
	
	
func save_stats():
	var save_dict = {
		"filename" : $".".get_path(),
		"slider_value" : slider_value
	}
	return save_dict

