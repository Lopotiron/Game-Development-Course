extends Node
class_name Hud

@export var clock_label : Label
@onready var player_label = $PlayerBar
@onready var boss_name = $BossName
@onready var boss_label = $BossBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_label.hide()
	boss_label.hide()
	boss_name.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_clock_label()

func update_boss_bar(value):
	boss_label.value = value

func update_life_bar(value):
	player_label.value = value

func update_clock_label():
	clock_label.text = GlobalClock.time_to_string()
