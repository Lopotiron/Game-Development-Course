extends Control

@onready var play_button = %Play
@onready var settings_button = %Settings
@onready var quit_button = %Quit
@onready var button_sound = $ButtonClick
@onready var player = %automatic_fahad

@onready var circle_rect: ColorRect = $Blur

func _ready():
	%Play.pressed.connect(play)
	%Quit.pressed.connect(quit_game)
	%SettingsContainer.hide()

func play():
	button_sound.play()
	player._start_move()
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
	get_tree().change_scene_to_file("res://scenes/Player/character_selector.tscn")
	
func quit_game():
	button_sound.play()
	get_tree().quit()

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

func on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Level1.tscn")

func on_quit_pressed():
	get_tree().quit()
