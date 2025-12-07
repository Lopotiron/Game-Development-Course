extends Node3D

@export var rotation_speed: float = 45.0
@export var float_amplitude: float = 0.05
@export var float_speed: float = 2.0

@export var weapon_active = false
var base_y: float = 0.0
var time_passed: float = 0.0


func _ready() -> void:
	base_y = global_transform.origin.y

func _process(delta: float) -> void:
	time_passed += delta
	rotate_y(deg_to_rad(rotation_speed * delta))
	var t = global_transform
	t.origin.y = base_y + sin(time_passed * float_speed) * float_amplitude
	global_transform = t

# This name must match the signal connection exactly
func _on_pick_up_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		$UI/gunHintLabel.text = "Get the gun! (Press E for TPS mode, Left-click to shoot)"
		$UI/gunHintLabel.visible = false
		Global.weapon_active = true
		queue_free()
