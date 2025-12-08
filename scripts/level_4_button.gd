extends Node3D

@export var top_offset: float = 6.0
@export var move_time: float = 2.0
var base_pos: Vector3
@onready var circle_rect: ColorRect = $Blur

func _ready():
	base_pos = global_position

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_P:
		toggle_elevator()

func toggle_elevator():
	var target := base_pos
	target.y += top_offset

	var tween = create_tween()
	tween.tween_property(self, "global_position", target, move_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_blur_and_change_scene()
	
func _blur_and_change_scene() -> void:
	var tween := create_tween()
	
	circle_rect.material.set("shader_parameter/radius", 1.2)
	tween.tween_property(
		circle_rect.material,
		"shader_parameter/radius",
		0.0,
		1.2 
	)

	await tween.finished
	get_tree().change_scene_to_file("res://scenes/BossFight/boss_fight.tscn")
	
