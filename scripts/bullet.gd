extends Node3D
class_name Bullet

var bullet_speed = 10
var fire_rate = 1
var can_fire: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -bullet_speed) * delta
