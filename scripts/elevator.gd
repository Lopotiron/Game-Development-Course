extends Node3D

@export var travel_vector: Vector3
@export var travel_time: float = 2.0

var base_pos: Vector3
var active := false

func _ready():
	base_pos = global_position

func activate():
	if active: return
	active = true
	var tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		base_pos + travel_vector,
		travel_time
	)

func reset():
	active = false
	var tween = create_tween()
	tween.tween_property(
		self,
		"global_position",
		base_pos,
		travel_time
	)
