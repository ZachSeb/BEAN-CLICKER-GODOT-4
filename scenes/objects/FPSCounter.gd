extends Label


func _ready():
	update_visibilty()
	Settings.connect("display_fps_visiblity_changed", on_display_fps_visiblity_changed)
	
	
func update_visibilty():
	$".".visible = Settings.display_fps
	

func on_display_fps_visiblity_changed():
	update_visibilty()
	

func _process(_delta):
	$".".text = (str(Engine.get_frames_per_second(), " FPS"))
