extends Node
class_name Hud

@export var clock_label : Label

var clock : Clock

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock = get_tree().get_first_node_in_group("clockGroup")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_clock_label()

func update_clock_label():
	clock_label.text = clock.time_to_string()
