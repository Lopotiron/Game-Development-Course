extends Control
class_name PauseMenu

@onready var button_sound = $ButtonClick

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	%SettingsContainer.hide()

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
	button_sound.play()
	resume()

func _on_quit_pressed() -> void:
	button_sound.play()
	get_tree().quit(0)


func _on_settings_pressed() -> void:
	button_sound.play()

func _on_volume_value_changed(value: float) -> void:
	button_sound.play()
	AudioServer.set_bus_volume_db(0, value - 20)

func _on_mute_volume_toggled(toggled_on: bool) -> void:
	button_sound.play()
	AudioServer.set_bus_mute(0, toggled_on)

func _on_resolution_item_selected(index: int) -> void:
	button_sound.play()
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1280, 720))

func _on_full_screen_toggled(toggled_on: bool) -> void:
	button_sound.play()
	if (toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_close_pressed() -> void:
	button_sound.play()
