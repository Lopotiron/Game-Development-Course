extends Node3D

@export var spawn_object = preload("res://scenes/document_folder.tscn");
var spawnNumber = 10;
var spawnRate = 5;
var time = 0.0;
@onready var spawn_area_min: Marker3D = $Marker1
@onready var spawn_area_max: Marker3D = $Marker2
@onready var player_pos: Marker3D = $PlayerPos
@onready var hud = $CanvasLayer/Hud
@onready var deathMenu = $CanvasLayer/DeathMenu
var player

# Called when the node enters the scene tree for the first stime.
func _ready() -> void:
	get_player_character()
	var player_ins = player.instantiate()
	add_child(player_ins)
	player_ins.position = %PlayerPos.position
	hud.player_label.show()
	player_ins.life_changed.connect(hud.update_life_bar)
	player_ins.death_signal.connect(deathMenu.death_screen)

func get_player_character():
	match Global.player_character:
		"fahad":
			player = load("res://scenes/player-fahad.tscn")
		"fahad-remastered":
			player = load("res://scenes/player-fahad-remastered.tscn")
		"jeanne":
			player = load("res://scenes/player-jeanne.tscn")
		_:
			player = load("res://scenes/player-fahad.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if (time >= spawnRate):
		spawn()
		time = 0.0

func getRandomPosition() -> Vector3:
	randomize()
	
	var x = randf_range(spawn_area_min.global_position.x, spawn_area_max.global_position.x)
	var z = randf_range(spawn_area_min.global_position.z, spawn_area_max.global_position.z)
	var y = randf_range(spawn_area_min.global_position.y, spawn_area_max.global_position.y)

	return Vector3(x, y, z)

func spawn():
	var destination_position = player_pos.global_position
	for i in range(0, spawnNumber):
		var obj = spawn_object.instantiate()
		obj.position = getRandomPosition()
		obj.setDestinationPosition(destination_position)
		add_child(obj)
