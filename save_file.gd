extends Node

const save_path = "user://save.dat"
signal file_loaded


func save_file():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var user_data = create_user_data()
	file.store_var(user_data)
	

func load_file():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if FileAccess.file_exists(save_path):
		var loaded_data = file.get_var()
		print(loaded_data)
		
		User.set_data(loaded_data)
		Settings.set_data(loaded_data)
		file_loaded.emit()

		
func reset_file():
	var default_variables = get_user_default_data()
	
	User.set_data(default_variables)
	Settings.set_data(default_variables)
	file_loaded.emit()
	
	
func create_user_data() -> Dictionary:
	var save_dict = {
		# -------------user data----------------
		"BEANS" : User.beans,
		"BEANS_PER_CLICK" : User.beans_per_click,
		"BEANS_PER_SECOND" : User.beans_per_second,
		
		"XP" : User.xp,
		"XP_REQUIREMENT" : User.xp_requirement,
		"XP_PER_CLICK" : User.xp_per_click,
		"XP_PER_BUILDING_PURCHASE" : User.xp_per_building_purchase,
		
		"FERTILIZER" : User.fertilizer,
		
		# -------------settings---------------
		
		# volume
		"MASTER_VOLUME" : Settings.master_volume,
		"MUSIC_VOLUME" : Settings.music_volume,
		"SFX_VOLUME" : Settings.sfx_volume,
		
		# video
		# DISPLAY MODE: 0 = WINDOWED, 1 = FULLSCREEN, 2 = BORDERLESS
		"DISPLAY_MODE" : Settings.display_mode,
		"VSYNC_ENABLED" : Settings.vsync_enabled,
		"DISPLAY_FPS" : Settings.display_fps,
		
		# graphics
		"BEAN_PARTICLES": true,
		"TEXT_PARTICLES": true
	}
	return save_dict


func get_user_default_data() -> Dictionary:
	var default_dict = {
		"BEANS" : 0,
		"BEANS_PER_CLICK" : 1,
		"BEANS_PER_SECOND" : 0,
		
		"XP" : 0,
		"XP_REQUIREMENT" : 100,
		"XP_PER_CLICK" : 0.2,
		"XP_PER_BUILDING_PURCHASE" : 5,
		
		"FERTILIZER" : 0,
		
		# -------------settings---------------
		
		# volume
		"MASTER_VOLUME" : 1,
		"MUSIC_VOLUME" : 0.8,
		"SFX_VOLUME" : 0.8,
		
		# video
		# DISPLAY MODE: 0 = WINDOWED, 1 = FULLSCREEN, 2 = BORDERLESS
		"DISPLAY_MODE" : 0,
		"VSYNC_ENABLED" : true,
		"DISPLAY_FPS" : false,
		
		# graphics
		"BEAN_PARTICLES": true,
		"TEXT_PARTICLES": true
	}
	return default_dict


func _on_file_loaded():
	print("biiiiasdfdasfdafdsa")
