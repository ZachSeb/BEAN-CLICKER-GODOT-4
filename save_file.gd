extends Node

const save_path = "user://savegame.save"
signal file_loaded


func save_file():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save_stats"):
			print("persistent node '%s' is missing a save_stats() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save_stats")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)
		# Store the save dictionary as a new line in the save file.
		file.store_line(json_string)
		
	file_loaded.emit()
	

func load_file():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var loaded_items = 0
	while save_game.get_position() < save_game.get_length():
		
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()
		
		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = get_node(node_data["filename"])
			
		for i in node_data.keys():
			if i == "filename" or i == "parent":
				continue
			
			new_object.set(i, node_data[i])
		
		print("LOADED: ", new_object.name)
		loaded_items += 1
		
	print(loaded_items, " ITEMS LOADED")
	file_loaded.emit()

		
func reset_file():
	DirAccess.remove_absolute(save_path)
	get_tree().quit()
	
	
#func create_user_data() -> Dictionary:
#	var save_dict = {
#		# -------------user data----------------
#		"BEANS" : User.beans,
#		"BEANS_PER_CLICK" : User.beans_per_click,
#		"BEANS_PER_SECOND" : User.beans_per_second,
#
#		"XP" : User.xp,
#		"XP_REQUIREMENT" : User.xp_requirement,
#		"XP_PER_CLICK" : User.xp_per_click,
#		"XP_PER_BUILDING_PURCHASE" : User.xp_per_building_purchase,
#
#		"FERTILIZER" : User.fertilizer,
#
#		# -------------settings---------------
#
#		# volume
#		"MASTER_VOLUME" : Settings.master_volume,
#		"MUSIC_VOLUME" : Settings.music_volume,
#		"SFX_VOLUME" : Settings.sfx_volume,
#
#		# video
#		# DISPLAY MODE: 0 = WINDOWED, 1 = FULLSCREEN, 2 = BORDERLESS
#		"DISPLAY_MODE" : Settings.display_mode,
#		"VSYNC_ENABLED" : Settings.vsync_enabled,
#		"DISPLAY_FPS" : Settings.display_fps,
#
#		# graphics
#		"BEAN_PARTICLES": Settings.bean_particles,
#		"TEXT_PARTICLES": Settings.text_particles
#	}
#	return save_dict
#
#
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
