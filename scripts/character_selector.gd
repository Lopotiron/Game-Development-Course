extends Node3D
var current_character_name: String
@onready var current_character: Node3D
var selection_area = preload("res://scenes/selection_area.tscn")
var is_swapping = false

func _ready() -> void:
	%Start.pressed.connect(play)
	
	current_character = %Characters.get_node("fahad")
	current_character_name = current_character.name
	%CharacterLabel.text = current_character_name

	for character in %Characters.get_children():
		var selection_area_ins = selection_area.instantiate()
		character.add_child(selection_area_ins)

func play():
	if current_character_name:
		Global.set_player_character(current_character_name)
	get_tree().change_scene_to_file("res://scenes/debug.tscn")
	
func character_selected(character_name):
	if is_swapping:
		return
	
	# Trouver le personnage cliqué
	var clicked_character = null
	var clicked_area = null
	for character in %Characters.get_children():
		if character.name == character_name:
			clicked_character = character
			clicked_area = character.get_child(character.get_child_count()-1)
			break
	
	if clicked_character == null or clicked_area == null:
		return
	
	is_swapping = true
	
	if current_character == null:
		# Premier personnage sélectionné
		current_character = clicked_character
		clicked_area.move_to_position(Vector3(0, 0, 3))
		await get_tree().create_timer(0.5).timeout  # Attendre la fin de l'animation
		is_swapping = false
	else:
		# Swap : échanger les positions avec animation
		var current_area = current_character.get_child(current_character.get_child_count()-1)
		var temp_position = current_character.position
		
		# Démarrer les deux animations en parallèle
		current_area.move_to_position(clicked_character.position)
		clicked_area.move_to_position(temp_position)
		
		# Attendre que les deux animations soient finies
		await get_tree().create_timer(0.5).timeout
		
		current_character = clicked_character
		is_swapping = false
	
	# Mettre à jour le label
	current_character_name = character_name
	%CharacterLabel.text = current_character_name
	
	# Cacher les autres sélections
	for character in %Characters.get_children():
		character.get_child(character.get_child_count()-1)._hide_selection()
