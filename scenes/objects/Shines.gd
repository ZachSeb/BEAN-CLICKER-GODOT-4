extends Control

@export var Shine1RotationSpeed = 20
@export var Shine2RotationSpeed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$Shine1.pivot_offset = Vector2($Shine1.size.x / 2, $Shine1.size.y / 2)
	$Shine2.pivot_offset = Vector2($Shine2.size.x / 2, $Shine2.size.y / 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Shine1.rotation_degrees += Shine1RotationSpeed * delta
	$Shine2.rotation_degrees += Shine2RotationSpeed * delta
