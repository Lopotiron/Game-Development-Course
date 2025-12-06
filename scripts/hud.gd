extends Node
class_name Hud

@export var clock_label : Label
@onready var player_label = $PlayerBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_clock_label()

func update_life_bar(value):
	player_label.value = value

func update_clock_label():
	clock_label.text = GlobalClock.time_to_string()
