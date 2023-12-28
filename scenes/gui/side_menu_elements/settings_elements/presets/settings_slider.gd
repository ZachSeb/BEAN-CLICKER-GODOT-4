extends Control
class_name SettingsSlider


func _ready():
	refresh()
	
	SaveFile.file_loaded.connect(refresh)
	$HSlider.value_changed.connect(on_slider_changed)


func on_slider_changed(value):
	pass
	
	
func refresh():
	pass
