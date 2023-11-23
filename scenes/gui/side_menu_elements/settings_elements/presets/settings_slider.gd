extends Control
class_name SettingsSlider

@onready var slider = get_node("HSlider")


func _ready():
	slider.value_changed.connect(on_slider_changed)
	SaveFile.file_loaded.connect(refresh)
	

func on_slider_changed(value: float) -> void:
#	AudioServer.set_bus_volume_db(
#		bus_index,
#		linear_to_db(value)
#	)
	print(value)


func refresh():
	print("refresh")
