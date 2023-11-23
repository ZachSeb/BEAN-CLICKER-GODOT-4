extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var x_vel_values = [randf_range(-500, -200), randf_range(200, 500)]
	var x_vel = x_vel_values.pick_random()
	var y_vel = randf_range(-800, -600)
	
	var angular_velocity_values = [randf_range(-10, 6), randf_range(6, 10)]
	angular_velocity = angular_velocity_values.pick_random()
	linear_velocity = Vector2(x_vel, y_vel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if position.y >= 800:
		queue_free()
