extends Node3D
@onready var anim_player := %AnimationPlayer
@onready var audio_player := %AudioStreamPlayer3D
var quote_sounds := []

func _ready():
	load_quotes_from_folder("res://musics/boss-quote")

func idle():
	anim_player.play("AnimPack/Sitting_Idle")
	
func dance():
	anim_player.play("AnimPack/Dance")

func play_quote():
	if quote_sounds.size() > 0:
		var random_quote = quote_sounds.pick_random()
		audio_player.stream = random_quote
		audio_player.play()
	else:
		print("Aucun son disponible!")

func load_quotes_from_folder(folder_path: String):
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".wav"):
				var full_path = folder_path + "/" + file_name
				var audio = load(full_path)
				if audio:
					quote_sounds.append(audio)
			file_name = dir.get_next()
		dir.list_dir_end()
		print("Chargé ", quote_sounds.size(), " fichiers audio")
	else:
		print("Erreur : impossible d'ouvrir le dossier ", folder_path)
