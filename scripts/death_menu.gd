extends Control
@onready var button_sound = $ButtonClick
@onready var _boss = %jeanne

func _ready() -> void:
	$AnimationPlayer.play("blur")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false

func _process(delta: float) -> void:
	pass

func death_screen():
	# Permettre au boss de continuer à s'animer pendant la pause
	_boss.process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Si le boss a un AnimationPlayer, il faut aussi le configurer
	if _boss.has_node("AnimationPlayer"):
		_boss.get_node("AnimationPlayer").process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Mettre le jeu en pause
	get_tree().paused = true
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_filter = Control.MOUSE_FILTER_STOP
	
	# Lancer l'animation de danse
	_boss.dance()

func _on_retry_pressed() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	button_sound.play()
	
	# Remettre le boss en mode normal
	_boss.process_mode = Node.PROCESS_MODE_INHERIT
	if _boss.has_node("AnimationPlayer"):
		_boss.get_node("AnimationPlayer").process_mode = Node.PROCESS_MODE_INHERIT
	
	GlobalClock.reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/debug.tscn")
