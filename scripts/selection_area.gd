extends Area3D
@onready var fahadAnimPlayer = $"../AnimationPlayer"
@onready var character = get_parent()
@onready var character_selection_scene = get_tree().get_root().get_node("CharacterSelector")
signal character_selected
var is_moving = false  # Pour éviter les clics pendant le déplacement

func _ready() -> void:
	connect("character_selected", character_selection_scene.character_selected)
	fahadAnimPlayer.connect("animation_finished", _on_animation_player_animation_finished)
	
func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("left_click") and not is_moving:
		fahadAnimPlayer.play("AnimPack/Sword_Attack")
		emit_signal("character_selected", character.name)
		%Selection.show()
		
func _hide_selection():
	%Selection.hide()

func _on_mouse_entered() -> void:
	if not is_moving:  # Pas d'idle animation pendant le déplacement
		fahadAnimPlayer.play("AnimPack/Sword_Idle")

func _on_mouse_exited() -> void:
	if not is_moving:  # Pas d'idle animation pendant le déplacement
		fahadAnimPlayer.play("AnimPack/Idle")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "AnimPack/Sword_Attack":
		if not is_moving:  # Revenir à Idle seulement si on ne bouge pas
			fahadAnimPlayer.play("AnimPack/Idle")

# Fonction pour déplacer le personnage avec animation smooth
func move_to_position(target_position: Vector3, duration: float = 0.5):
	is_moving = true
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(character, "position", target_position, duration)
	tween.finished.connect(_on_movement_finished)

func _on_movement_finished():
	is_moving = false
	# Jouer l'animation Idle après le déplacement
	if fahadAnimPlayer.current_animation != "AnimPack/Sword_Attack":
		fahadAnimPlayer.play("AnimPack/Idle")
