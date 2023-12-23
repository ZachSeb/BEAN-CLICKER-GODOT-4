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
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save_stats")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		file.store_line(json_string)
	

func load_file():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
#	var save_nodes = get_tree().get_nodes_in_group("Persist")
#	for i in save_nodes:
#		i.queue_free()

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
		
		loaded_items += 1
		
	print(loaded_items, " ITEMS LOADED")
	file_loaded.emit()

		
func reset_file():
	DirAccess.remove_absolute(save_path)
	get_tree().quit()
