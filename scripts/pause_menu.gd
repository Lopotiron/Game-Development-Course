extends Control
class_name PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _process(delta: float) -> void:
	test_esc()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = true
func test_esc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_quit_pressed() -> void:
	get_tree().quit(0)
