extends Node

var rng = RandomNumberGenerator.new()

var tracks
var stream
var track_index

func _ready():
	tracks = $Music.get_children()
	
	randomize()
	track_index = rng.randi_range(1, tracks.size())
	stream = tracks[track_index - 1]
	stream.play()
	
	await stream.finished
	
	on_finished()

func on_finished():
	track_index = (track_index + 1) % tracks.size()
	stream = tracks[track_index - 1]
	stream.play()
	
	await stream.finished
	
	var timer = $DurationBetweenSongs
	timer.start()
	await timer.timeout
	
	on_finished()
	
	
