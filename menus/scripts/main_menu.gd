extends Control

@onready var button_sound = $ButtonClick

func _ready():
	%Play.pressed.connect(play)
	%Quit.pressed.connect(quit_game)
	%SettingsContainer.hide()

func play():
	button_sound.play()
	get_tree().change_scene_to_file("res://scenes/character_selector.tscn")

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
