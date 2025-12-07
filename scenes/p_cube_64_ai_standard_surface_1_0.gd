extends Node3D

@export var rotation_speed: float = 45.0     # degrees per second
@export var float_amplitude: float = 0.1     # how high it goes up/down
@export var float_speed: float = 2.0         # speed of the up/down motion

var base_y: float = 0.0
var time_passed: float = 0.0

func _ready() -> void:
	base_y = global_transform.origin.y

func _process(delta: float) -> void:
	time_passed += delta

	# Spin
	rotate_y(deg_to_rad(rotation_speed * delta))

	# Float (sin wave)
	var new_y = base_y + sin(time_passed * float_speed) * float_amplitude
	global_transform.origin.y = new_y
