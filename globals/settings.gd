extends Node


@export var master_volume = 0.8:
	get: return master_volume
	set(value):
		master_volume = value
		change_volume_of_bus(master_volume, "Master")
		
@export var music_volume = 0.8:
	get: return music_volume
	set(value):
		music_volume = value
		change_volume_of_bus(music_volume, "Music")
		
@export var sfx_volume = 0.8:
	get: return sfx_volume
	set(value):
		sfx_volume = value
		change_volume_of_bus(sfx_volume, "SFX")

# SCREEN MODE: 0 = WINDOWED, 1 = FULLSCREEN, 2 = BORDERLESS
@export var display_mode: int = 0:
	get: return display_mode
	set(value):
		display_mode = value
		set_display_mode(value)
		
@export var vsync_enabled: bool = true:
	get: return vsync_enabled
	set(value):
		vsync_enabled = value
		toggle_vsync(value)
		
signal display_fps_visiblity_changed
@export var display_fps: bool = false:
	get: return display_fps
	set(value):
		display_fps = value
		display_fps_visiblity_changed.emit()

signal toggle_particles_changed(particle: String)
@export var bean_particles: bool = true:
	get: return bean_particles
	set(value):
		bean_particles = value
		toggle_particles_changed.emit("Bean")
		
@export var text_particles: bool = true:
	get: return text_particles
	set(value):
		text_particles = value
		toggle_particles_changed.emit("Text")


#func set_data(loaded_data: Dictionary):
#	master_volume = loaded_data.MASTER_VOLUME
#	music_volume = loaded_data.MUSIC_VOLUME
#	sfx_volume = loaded_data.SFX_VOLUME
#
#	display_mode = loaded_data.DISPLAY_MODE
#	vsync_enabled = loaded_data.VSYNC_ENABLED
#	display_fps = loaded_data.DISPLAY_FPS
#
#	bean_particles = loaded_data.BEAN_PARTICLES
#	text_particles = loaded_data.TEXT_PARTICLES

func save_stats():
	var save_dict = {
		"filename" : $".".get_path(),
		
		"master_volume" : master_volume,
		"music_volume" : music_volume,
		"sfx_volume" : sfx_volume,
		"display_mode" : display_mode,
		"vsync_enabled" : vsync_enabled,
		"display_fps" : display_fps,
		"bean_particles" : bean_particles,
		"text_particles" : text_particles
	}
	return save_dict

var counter = 0
func _ready():
	set_display_mode(display_mode)
	toggle_vsync(vsync_enabled)
	
	counter += 1
	

func set_display_mode(value: int):
	if value == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		
	if value == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	if value == 2:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func toggle_vsync(value: bool):
	if value:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		

func change_volume_of_bus(value: float, bus_name: String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)
