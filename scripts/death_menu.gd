extends Control
@onready var button_sound = $ButtonClick
var _boss: Node3D

func _ready() -> void:
	$AnimationPlayer.play("blur")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false

func _process(delta: float) -> void:
	pass

func death_screen():
	_boss = $"../../jeanne"
	_boss.process_mode = Node.PROCESS_MODE_ALWAYS
	
	if _boss.has_node("AnimationPlayer"):
		_boss.get_node("AnimationPlayer").process_mode = Node.PROCESS_MODE_ALWAYS
	
	get_tree().paused = true
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_filter = Control.MOUSE_FILTER_STOP
	
	_boss.dance()

func _on_retry_pressed() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	button_sound.play()
	
	_boss.process_mode = Node.PROCESS_MODE_INHERIT
	if _boss.has_node("AnimationPlayer"):
		_boss.get_node("AnimationPlayer").process_mode = Node.PROCESS_MODE_INHERIT
	
	GlobalClock.reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Game/game.tscn")
