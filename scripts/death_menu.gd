extends Control

@onready var button_sound = $ButtonClick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("blur")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func death_screen():
	get_tree().paused = true
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_filter = Control.MOUSE_FILTER_STOP

func _on_retry_pressed() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	button_sound.play()
	GlobalClock.reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/debug.tscn")
