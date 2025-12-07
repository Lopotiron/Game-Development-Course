extends Node3D

@export var move_offset: Vector3 = Vector3.ZERO
@export var travel_time: float = 2.0

var base_position: Vector3
var target_position: Vector3
var timer: float = 0.0
var last_position: Vector3
var platform_velocity: Vector3 = Vector3.ZERO

func _ready():
	base_position = global_transform.origin
	target_position = base_position + move_offset
	last_position = base_position

func _process(delta: float):
	timer += delta / travel_time
	var t = pingpong(timer, 1.0)

	var new_pos = base_position.lerp(target_position, t)
	platform_velocity = (new_pos - last_position) / delta
	global_transform.origin = new_pos

	last_position = new_pos
