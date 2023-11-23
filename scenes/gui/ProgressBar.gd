extends TextureProgressBar

@export var tween_duration: float = 0.4

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = User.xp_requirement
	value = User.xp
	
	User.connect("xp_changed", on_xp_changed)


func on_xp_changed():
	if User.xp >= User.xp_requirement:
		User.fertilizer += 1
		User.xp -= User.xp_requirement
		User.xp_requirement *= User.xp_multiplier
		
		max_value = User.xp_requirement
		
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(
			$".", 
			"value", 
			User.xp, 
			tween_duration
		).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO).from(User.xp_requirement)
			
		fertilizer_sound()
	else:
		var tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(
			$".", 
			"value", 
			User.xp, 
			tween_duration
		).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)


func fertilizer_sound():
	var sounds = $".".get_children()
	sounds.pick_random().play()
