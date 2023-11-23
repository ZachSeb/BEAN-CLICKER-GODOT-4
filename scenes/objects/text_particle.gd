extends Control

@export var speed: float = 100


func _ready():
	$Label.text = str("+", User.beans_per_click)


func _on_timer_timeout():
	queue_free()
	
	
func _process(delta):
	position.y -= speed * delta

