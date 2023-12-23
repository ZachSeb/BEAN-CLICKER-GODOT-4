extends Label


func _ready():
	SettingsSignals.display_fps_visibility_changed.connect(update_visibilty)
	
	
func update_visibilty(state):
	$".".visible = state


func _process(_delta):
	$".".text = (str(Engine.get_frames_per_second(), " FPS"))
