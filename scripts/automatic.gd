extends Node3D

@export var move_distance: float = 6.5
@export var move_duration: float = 3.0
@onready var anim_player: AnimationPlayer = %AnimationPlayer
var _is_moving: bool = false

func _ready() -> void:
	_start_move()

func _start_move() -> void:
	if _is_moving:
		return
	_is_moving = true
	
	anim_player.play("AnimPack/Walk")
	var target_pos: Vector3 = position + Vector3(move_distance, 0, 0)

	var t = create_tween()
	t.tween_property(self, "position", target_pos, move_duration) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

	await t.finished
	anim_player.play("AnimPack/Idle")
	_is_moving = false

func on_play_pressed() -> void:
	_start_move()

func connect_play_button(button_node_path: NodePath) -> void:
	if not has_node(button_node_path):
		return
	var btn = get_node(button_node_path)
	if btn is Button:
		btn.pressed.connect(Callable(self, "on_play_pressed"))
