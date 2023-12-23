extends Control

signal on_bean_click

const mini_bean_scene = preload("res://scenes/objects/mini_bean.tscn")
const text_particle_scene = preload("res://scenes/objects/text_particle.tscn")

var emit_bean_particles: bool = true
var emit_text_particles: bool = true

@onready var bean_button: TextureButton = $Bean/BeanButton

@export_category("Tween Values")
@export var default_scale: float = 1

@export_group("Hover")
@export var hover_scale: float = 1.1
@export var hover_duration: float = 0.6

@export_group("Click")
@export var click_scale: float = 1.3
@export var click_duration: float = 0.6


# Called when the node enters the scene tree for the first time.
func _ready():
	SettingsSignals.toggle_particles_changed.connect(on_toggle_particles_changed)
	bean_button.scale = Vector2(default_scale, default_scale)
	
	
func on_toggle_particles_changed(particle: String, value: bool):
	if particle == "Bean":
		emit_bean_particles = value
		
		if not value:
			for bean in $"../MiniBeans".get_children():
				bean.queue_free()
	
	elif particle == "Text":
		emit_text_particles = value
		
		if not value:
			for bean in $TextParticles.get_children():
				bean.queue_free()
				

func _on_bean_button_mouse_entered():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(bean_button, "scale", Vector2(hover_scale, hover_scale), hover_duration)
	

func _on_bean_button_mouse_exited():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(bean_button, "scale", Vector2(default_scale, default_scale), hover_duration)


func _on_bean_button_button_down():
	if emit_bean_particles:
		var mini_bean = mini_bean_scene.instantiate()
		var mini_bean_positions = $Bean/Markers.get_children()
		mini_bean.position = mini_bean_positions.pick_random().global_position
		$"../MiniBeans".add_child(mini_bean, true)
	
	if emit_text_particles:
		var text_particle = text_particle_scene.instantiate()
		text_particle.position = get_global_mouse_position()
		$TextParticles.add_child(text_particle, true)
	
	
	User.beans += User.beans_per_click
	User.xp += User.xp_per_click
	
	# click sound
	var random_pitch = randf_range(0.9, 1.1)
	$ClickSound.pitch_scale = random_pitch
	$ClickSound.play()
	
	# click tween
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(bean_button, "scale", Vector2(hover_scale, hover_scale), click_duration).from(Vector2(click_scale, click_scale))
