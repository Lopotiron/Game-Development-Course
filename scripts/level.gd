extends Node3D

var player

func _ready() -> void:
	GlobalClock.on()
	get_player_character()
	var player_ins = player.instantiate()
	add_child(player_ins)
	player_ins.position = %PlayerPos.position

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
