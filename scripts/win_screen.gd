extends Control

@onready var time_label: Label = $Time
@onready var button_sound = $ButtonSound
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_label.text = GlobalClock.time_to_string()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_filter = Control.MOUSE_FILTER_STOP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_pressed() -> void:
	button_sound.play()
	GlobalClock.reset()
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")


func _on_quit_pressed() -> void:
	button_sound.play()
	get_tree().quit(0)
